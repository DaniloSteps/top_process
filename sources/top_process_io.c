#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>

int main() {
    char command[] = "iotop -b | head -n 8";
    char output[1024];

    // Open the syslog
    openlog("top_process_io", 0, LOG_LOCAL1);

    // Open a pipe to execute the command and read its output
    FILE *pipe = popen(command, "r");
    if (pipe == NULL) {
        printf("Error executing command.\n");
        return 1;
    }

    // Read the output of the command and print it to the console
    while (fgets(output, sizeof(output), pipe) != NULL) {
	syslog(LOG_DEBUG , "%s", output);
    }

    // Close the pipe
    pclose(pipe);

    return 0;
}
