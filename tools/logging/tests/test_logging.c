/**
 * @file test_logging.c
 * @brief Basic file-sink verification for WSP Logging.
 */

#include "wsp_log.h"

#include <stdio.h>
#include <string.h>

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

    if (argc != 2) {
        return 2;
    }
    wsp_log_init(&logger);
    wsp_log_set_console_level(&logger, WSP_LOG_OFF);
    if (wsp_log_open_file(&logger, argv[1], 0) != 0) {
        return 3;
    }
    wsp_log_write(&logger, WSP_LOG_DEBUG, "value=%d", 42);
    wsp_log_close(&logger);

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
