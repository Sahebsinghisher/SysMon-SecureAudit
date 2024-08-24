#!/bin/bash

# Security Audit and Server Hardening Script

# 1. User and Group Audits
echo "### User and Group Audits ###" >> /var/log/security_audit.log
echo "Listing all users and groups..." 
cat /etc/passwd >> /var/log/security_audit.log
cat /etc/group >> /var/log/security_audit.log

echo "Checking for users with UID 0 (root privileges)..." 
awk -F: '($3 == "0") {print}' /etc/passwd >> /var/log/security_audit.log

echo "Identifying users without passwords..." 
awk -F: '($2 == "" ) {print $1}' /etc/shadow >> /var/log/security_audit.log

echo "Checking for weak passwords (if john is available)..." 
if command -v john &> /dev/null; then
    john --show /etc/shadow >> /var/log/security_audit.log
else
    echo "John the Ripper not installed, skipping weak password check." >> /var/log/security_audit.log
fi

# 2. File and Directory Permissions
echo "### File and Directory Permissions ###" >> /var/log/security_audit.log
echo "Scanning for world-writable files..." 
find / -type f -perm -o+w -exec ls -l {} \; >> /var/log/security_audit.log

echo "Scanning for world-writable directories..." 
find / -type d -perm -o+w -exec ls -ld {} \; >> /var/log/security_audit.log

echo "Checking SSH directory permissions..." 
find / -type d -name ".ssh" -exec ls -ld {} \; >> /var/log/security_audit.log

echo "Finding files with SUID/SGID bits set..." 
find / -perm /6000 -type f -exec ls -l {} \; >> /var/log/security_audit.log

# 3. Service Audits
echo "### Service Audits ###" >> /var/log/security_audit.log
echo "Listing all running services..." 
systemctl list-units --type=service --state=running >> /var/log/security_audit.log

echo "Checking for services listening on non-standard ports..." 
netstat -tuln | grep -Ev '(:22|:80|:443)' >> /var/log/security_audit.log

echo "Ensuring critical services are running..." 
systemctl status sshd >> /var/log/security_audit.log
systemctl status iptables >> /var/log/security_audit.log

# 4. Firewall and Network Security
echo "### Firewall and Network Security ###" >> /var/log/security_audit.log
echo "Verifying firewall status..." 
ufw status >> /var/log/security_audit.log
iptables -L >> /var/log/security_audit.log

echo "Reporting open ports..." 
netstat -tuln >> /var/log/security_audit.log

echo "Checking for IP forwarding..." 
sysctl net.ipv4.ip_forward >> /var/log/security_audit.log
sysctl net.ipv6.conf.all.forwarding >> /var/log/security_audit.log

# 5. IP and Network Configuration Checks
echo "### IP and Network Configuration Checks ###" >> /var/log/security_audit.log
echo "Checking IP addresses..." 
ip addr show | grep "inet " >> /var/log/security_audit.log

echo "Providing a summary of IP addresses..." 
ip -4 addr show >> /var/log/security_audit.log
ip -6 addr show >> /var/log/security_audit.log

# 6. Security Updates and Patching
echo "### Security Updates and Patching ###" >> /var/log/security_audit.log
echo "Checking for available security updates..." 
apt list --upgradable >> /var/log/security_audit.log

echo "Ensuring the server is configured for regular updates..." 
grep -i "APT::Periodic::Update-Package-Lists" /etc/apt/apt.conf.d/20auto-upgrades >> /var/log/security_audit.log

# 7. Log Monitoring
echo "### Log Monitoring ###" >> /var/log/security_audit.log
echo "Checking for suspicious log entries..." 
grep "Failed password" /var/log/auth.log >> /var/log/security_audit.log

# 8. Server Hardening Steps
echo "### Server Hardening Steps ###" >> /var/log/security_audit.log
echo "Implementing SSH key-based authentication and disabling password-based login for root..." 
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "Disabling IPv6..." 
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

echo "Setting GRUB bootloader password..." 
echo "Please enter GRUB password:"
grub-mkpasswd-pbkdf2 | tee -a /var/log/security_audit.log
# Manually add the resulting hash to /etc/grub.d/40_custom and run update-grub

echo "Configuring iptables rules..." 
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables-save > /etc/iptables/rules.v4

echo "Configuring automatic updates..." 
apt-get install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# 9. Custom Security Checks
echo "### Custom Security Checks ###" >> /var/log/security_audit.log
if [ -f ./custom_checks.sh ]; then
    bash ./custom_checks.sh >> /var/log/security_audit.log
else
    echo "No custom checks found." >> /var/log/security_audit.log
fi

# 10. Reporting and Alerting
echo "### Reporting and Alerting ###" >> /var/log/security_audit.log
echo "Security audit completed. Summary available at /var/log/security_audit.log"
# Send email alert if necessary (requires mailx or similar)
# echo "Critical vulnerability found!" | mailx -s "Security Alert" admin@example.com
