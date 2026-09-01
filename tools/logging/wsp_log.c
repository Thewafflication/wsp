/**
 * @file wsp_log.c
 * @brief Implementation of portable WSP logging.
 */

#include "wsp_log.h"

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*
 * C99 defines va_copy, but some otherwise usable compilers and libraries do
 * not expose it. Prefer a standard or compiler copy primitive when present;
 * older implementations commonly use an assignment-compatible va_list.
 * A target with a different representation may define WSP_VA_COPY itself.
 */
#if !defined(WSP_VA_COPY)
#if defined(WSP_LOG_FORCE_VA_COPY_ASSIGNMENT)
#define WSP_VA_COPY(destination, source) ((destination) = (source))
#elif defined(va_copy)
#define WSP_VA_COPY(destination, source) va_copy(destination, source)
#elif defined(__va_copy)
#define WSP_VA_COPY(destination, source) __va_copy(destination, source)
#else
#define WSP_VA_COPY(destination, source) ((destination) = (source))
#endif
#endif

#if !defined(WSP_LOG_NO_TTY) && defined(_WIN32)
#include <io.h>
#define WSP_ISATTY _isatty
#define WSP_FILENO _fileno
#elif !defined(WSP_LOG_NO_TTY)
#include <unistd.h>
#define WSP_ISATTY isatty
#define WSP_FILENO fileno
#endif

/** Number of severity levels that may be written. */
#define WSP_LEVEL_COUNT 5

/** Display tags indexed by wsp_log_level. */
static const char *const wsp_tags[WSP_LEVEL_COUNT] = {
    "DEBUG", "INFO ", "PASS ", "WARN ", "ERROR"
};

/** ANSI colors indexed by wsp_log_level. */
static const char *const wsp_colors[WSP_LEVEL_COUNT] = {
    "\x1b[33m", "\x1b[34m", "\x1b[32m", "\x1b[93m", "\x1b[31m"
};

/** Determine whether a severity value may be indexed safely. */
static int wsp_level_is_valid(wsp_log_level level)
{
    return level >= WSP_LOG_DEBUG && level <= WSP_LOG_ERROR;
}

/** Determine whether NO_COLOR has disabled terminal colors. */
static int wsp_no_color(void)
{
    const char *value = getenv("NO_COLOR");
    return value != NULL && value[0] != '\0';
}

/** Determine whether color should be used for a stream. */
static int wsp_use_color(const wsp_logger *logger, FILE *stream)
{
    if (logger->color_mode == WSP_LOG_COLOR_NEVER || wsp_no_color()) {
        return 0;
    }
    if (logger->color_mode == WSP_LOG_COLOR_ALWAYS) {
        return 1;
    }
#if defined(WSP_LOG_NO_TTY)
    (void)stream;
    return 0;
#else
    return WSP_ISATTY(WSP_FILENO(stream)) != 0;
#endif
}

/** Write an ISO 8601 UTC timestamp to a stream. */
static void wsp_write_timestamp(FILE *stream)
{
    char value[32];
    time_t now = time(NULL);
    struct tm *utc_value;

    utc_value = gmtime(&now);
    if (utc_value == NULL) {
        fputs("0000-00-00T00:00:00Z", stream);
        return;
    }
    if (strftime(value, sizeof(value), "%Y-%m-%dT%H:%M:%SZ",
            utc_value) == 0) {
        fputs("0000-00-00T00:00:00Z", stream);
        return;
    }
    fputs(value, stream);
}

/** Format an ISO 8601 UTC timestamp without exposing a stream. */
static void wsp_format_timestamp(char *value, size_t value_size)
{
    time_t now = time(NULL);
    struct tm *utc_value = gmtime(&now);
    if (utc_value == NULL || strftime(value, value_size,
            "%Y-%m-%dT%H:%M:%SZ", utc_value) == 0) {
        strcpy(value, "0000-00-00T00:00:00Z");
    }
}

/** Write one console record using an existing argument list. */
static void wsp_write_console(const wsp_logger *logger,
    wsp_log_level level, const char *format, va_list arguments)
{
    FILE *stream = level == WSP_LOG_ERROR ? stderr : stdout;
    int color = wsp_use_color(logger, stream);

    if (color) {
        fputs(wsp_colors[level], stream);
    }
    fprintf(stream, "[%s]", wsp_tags[level]);
    if (color) {
        fputs("\x1b[0m", stream);
    }
    fputc(' ', stream);
    vfprintf(stream, format, arguments);
    fputc('\n', stream);
    fflush(stream);
}

/** Write one plain file record using an existing argument list. */
static void wsp_write_file(FILE *stream, wsp_log_level level,
    const char *format, va_list arguments)
{
    wsp_write_timestamp(stream);
    fprintf(stream, " [%s] ", wsp_tags[level]);
    vfprintf(stream, format, arguments);
    fputc('\n', stream);
    fflush(stream);
}

