# top_process

This is a small Unix program designed to monitor and log the process consuming the most CPU and IO at any given minute. It was created out of the necessity to have a record of system resource usage by process for troubleshooting purposes.

## Background

The motivation behind developing this program was to gain a deeper understanding of creating programs for Unix systems and to address the need for monitoring and logging system resource usage.

## What it does

The `top_process` program logs the output of `top` and `iotop`, filtering to show only the top five processes and the header with various information about the system at the moment (such as uptime, number of users, and load average). It sets up `rsyslog` and `logrotate` to organize the logs produced in a folder inside `/var/log`, rotates the log file every day, and keeps only 30 days' worth of logs.

The code is simple and can easily be modified to log more processes, retain the logs for different amounts of days, and implement additional functionality as needed.

## Future Enhancements

Although this program serves its purpose as a basic system monitoring tool, there are several potential areas for improvement and future enhancements, including:

- Transforming the program into a daemon to run continuously in the background.
- Implementing additional functionality to monitor and log other system resources, such as memory usage and network activity.
- Creating a package for easier installation and distribution on various Unix-based systems.
- Enhancing the program's user interface and adding command-line options for customization.
- Adding an uninstaller to remove the program and its associated configurations.

## Usage

1. Clone the repository:

    ```shell
    git clone https://github.com/DaniloSteps/top_process.git
    ```

2. Navigate to the project directory:

    ```shell
    cd top_process
    ```

3. Run the installer:

    ```shell
    ./install.sh
    ```

4. The program will monitor the system and log the process consuming the most CPU and IO at each minute interval in the `/var/log/top_process` folder.

## Compatibility

This program has been developed to run on Unix-based systems, including:

- Debian and Ubuntu
- RHEL, CentOS, AlmaLinux, Rocky Linux, and Fedora

Please note that the program may require additional modifications or adaptations to work on different Unix variants or versions.

## License

This project is licensed under the [GPL3 License](LICENSE).
