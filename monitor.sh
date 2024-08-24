#!/bin/bash

display_cpu() {
    echo "Top 10 Applications by CPU Usage:"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
}

display_memory() {
    echo "Memory Usage:"
    free -h
    echo "Swap Memory Usage:"
    swapon --show
}

display_network() {
    echo "Network Monitoring:"
    echo "Number of concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l

    echo "Packet drops:"
    netstat -i | grep -E '^[a-zA-Z0-9]' | awk '{print $1 " " $4 " " $8}' | awk '{print "Interface: " $1 ", RX Drops: " $2 ", TX Drops: " $3}'

    echo "Network usage (MB in and out):"
    vnstat --oneline | awk -F';' '{print "Incoming MB: " $7/1024 ", Outgoing MB: " $8/1024}'
}

display_disk() {
    echo "Disk Usage:"
    df -h | awk '{print $1 " " $5}' | grep -vE '^Filesystem|tmpfs|cdrom' | awk '$2 > 80 {print $1 " is using more than 80% space"}'
    df -h
}

display_load() {
    echo "System Load Average:"
    uptime
    echo "CPU Usage Breakdown:"
    top -bn1 | grep 'Cpu(s)'
}

display_processes() {
    echo "Number of Active Processes:"
    ps aux | wc -l
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

display_services() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done
}

case "$1" in
    -cpu)
        display_cpu
        ;;
    -memory)
        display_memory
        ;;
    -network)
        display_network
        ;;
    -disk)
        display_disk
        ;;
    -load)
        display_load
        ;;
    -processes)
        display_processes
        ;;
    -services)
        display_services
        ;;
    *)
        echo "Usage: $0 {-cpu|-memory|-network|-disk|-load|-processes|-services}"
        ;;
esac
