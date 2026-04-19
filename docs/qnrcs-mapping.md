# QNRCS Technical Mapping — Sovereign Shield 🛡️

This document maps the Sovereign Shield SCA Policy (v1.0) controls to the technical requirements of the Portuguese National Cybersecurity Framework (QNRCS) and the EU NIS2 Directive.

---

## 1. Identity & Access Control (AC)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20001 | Disable SSH Root Login | AC-1, AC-3 | 🔴 High | `remediate-ssh.sh` |
| 20002 | Set Password Expiration (90 Days) | AC-2 | 🟡 Medium | Ansible |
| 20003 | Enforce Password Complexity (PAM) | AC-2 | 🔴 High | Ansible |
| 20005 | Lock Inactive User Accounts | AC-2 | 🟡 Medium | Bash Script |
| 20006 | Limit `sudo` Access to Authorized Users | AC-3 | 🔺 Critical | Manual Audit |
| 20007 | Disable Empty Passwords | AC-2 | 🔺 Critical | `remediate-auth.sh` |
| 20008 | Set SSH Idle Timeout Interval | AC-1 | 🟢 Low | Ansible |
| 20009 | Disable SSH X11 Forwarding | AC-4 | 🟡 Medium | Ansible |
| 20010 | Enforce Strong Hashing (SHA-512) | AC-2 | 🔴 High | Ansible |

---

## 2. Network & Boundary Protection (SC)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20004 | Host-Based Firewall Status (UFW) | SC-7 | 🔴 High | `remediate-ufw.sh` |
| 20011 | Disable Unused Network Protocols (SCTP/DCCP) | SC-7 | 🟢 Low | Ansible |
| 20012 | Disable IP Forwarding | SC-5 | 🟡 Medium | `sysctl-harden.sh` |
| 20013 | Enable ICMP Redirect Acceptance Protection | SC-5 | 🟡 Medium | `sysctl-harden.sh` |
| 20014 | Enable Source Route Validation | SC-5 | 🔴 High | `sysctl-harden.sh` |
| 20015 | Disable Insecure Services (Telnet/RSH/FTP) | SC-7 | 🔺 Critical | Ansible |
| 20016 | Set Permissions on `/etc/hosts.allow` | SC-7 | 🟢 Low | Bash Script |
| 20017 | Enable TCP Syncookies | SC-5 | 🔴 High | `sysctl-harden.sh` |

---

## 3. System Integrity & Data Protection (SI/DP)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20018 | Verify Permissions on `/etc/shadow` | DP-1 | 🔺 Critical | Bash Script |
| 20019 | Verify Permissions on `/etc/passwd` | DP-1 | 🔺 Critical | Bash Script |
| 20020 | Enable ASLR (Address Space Layout) | SI-1 | 🔴 High | `sysctl-harden.sh` |
| 20021 | Disable Core Dumps | SI-1 | 🟡 Medium | Ansible |
| 20022 | Restrict Access to `/var/log/audit` | SI-2 | 🔴 High | Bash Script |
| 20023 | Ensure No World-Writable Files Exist | SI-1 | 🔴 High | Manual/Script |
| 20024 | Check for Unowned Files/Groups | SI-1 | 🟡 Medium | Manual/Script |

---

## 4. Auditing & Logging (AU)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20025 | Ensure Auditd Service is Running | AU-1 | 🔴 High | `remediate-audit.sh` |
| 20026 | Audit Changes to System Administration (sudoers) | AU-2 | 🟡 Medium | Ansible |
| 20027 | Audit Successful/Failed Login Events | AU-2 | 🔴 High | Ansible |
| 20028 | Audit Filesystem Mounts | AU-2 | 🟢 Low | Ansible |
| 20029 | Remote Logging Configured (Wazuh Manager) | AU-3 | 🔺 Critical | Automatic |
| 20030 | Ensure Rsyslog is Installed and Active | AU-1 | 🟡 Medium | Ansible |

---

## 5. Malware Protection & Software Integrity (SI)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20031 | Ensure Package Repositories are Secure (HTTPS) | SI-2 | 🔴 High | Ansible |
| 20032 | Verify GPG Keys for All Packages | SI-1 | 🔺 Critical | Ansible |
| 20033 | Check for Suspicious Cron Jobs | SI-3 | 🟡 Medium | Manual Audit |
| 20034 | Disable USB Storage Mounting | SI-4 | 🟢 Low | `remediate-usb.sh` |
| 20035 | Ensure No Unconfined Daemons Exist | SI-1 | 🟡 Medium | Manual Audit |
| 20036 | Periodic Integrity Check (Rootcheck) | SI-1 | 🔴 High | Wazuh Native |
| 20037 | Detect Hidden Processes | SI-3 | 🔴 High | Wazuh Native |

---

## 6. Kernel Hardening & Resource Protection (SI/SC)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20038 | Disable Core Dumps for All Users | SI-1 | 🟡 Medium | `sysctl-harden.sh` |
| 20039 | Enable Randomized Virtual Memory Region Placement | SI-1 | 🔴 High | `sysctl-harden.sh` |
| 20040 | Restrict Access to Kernel Logs (dmesg) | SI-2 | 🟢 Low | Ansible |
| 20041 | Disable Automatic Loading of Unused Filesystems | SC-7 | 🟢 Low | Bash Script |
| 20042 | Protect `/tmp` with Nodev/Nosuid/Noexec | SI-1 | 🔴 High | `fstab-harden.sh` |

---

## 7. Configuration & Maintenance (CM)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20043 | Remove Insecure Legacy Services (NIS/RSH/Talk) | CM-1 | 🔺 Critical | Ansible |
| 20044 | Ensure No World-Writable Files in System Paths | CM-2 | 🔴 High | Manual/Script |
| 20045 | Check for SUID/SGID Executables | CM-2 | 🟡 Medium | Manual Audit |
| 20046 | Enforce Banner Message for Login (Legal Warning) | CM-1 | 🟢 Low | Ansible |
| 20047 | Restrict Access to `/etc/crontab` | CM-2 | 🔴 High | Bash Script |

---

## 8. Business Continuity & Incident Response (IR)

| Check ID | Control Name | QNRCS Ref | Severity | Remediation |
|----------|-------------|-----------|----------|-------------|
| 20048 | Verify Real-time Alerting Connection to Manager | IR-1 | 🔺 Critical | Automatic |
| 20049 | System Uptime and Availability Monitoring | IR-2 | 🟢 Low | Dashboard |
| 20050 | Vulnerability Scan Interval Enforcement | IR-1 | 🔴 High | Wazuh Native |

---

## Compliance Methodology

Sovereign Shield scores are calculated based on the successful passing of these 50 technical checks.

| Level | Compliance |
|-------|------------|
| 🏆 Platinum | 90% – 100% |
| 🥇 Gold | 80% – 90% *(current status)* |
| 🥈 Silver | 70% – 80% |

### Severity legend

| Icon | Severity |
|------|----------|
| 🔺 | Critical |
| 🔴 | High |
| 🟡 | Medium |
| 🟢 | Low |

### Framework interpretation

The QNRCS references (e.g., `AC-1`, `SC-7`) are aligned with the **Quadro Nacional de Referência para a Cibersegurança** issued by the CNCS. This mapping ensures that technical configurations at the OS level directly support organizational compliance requirements under the NIS2 Directive.
