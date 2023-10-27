#!/bin/bash

# Check if the user has root access
if [[ $(id -u) -ne 0 ]]; then
    echo "This script requires root privileges."
    exit 1
fi

# Check the operating system
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    OS=$ID
else
    echo "Unable to determine the operating system."
    exit 1
fi

# Install iotop based on the operating system
if [[ $OS == "debian" || $OS == "ubuntu" ]]; then
    apt-get update
    apt-get install -y gcc iotop
elif [[ $OS == "rhel" || $OS == "centos" || $OS == "almalinux" || $OS == "rocky" || $OS == "fedora" ]]; then
    if [[ $OS == "rhel" ]]; then
        pkg_manager="dnf"
    else
        pkg_manager="yum"
    fi
    $pkg_manager install -y gcc iotop
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

echo "Dependencies installed successfully."

# Compile the binaries in /bin
gcc -o /bin/top_process_cpu ./sources/top_process_cpu.c
gcc -o /bin/top_process_io ./sources/top_process_io.c

echo "top_process_cpu and top_process_io installed"

# Create logrotate configuration file
cat << EOF > /etc/logrotate.d/top_process
/var/log/top_process/*.log {
    daily
    missingok
    notifempty
    rotate 30
    copytruncate
}
EOF

# Create rsyslog configuration file
cat << EOF > /etc/rsyslog.d/top_process.conf
if \$programname == 'top_process_cpu' then /var/log/top_process/cpu.log
if \$programname == 'top_process_io' then /var/log/top_process/io.log
& ~
EOF

# Restart rsyslog service
systemctl restart rsyslog

# Create cron file to execute the binaries every 1 minute
cat << EOF > /etc/cron.d/top_process
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
* * * * * root /bin/top_process_cpu
* * * * * root /bin/top_process_io
EOF

echo "Configuration files created successfully."
echo "All set! You can now check the logs at /var/log/top_process every 1 minute."
