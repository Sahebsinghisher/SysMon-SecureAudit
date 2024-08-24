# SysMon-SecureAudit

IMPORTANT-Environment=Linux(UBUNTU Latest Version)

SET 1: MONITORING SYSTEM RESOURCES FOR A PROXY SERVER.
Installation Procedure-
1. Clone or Download the Script
-> Clone the repository or download the monitor.sh script.

2. Make the Script Executable (Imp Step)
-> Open a terminal and navigate to the directory where the script is located. Then, make it executable:
bash Command-
$chmod +x monitor.sh (NOTE-chmod only works in Unix/linux and Unix-like systems)
#) Usage
You can run the script with various command-line switches to view specific parts of the dashboard.

#) Run the Entire Script
To run the entire script and see all monitoring information:
bash Command-
$./monitor.sh (Imp Step)

-> To Run Specific Parts of the Dashboard
#)You can also call individual parts of the dashboard using the following switches:
1) CPU Usage:
bash Command-
$./monitor.sh -cpu

2) Memory Usage:
bash Command-
$./monitor.sh -memory

3) Network Monitoring:
bash Command-
$./monitor.sh -network

4) Disk Usage:
bash Command-
$./monitor.sh -disk

5) System Load:
bash Command-
$./monitor.sh -load

6) Process Monitoring:
bash Command-
$./monitor.sh -processes

8) Service Monitoring:
bash Command-
$./monitor.sh -services
Examples

9) Check CPU Usage:
bash Command-
$./monitor.sh -cpu

10) Monitor Memory and Swap Usage:
bash Command-
$./monitor.sh -memory

11) Check Disk Usage:
bash Command-
$./monitor.sh -disk

12) View Active Processes:
bash Command-
$./monitor.sh -processes

#)License
This script is open-source and available under the MIT License. Feel free to modify and use it according to your needs.


DESCRIPTION-
-> System Monitoring Script-
#)Overview
This Bash script provides a dashboard to monitor various system resources on an Ubuntu server. It allows you to check CPU usage, memory usage, network activity, disk usage, system load, processes, and the status of essential services. You can run the entire script at once or call specific parts of the dashboard using command-line switches.

#)Features
CPU Usage: Displays the top 10 processes consuming the most CPU.
Memory Usage: Shows total, used, free memory, and swap memory usage.
Network Monitoring: Provides information about the number of concurrent connections, packet drops, and network usage in MB.
Disk Usage: Shows disk space usage by mounted partitions, highlighting those using more than 80% of the space.
System Load: Displays the current load average and CPU usage breakdown.
Process Monitoring: Lists the number of active processes and the top 5 processes by CPU and memory usage.
Service Monitoring: Checks the status of essential services like sshd, nginx/apache, and iptables.

                             #################################################################
                             
SET 2: SCRIPT FOR AUTOMATING SECURITY AUDITS AND SERVER HARDENING ON LINUX SERVERS.

Installation-
1.Clone the Repository:

bash command-
git clone https://github.com/Sahebsinghisher/SysMon-SecureAudit/blob/main/security_audit_hardening.sh
cd security-audit-hardening

#)Make the Script Executable: (Imp Step)
bash command-
$chmod +x security_audit_hardening.sh

#)TO RUN THE SCRIPT (Imp Step)
$sudo ./security_audit_hardening.sh


-> Configuration
#) Custom Security Checks:
If you need to include custom security checks, create a custom_checks.sh script in the same directory as security_audit_hardening.sh.
The script will automatically execute custom_checks.sh if it exists.

#) Email Alerts:
If you want to receive email alerts for critical vulnerabilities, configure the mailx command within the script:
bash Command-
$echo "Critical vulnerability found!" | mailx -s "Security Alert" admin@example.com
Ensure mailx or a similar mail client is installed and configured.

-> Usage
Running the Script
To run the script, execute the following command with sudo privileges:
bash Command-
sudo ./security_audit_hardening.sh

-> Output and Logs
The script outputs its results to /var/log/security_audit.log. You can review this file to see the detailed results of the audit and hardening process.
bash Command-
cat /var/log/security_audit.log

-> Testing the Script
Review Logs: After running the script, review the logs to ensure that all tasks have been performed correctly.
Manual Verification: Manually verify critical changes, such as SSH configuration, firewall rules, and GRUB password settings.

-> Debugging
To run the script in debug mode and see each command as it executes, use the -x option:
bash Command-
$sudo bash -x security_audit_hardening.sh

-> Rollback Plan
Before running the script on a production server, ensure you have a rollback plan in place:
System Backups: Take a full backup of the system.
Configuration Backups: Backup configuration files that will be modified by the script.
Manual Undo: Be prepared to manually undo changes if necessary.

-> Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss improvements or report bugs.

-> License
This project is licensed under the MIT License. See the LICENSE file for details.

 Key Sections Explained:
1. Features: Provides an overview of what the script does.
2. Prerequisites: Lists system requirements and tools needed for the script to run.
3. Installation: Step-by-step instructions on how to clone the repository and prepare the script for execution.
4. Configuration: Explains how to set up custom checks and email alerts.
5. Usage: Details on how to run the script, view output logs, and debug if needed.
6. Testing and Debugging: Guidance on verifying the script's correct functionality.
7. Rollback Plan: Advises on having a plan in case something goes wrong.
8. Contributing and License: Information on contributing to the project and the licensing details. 



DESCRIPTION-
#)Security Audit and Server Hardening Script
This Bash script automates the security audit and hardening process for Linux servers. It checks for common security vulnerabilities, configures network settings, and applies various hardening measures. The script is modular, reusable, and can be easily deployed across multiple servers.

#)Features
- User and Group Audits: Lists all users and groups, checks for users with root privileges, and identifies weak passwords.
- File and Directory Permissions: Scans for world-writable files, checks SSH directory permissions, and reports files with SUID/SGID bits.
- Service Audits: Lists running services, checks for unauthorized services, and ensures critical services are properly configured.
- Firewall and Network Security: Verifies firewall status, reports open ports, and checks IP forwarding configurations.
- IP and Network Configuration Checks: Identifies public vs. private IP addresses and ensures sensitive services are not exposed on public IPs.
- Security Updates and Patching: Checks for available security updates and ensures regular update configuration.
- Log Monitoring: Scans for suspicious log entries.
- Server Hardening Steps: Configures SSH, disables IPv6 (if not required), secures the bootloader, and sets up automatic updates.
- Custom Security Checks: Allows for the inclusion of custom security checks via a configuration file.
- Reporting and Alerting: Generates a summary report and can optionally send email alerts.

#)Prerequisites
- Operating System: Linux (Tested on Ubuntu 23.04)
- Permissions: Root or sudo access is required to execute the script.
- Tools: Ensure the following tools are installed:
  - `awk`
  - `grep`
  - `find`
  - `netstat`
  - `ufw`
  - `iptables`
  - `john` (for password auditing, optional)
  - `unattended-upgrades`
  - `mailx` or similar (for email alerts, optional)









