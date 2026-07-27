/**
 * @file wsp_log.h
 * @brief Portable console and file logging for WSP projects.
 */

#ifndef WSP_LOG_H
#define WSP_LOG_H

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

/** Severity levels understood by the logger. */
typedef enum wsp_log_level {
    WSP_LOG_DEBUG = 0, /**< Diagnostic information. */
    WSP_LOG_INFO = 1,  /**< Normal progress. */
    WSP_LOG_PASS = 2,  /**< Successful completion. */
    WSP_LOG_WARN = 3,  /**< Recoverable concern. */
    WSP_LOG_ERROR = 4, /**< Operation failure. */
    WSP_LOG_OFF = 5    /**< Disable a sink. */
} wsp_log_level;

/** Color-selection modes for console output. */
typedef enum wsp_log_color_mode {
    WSP_LOG_COLOR_AUTO = 0, /**< Color only an interactive terminal. */
    WSP_LOG_COLOR_NEVER = 1, /**< Never emit terminal colors. */
    WSP_LOG_COLOR_ALWAYS = 2 /**< Emit colors even when redirected. */
} wsp_log_color_mode;

/** Mutable state for one logger instance. */
typedef struct wsp_logger {
    FILE *file;                    /**< Optional owned file stream. */
    wsp_log_level console_level;   /**< Minimum console severity. */
    wsp_log_level file_level;      /**< Minimum file severity. */
    wsp_log_color_mode color_mode; /**< Console color policy. */
} wsp_logger;

/**
 * Initialize a logger with INFO console output and no file sink.
 *
 * @param logger Logger to initialize.
 */
void wsp_log_init(wsp_logger *logger);

/**
 * Set the minimum severity written to the console.
 *
 * @param logger Initialized logger.
 * @param level Minimum severity, or WSP_LOG_OFF.
 */
void wsp_log_set_console_level(wsp_logger *logger, wsp_log_level level);

/**
 * Set the minimum severity written to the log file.
 *
 * @param logger Initialized logger.
 * @param level Minimum severity, or WSP_LOG_OFF.
 */
void wsp_log_set_file_level(wsp_logger *logger, wsp_log_level level);

/**
 * Set the console color-selection mode.
 *
 * @param logger Initialized logger.
 * @param mode Requested color policy.
 */
void wsp_log_set_color_mode(wsp_logger *logger,
    wsp_log_color_mode mode);

/**
 * Open or replace the logger's plain-text file sink.
 *
 * Parent directories must already exist. An existing sink remains active if
 * the new file cannot be opened.
 *
 * @param logger Initialized logger.
 * @param path File to open.
 * @param append Nonzero to append; zero to truncate.
 * @return Zero on success and nonzero on failure.
 */
int wsp_log_open_file(wsp_logger *logger, const char *path, int append);

/**
 * Close the logger's file sink, if one is open.
 *
 * @param logger Initialized logger.
 */
void wsp_log_close(wsp_logger *logger);

/**
 * Write one formatted record to every enabled sink.
 *
 * @param logger Initialized logger.
 * @param level Record severity.
 * @param format printf-compatible message format.
 * @param ... Values referenced by format.
 */
void wsp_log_write(wsp_logger *logger, wsp_log_level level,
    const char *format, ...);

#ifdef __cplusplus
}
#endif

#endif
