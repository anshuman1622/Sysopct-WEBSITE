#!/bin/bash

VERSION="v0.1.0"

help_menu() {
    echo "Usage: sysopctl [command] [options]"
    echo "Commands:"
    echo "  service list                - List all active services."
    echo "  service start <name>        - Start a specific service."
    echo "  service stop <name>         - Stop a specific service."
    echo "  system load                 - View system load averages."
    echo "  disk usage                  - Show disk usage by partition."
    echo "  process monitor             - Monitor real-time processes."
    echo "  logs analyze                - Analyze recent critical logs."
    echo "  backup <path>               - Backup system files."
    echo "  --help                      - Display this help message."
    echo "  --version                   - Display version information."
}

version_info() {
    echo "sysopctl $VERSION"
}

list_services() { systemctl list-units --type=service; }
start_service() { systemctl start "$1" && echo "Service $1 started."; }
stop_service() { systemctl stop "$1" && echo "Service $1 stopped."; }
system_load() { uptime; }
disk_usage() { df -h; }
process_monitor() { top; }
analyze_logs() { journalctl -p crit --no-pager; }
backup_files() { rsync -av "$1" "$1.bak" && echo "Backup completed."; }

case "$1" in
    service)
        case "$2" in
            list) list_services ;;
            start) start_service "$3" ;;
            stop) stop_service "$3" ;;
            *) echo "Invalid service command. Use --help for usage."; exit 1 ;;
        esac
        ;;
    system)
        [ "$2" == "load" ] && system_load || echo "Invalid system command. Use --help for usage."
        ;;
    disk)
        [ "$2" == "usage" ] && disk_usage || echo "Invalid disk command. Use --help for usage."
        ;;
    process)
        [ "$2" == "monitor" ] && process_monitor || echo "Invalid process command. Use --help for usage."
        ;;
    logs)
        [ "$2" == "analyze" ] && analyze_logs || echo "Invalid logs command. Use --help for usage."
        ;;
    backup)
        backup_files "$2"
        ;;
    --help)
        help_menu
        ;;
    --version)
        version_info
        ;;
    *)
        echo "Invalid command. Use --help for usage."
        ;;
esac
