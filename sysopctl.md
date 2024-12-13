# sysopctl

## Overview
`sysopctl` is a custom command-line tool written in Bash for managing system resources on a Linux-based system. It provides functionality to monitor and manage services, system load, disk usage, logs, and more. This README provides a step-by-step guide to set up, use, and understand the command.

---

## Features
- **List Running Services:** Displays all active services.
- **Manage Services:** Start and stop specific services.
- **View System Load:** Show current system load averages.
- **Check Disk Usage:** Display partition-wise disk usage.
- **Monitor Processes:** View real-time process activity.
- **Analyze System Logs:** Extract critical log entries.
- **Backup Files:** Backup directories using `rsync`.
- **Help and Version Options:** User-friendly options for usage guidance.

---

## Requirements
- Linux system with Bash shell.
- Essential tools: `systemctl`, `journalctl`, `uptime`, `df`, `top`, `rsync`.
- **Optional:** WSL (Windows Subsystem for Linux) or Docker for testing on non-Linux systems.

---

## Installation

### Step 1: Set Up Environment
1. Use a Linux system (or WSL/Docker).
2. Verify that essential tools are installed:
   ```bash
   sudo apt install coreutils rsync
   ```

### Step 2: Create the Script
1. Create a file named `sysopctl`:
   ```bash
   nano sysopctl
   ```
2. Paste the following code into the file:
   ```bash
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
   ```

3. Save and exit: `Ctrl+O`, then `Ctrl+X`.

### Step 3: Make Script Executable
1. Run the following command:
   ```bash
   chmod +x sysopctl
   ```
2. Move it to a directory in your `PATH`:
   ```bash
   sudo mv sysopctl /usr/local/bin/
   ```

---

## Usage
Run the following commands to test the script:

### Basic Commands
1. **Display Help**:
   ```bash
   sysopctl --help
   ```
2. **Check Version**:
   ```bash
   sysopctl --version
   ```

### System Management
1. **List Running Services**:
   ```bash
   sysopctl service list
   ```
2. **Start a Service**:
   ```bash
   sysopctl service start ssh
   ```
3. **Stop a Service**:
   ```bash
   sysopctl service stop ssh
   ```
4. **View System Load**:
   ```bash
   sysopctl system load
   ```
5. **Check Disk Usage**:
   ```bash
   sysopctl disk usage
   ```
6. **Monitor Processes**:
   ```bash
   sysopctl process monitor
   ```
7. **Analyze Logs**:
   ```bash
   sysopctl logs analyze
   ```
8. **Backup Files**:
   ```bash
   sysopctl backup /path/to/directory
   ```

---

## Adding Documentation (Manual Page)
1. Create a manual page file:
   ```bash
   sudo nano /usr/share/man/man1/sysopctl.1
   ```
2. Add the following content:
   ```man
   .TH SYSOPCTL 1 "December 2024" "sysopctl v0.1.0" "User Commands"
   .SH NAME
   sysopctl \- Manage system resources and tasks.
   .SH SYNOPSIS
   sysopctl [command] [options]
   .SH DESCRIPTION
   A command-line tool for managing system services, monitoring processes, and analyzing logs.
   .SH COMMANDS
   .TP
   \fBservice list\fR
   List all active services.
   .TP
   \fBservice start <name>\fR
   Start a specified service.
   .TP
   \fBservice stop <name>\fR
   Stop a specified service.
   .TP
   \fBsystem load\fR
   Display system load averages.
   .TP
   \fBdisk usage\fR
   Show disk usage by partition.
   ```
3. Save and update the manual database:
   ```bash
   sudo mandb
   ```
4. Test it:
   ```bash
   man sysopctl
   ```

---

## Contributing
1. Fork this repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```