/** Format and deliver one complete record to an ABI-safe byte sink. */
static void wsp_write_sink(wsp_logger *logger, wsp_log_level level,
    const char *format, va_list arguments)
{
    va_list measure;
    char timestamp[32];
    char *message;
    char *record;
    int message_length;
    int record_length;
    int status;

    WSP_VA_COPY(measure, arguments);
    message_length = vsnprintf(NULL, 0, format, measure);
    va_end(measure);
    if (message_length < 0) {
        logger->sink_status = -1;
        return;
    }
    message = (char *)malloc((size_t)message_length + 1);
    if (message == NULL) {
        logger->sink_status = -1;
        return;
    }
    vsnprintf(message, (size_t)message_length + 1, format, arguments);
    wsp_format_timestamp(timestamp, sizeof(timestamp));
    record_length = snprintf(NULL, 0, "%s [%s] %s\n", timestamp,
        wsp_tags[level], message);
    if (record_length < 0) {
        logger->sink_status = -1;
        free(message);
        return;
    }
    record = (char *)malloc((size_t)record_length + 1);
    if (record == NULL) {
        logger->sink_status = -1;
        free(message);
        return;
    }
    snprintf(record, (size_t)record_length + 1, "%s [%s] %s\n",
        timestamp, wsp_tags[level], message);
    status = logger->sink_write(logger->sink_context, record,
        (size_t)record_length);
    if (status != 0) logger->sink_status = status;
    free(record);
    free(message);
}

/** @copydoc wsp_log_init */
void wsp_log_init(wsp_logger *logger)
{
    if (logger == NULL) {
        return;
    }
    logger->file = NULL;
    logger->console_level = WSP_LOG_INFO;
    logger->file_level = WSP_LOG_DEBUG;
    logger->color_mode = WSP_LOG_COLOR_AUTO;
    logger->sink_write = NULL;
    logger->sink_close = NULL;
    logger->sink_context = NULL;
    logger->sink_status = 0;
}

/** @copydoc wsp_log_set_console_level */
void wsp_log_set_console_level(wsp_logger *logger, wsp_log_level level)
{
    if (logger != NULL) {
        logger->console_level = level;
    }
}

/** @copydoc wsp_log_set_file_level */
void wsp_log_set_file_level(wsp_logger *logger, wsp_log_level level)
{
    if (logger != NULL) {
        logger->file_level = level;
    }
}

/** @copydoc wsp_log_set_color_mode */
void wsp_log_set_color_mode(wsp_logger *logger,
    wsp_log_color_mode mode)
{
    if (logger != NULL) {
        logger->color_mode = mode;
    }
}

/** @copydoc wsp_log_open_file */
int wsp_log_open_file(wsp_logger *logger, const char *path, int append)
{
    FILE *new_file;

    if (logger == NULL || path == NULL) {
        return -1;
    }
    new_file = fopen(path, append ? "a" : "w");
    if (new_file == NULL) {
        return -1;
    }
    if (logger->file != NULL) {
        fclose(logger->file);
    }
    logger->file = new_file;
    return 0;
}

/** @copydoc wsp_log_set_sink */
int wsp_log_set_sink(wsp_logger *logger, wsp_log_sink_write_fn write_callback,
    wsp_log_sink_close_fn close_callback, void *context)
{
    if (logger == NULL || write_callback == NULL) return -1;
    if (logger->sink_close != NULL) logger->sink_close(logger->sink_context);
    logger->sink_write = write_callback;
    logger->sink_close = close_callback;
    logger->sink_context = context;
    logger->sink_status = 0;
    return 0;
}

/** @copydoc wsp_log_sink_status */
int wsp_log_sink_status(const wsp_logger *logger)
{
    return logger == NULL ? -1 : logger->sink_status;
}

/** @copydoc wsp_log_close */
void wsp_log_close(wsp_logger *logger)
{
    if (logger != NULL && logger->file != NULL) {
        fclose(logger->file);
        logger->file = NULL;
    }
    if (logger != NULL && logger->sink_close != NULL) {
        logger->sink_close(logger->sink_context);
    }
    if (logger != NULL) {
        logger->sink_write = NULL;
        logger->sink_close = NULL;
        logger->sink_context = NULL;
    }
}

/** @copydoc wsp_log_write */
void wsp_log_write(wsp_logger *logger, wsp_log_level level,
    const char *format, ...)
{
    va_list arguments;
    va_list copy;
    int write_console;
    int write_file;
    int write_sink;

    if (logger == NULL || format == NULL || !wsp_level_is_valid(level)) {
        return;
    }
    write_console = level >= logger->console_level;
    write_file = logger->file != NULL && level >= logger->file_level;
    write_sink = logger->sink_write != NULL && level >= logger->file_level;
    va_start(arguments, format);
    if (write_console) {
        WSP_VA_COPY(copy, arguments);
        wsp_write_console(logger, level, format, copy);
        va_end(copy);
    }
    if (write_file) {
        WSP_VA_COPY(copy, arguments);
        wsp_write_file(logger->file, level, format, copy);
        va_end(copy);
    }
    if (write_sink) {
        WSP_VA_COPY(copy, arguments);
        wsp_write_sink(logger, level, format, copy);
        va_end(copy);
    }
    va_end(arguments);
}
