/**
 * @file test_logging.c
 * @brief Basic file-sink verification for WSP Logging.
 */

#include "wsp_log.h"

#include <stdio.h>
#include <string.h>

typedef struct test_sink {
    char bytes[512];
    size_t length;
    int closed;
    int status;
} test_sink;

static int test_sink_write(void *context, const char *bytes, size_t length)
{
    test_sink *sink = (test_sink *)context;
    if (sink->status != 0) return sink->status;
    if (length >= sizeof(sink->bytes) - sink->length) return 90;
    memcpy(sink->bytes + sink->length, bytes, length);
    sink->length += length;
    sink->bytes[sink->length] = '\0';
    return 0;
}

static void test_sink_close(void *context)
{
    ((test_sink *)context)->closed++;
}

/**
 * Exercise the file sink and verify its stable record content.
 *
 * @param argc Argument count.
 * @param argv Arguments; the first argument is the output log path.
 * @return Zero on success and nonzero on failure.
 */
int main(int argc, char **argv)
{
    char line[256];
    FILE *input;
    wsp_logger logger;
    test_sink sink;
    test_sink failed_sink;

    if (argc != 2) {
        return 2;
    }
    wsp_log_init(&logger);
    memset(&sink, 0, sizeof(sink));
    memset(&failed_sink, 0, sizeof(failed_sink));
    wsp_log_set_console_level(&logger, WSP_LOG_DEBUG);
    wsp_log_set_color_mode(&logger, WSP_LOG_COLOR_NEVER);
    if (wsp_log_open_file(&logger, argv[1], 0) != 0) {
        return 3;
    }
    if (wsp_log_set_sink(&logger, test_sink_write, test_sink_close, &sink) != 0) {
        return 8;
    }
    wsp_log_write(&logger, WSP_LOG_DEBUG, "%s=%d", "value", 42);
    if (strstr(sink.bytes, " [DEBUG] value=42\n") == NULL ||
        wsp_log_sink_status(&logger) != 0) return 9;
    failed_sink.status = 23;
    if (wsp_log_set_sink(&logger, test_sink_write, test_sink_close,
            &failed_sink) != 0 || sink.closed != 1) return 10;
    wsp_log_write(&logger, WSP_LOG_INFO, "sink failure");
    if (wsp_log_sink_status(&logger) != 23) return 11;
    wsp_log_close(&logger);
    if (sink.closed != 1 || failed_sink.closed != 1) return 12;

    input = fopen(argv[1], "r");
    if (input == NULL) {
        return 4;
    }
    if (fgets(line, sizeof(line), input) == NULL) {
        fclose(input);
        return 5;
    }
    fclose(input);
    if (strstr(line, " [DEBUG] value=42") == NULL) {
        return 6;
    }
    if (strstr(line, "\x1b[") != NULL) {
        return 7;
    }
    return 0;
}
