#!/bin/bash

# =================================================================
# Title: Wazuh Hardening Script - Portugal (CNCS/NIS2)
# Author: Tiago Raposo
# Description: Automated remediation for 50 security controls.
# =================================================================

echo "🚀 Starting Hardening Process (50 CNCS/NIS2 Controls)..."

# 1. Network & Kernel Hardening (Sysctl)
echo "Setting network and kernel parameters..."
cat <<EOF | sudo tee -a /etc/sysctl.conf
# Wazuh Compliance
net.ipv4.ip_forward = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.log_martians = 1
kernel.randomize_va_space = 2
kernel.dmesg_restrict = 1
fs.suid_dumpable = 0
kernel.kptr_restrict = 1
kernel.kexec_load_disabled = 1
net.core.bpf_jit_harden = 2
EOF
sudo sysctl -p

# 2. SSH Service Hardening
echo "Hardening SSH configuration..."
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
sudo sed -i 's/^#IgnoreRhosts.*/IgnoreRhosts yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#HostbasedAuthentication.*/HostbasedAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
# Ensure specific SSH port
if ! grep -q "^Port 22" /etc/ssh/sshd_config; then
    echo "Port 22" | sudo tee -a /etc/ssh/sshd_config
fi
sudo systemctl restart ssh

# 3. Password Policy & Session Timeout
echo "Setting password aging and session timeouts..."
sudo sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
echo "readonly TMOUT=600 ; export TMOUT" | sudo tee -a /etc/profile

# 4. Kernel Module Blocking (USB & Insecure Protocols)
echo "Blocking insecure kernel modules..."
for module in usb-storage dccp sctp; do
    echo "install $module /bin/true" | sudo tee /etc/modprobe.d/$module.conf
done

# 5. Critical File Permissions
echo "Restricting filesystem permissions..."
sudo chmod 640 /etc/shadow
sudo chmod 644 /etc/passwd
sudo chmod 440 /etc/sudoers
sudo chmod 600 /etc/crontab
[ -f /boot/grub/grub.cfg ] && sudo chmod 400 /boot/grub/grub.cfg

# 6. Compiler Access Restriction
echo "Restricting compiler access (GCC/G++)..."
sudo chmod 700 /usr/bin/gcc /usr/bin/g++ 2>/dev/null

# 7. Wazuh Agent SCA Cache Reset
echo "Refreshing Wazuh SCA database..."
sudo systemctl stop wazuh-agent
sudo rm -rf /var/ossec/queue/sca/db/*
sudo systemctl start wazuh-agent

echo "✅ Hardening Complete. Please wait for the next Wazuh scan."