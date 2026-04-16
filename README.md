<div align="center">

<img src="https://wazuh.com/uploads/2022/05/WAZUH.png" alt="Wazuh Logo" width="260"/>

# 🛡️ Wazuh · Sovereign Shield · Portugal
### *Compliance-as-Code for Portugal — CNCS · NIS2 · GDPR*

<br/>

[![Wazuh](https://img.shields.io/badge/Wazuh-4.x-005571?style=for-the-badge&logo=wazuh&logoColor=white)](https://wazuh.com/)
[![NIS2](https://img.shields.io/badge/NIS2-Art.%2021-003399?style=for-the-badge&logo=europeanunion&logoColor=white)](#)
[![CNCS](https://img.shields.io/badge/CNCS-QNRCS-006600?style=for-the-badge)](#)
[![GDPR](https://img.shields.io/badge/GDPR-Art.%2032-cc0000?style=for-the-badge)](#)
[![Platform](https://img.shields.io/badge/Platform-Ubuntu%2022.04%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)
[![Score](https://img.shields.io/badge/Compliance%20Score-100%25%20✓-00b300?style=for-the-badge)](#evidence-of-compliance)

<br/>

> *"Cybersecurity is not a destination — it is a continuous process of vigilance and adaptation."*


<br/>

**50 automated controls · 12 critical domains · Audit-ready evidence**

</div>

---

> 🇵🇹 **Regulatory Scope:** This framework is engineered specifically for the Portuguese regulatory landscape — mapping **CNCS/QNRCS** national references and the **NIS2 Directive (EU 2022/2555)** transposition into law. Documentation is in English to maximise community reach and international collaboration.

---

## 📖 Table of Contents

| # | Section |
|---|---------|
| 1 | [Strategic Context](#-strategic-context) |
| 2 | [Solution Architecture — The Wazuh Sovereign Shield](#-solution-architecture--the-wazuh-sovereign-shield) |
| 3 | [The 50 Controls — Full Map](#-the-50-controls--full-map) |
| 4 | [Naming Convention & Tags](#-naming-convention--tags) |
| 5 | [Prerequisites & Known Failure Points](#-prerequisites--known-failure-points) |
| 6 | [Implementation Guide](#-implementation-guide) |
| 7 | [Automated Hardening Script](#-automated-hardening-script) |
| 8 | [Enterprise Automation — Ansible](#-enterprise-automation--ansible-integration) |
| 9 | [Evidence of Compliance (PoC)](#-evidence-of-compliance-poc) |
| 10 | [Why This Project Stands Out](#-why-this-project-stands-out) |
| 11 | [Strategic Vision: Digital Sovereignty](#-strategic-vision-digital-sovereignty) |
| 12 | [Contributing & Community](#-contributing--community) |

---

## 🌍 Strategic Context

Portugal's cybersecurity maturity is governed by the **National Cybersecurity Reference Framework (QNRCS)**, published by the **National Cybersecurity Centre (CNCS)**. With the transposition of the **NIS2 Directive (EU 2022/2555)** into national law, essential and important entities face a clear mandate: **continuous, evidence-based compliance** — not annual point-in-time audits.

This project answers that mandate through a **Compliance-as-Code** approach, translating legislative requirements into 50 automated technical controls within the Wazuh ecosystem.

```
Problem                    →  Solution
────────────────────────────────────────────────────────────────
Manual annual audits       →  Real-time SCA with continuous cycles
Static PDF reports         →  Live Wazuh dashboard with audit evidence
Legal language ≠ IT ops    →  Direct QNRCS ↔ sysctl mapping
Ad-hoc remediation         →  Idempotent hardening script (setup_compliance.sh)
Single-host enforcement    →  Ansible fleet-wide orchestration
```

### Legal Coverage

| Framework | Reference | Scope |
|-----------|-----------|-------|
| 🏛️ **QNRCS (CNCS)** | Domains AC, PR, DI, RE | Portuguese national cybersecurity reference |
| 🇪🇺 **NIS2 Directive** | Article 21 | Essential & important entities — EU 2022/2555 |
| 🔒 **GDPR** | Article 32 | Technical security measures for personal data |

---

## 🏗️ Solution Architecture — The Wazuh Sovereign Shield

The **Wazuh Sovereign Shield** is a comprehensive Compliance-as-Code framework that bridges the gap between technical hardening and the NIS2 Directive. It operates through the integration of two tightly coupled components: the **Sovereign Gold SCA Policy** for continuous auditing, and the **`setup_compliance.sh`** script for automated remediation.

```
┌──────────────────────────────────────────────────────────────────┐
│                      WAZUH MANAGER (SIEM)                        │
│               Dashboard · Alerts · Automated PDF Reports         │
└──────────────────────────┬───────────────────────────────────────┘
                           │  OSSEC Protocol (TLS)
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│                    WAZUH AGENT (Audited Host)                    │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │   AUDITING LAYER — Sovereign Gold SCA Policy              │   │
│  │  pt_cncs_ubuntu22_gold.yml · 50 controls · continuous     │   │
│  └──────────────────────────┬────────────────────────────────┘   │
│                             │ findings                           │
│  ┌──────────────────────────▼────────────────────────────────┐   │
│  │     REMEDIATION LAYER — setup_compliance.sh               │   │
│  │  sysctl · permissions · services · modprobe               │   │
│  └───────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────┐  ┌───────────┐  ┌──────────┐  ┌───────────────┐    │
│  │ Identity │  │  Network  │  │  Kernel  │  │ Supply Chain  │    │
│  │ & Access │  │ & Anti-   │  │ Hardening│  │ & Logging     │    │
│  │   (AC)   │  │  DoS (DI) │  │   (PR)   │  │   (RE/PR)     │    │
│  └──────────┘  └───────────┘  └──────────┘  └───────────────┘    │
└──────────────────────────────────────────────────────────────────┘
                           ▲
              ┌────────────┴────────────┐
              │   Ansible Orchestration │
              │  Fleet-wide enforcement │
              └─────────────────────────┘
```

### The Two Core Components

**🔍 Auditing Layer — Sovereign Gold SCA Policy**
Utilising the Wazuh SCA engine, this policy continuously monitors 50 security controls mapped to the QNRCS. It provides real-time visibility into every audited host's compliance posture, generating evidence directly consumable by external auditors.

**🔧 Remediation Layer — `setup_compliance.sh`**
An automated engine that applies `sysctl` parameters, file permissions, and service configurations to transform a vulnerable system into a 100% compliant state. Idempotent by design — safe to run repeatedly without side effects. Together, these components enforce **Defense-in-Depth** from the kernel to the application layer.

---

## 📊 The 50 Controls — Full Map

> Every control is mapped to both the QNRCS national framework and the corresponding NIS2 article, producing audit-ready evidence that speaks directly to external auditors and CISOs.

| Domain | SCA IDs | Technical Control | CNCS (QNRCS) | NIS2 / GDPR |
|:-------|:--------|:-----------------|:-------------|:------------|
| 👤 **Identity & Access** | 20001–3, 20025–27 | SSH root lock, password aging, global TMOUT, Faillock brute-force protection | **AC.1, AC.2, AC.3** | Art. 21 — Access Control & Cyber Hygiene |
| 🌐 **Network** | 20004, 20008, 20030 | UFW enforcement, IP forwarding off, IPv6 disable | **PR.2, DI.1** | Art. 21 — Network & Infrastructure Security |
| 🛡️ **Anti-DoS** | 20010–11, 20031–34 | TCP SYN cookies, ICMP hardening, Martian packet logging | **DI.2** | Art. 21 — Incident Prevention & Handling |
| 🧠 **Kernel (Base)** | 20009, 20012, 20021 | ASLR level 2, dmesg restriction, core dumps disabled | **PR.3** | Art. 21 — System Integrity Policies |
| ⚙️ **Kernel (Advanced)** | 20035–37 | kptr_restrict, kexec block, BPF JIT hardening | **PR.3** | Art. 21 — Zero-Day Exploit Mitigation |
| 🔐 **Data Integrity** | 20005, 20018, 20038–40 | /etc/shadow, sudoers, world-writable file detection | **PR.1, PR.5** | GDPR Art. 32 — Data Integrity |
| 📁 **Filesystem** | 20016, 20051 | Unowned files audit, sticky bit on /tmp | **PR.5** | Art. 21 — System Hygiene & Asset Control |
| 📦 **Supply Chain** | 20007, 20041–44 | Legacy service removal, GCC/G++ restriction, Netcat detection | **PR.6** | Art. 21 — Supply Chain Security |
| 🔌 **Hardware & Physical** | 20013, 20045–46 | USB storage block, DCCP/SCTP kernel module disable | **PR.4** | Art. 21 — Physical & Peripheral Security |
| 📜 **Audit & Logging** | 20006, 20014, 20048 | Auditd active, Rsyslog config, remote SIEM logging | **RE.1, RE.2** | Art. 21 — Forensic Traceability |
| 🔁 **Resilience** | 20049–50 | Crontab integrity, GRUB bootloader permissions | **RE.2, PR.5** | Art. 21 — Operational Continuity |
| 🔑 **SSH Hardening** | 20020, 20052–56 | Protocol 2 only, MaxAuthTries 4, HostbasedAuth off | **AC.1, PR.6** | Art. 21 — Secure Communications |

---

## 🏷️ Naming Convention & Tags

Every control in `pt_cncs_ubuntu22_gold.yml` follows a standardised anatomy enabling **instant filtering** in the Wazuh dashboard:

```
NIS2/PR.3: Enable ASLR Memory Protection
│    │  │   └──► Clear technical description of the OS parameter
│    │  └──────► QNRCS subcategory (CNCS national framework)
│    └─────────► Reference framework (NIS2 or GDPR)
└──────────────► Searchable prefix in the Wazuh dashboard
```

### CNCS Domain Glossary

| Tag | Domain | Controls Covered |
|-----|---------|-----------------|
| `AC` | **Access Control** | SSH, sudo, TMOUT, Faillock, password aging |
| `PR` | **Protection** | Kernel hardening, critical file permissions, encryption |
| `DI` | **Detection** | Firewall, anomalous traffic, Anti-DoS mechanisms |
| `RE` | **Response & Logging** | Auditd, Rsyslog, SIEM integration, Cron integrity |

> **Operational benefit:** During an audit, searching `NIS2` in the Wazuh dashboard instantly surfaces all European compliance evidence. Searching `PR` isolates data protection controls — eliminating hundreds of hours of manual correlation work.

---

## ⚠️ Prerequisites & Known Failure Points

The **Sovereign Gold** policy is a high-security auditing engine. When applied to a clean host **without** running `setup_compliance.sh`, several controls will fail by design — this demonstrates the gap between default OS configurations and the hardening standard required by the framework. The table below maps each expected failure to its root cause.

| SCA ID | Control | Root Cause (without hardening) | Fix Applied by Script |
|:------:|:--------|:-------------------------------|:----------------------|
| **20042/43** | GCC/G++ Restriction | Compilers world-accessible (`755`) — enables local exploit compilation | Sets permissions to `700` (root-only) |
| **20025** | Session Timeout (TMOUT) | Ubuntu sets no global TMOUT by default | Injects `TMOUT=600` into `/etc/profile` |
| **20030** | IPv6 Hardening | IPv6 active by default — unnecessary lateral attack surface | Disables via `sysctl` |
| **20050** | GRUB Bootloader | Default `644` permissions expose boot parameters and password hashes | Applies `400` (root read-only) |
| **20013/45** | USB/DCCP/SCTP Modules | Dynamic kernel module loading permitted | Creates blocklists in `/etc/modprobe.d/` |
| **20053** | SSH MaxAuthTries | OpenSSH default: 6 attempts — persistent brute-force vector | Sets `MaxAuthTries 4` in `sshd_config` |

> To guarantee all 50 controls pass on the first scan, run `setup_compliance.sh` before policy ingestion. See [Automated Hardening Script](#-automated-hardening-script) for details.

---

## 🚀 Implementation Guide

### 1. Clone the Repository

```bash
git clone https://github.com/TiagoCCRaposo/Wazuh-CNCS-Portugal.git
cd Wazuh-CNCS-Portugal
```

### 2. Deploy the SCA Policy to the Agent

```bash
# Copy the policy to the Wazuh agent SCA directory
sudo cp policies/pt_cncs_ubuntu22_v.1.0.yml /var/ossec/etc/sca/

# Validate YAML syntax before restarting
python3 -c "import yaml; yaml.safe_load(open('/var/ossec/etc/sca/pt_cncs_ubuntu22_gold.yml'))" \
  && echo "✅ YAML valid"

# Restart the agent to activate the policy
sudo systemctl restart wazuh-agent
```

### 3. Run the Remediation Script

```bash
# Execute as root — applies all hardening layers
sudo bash scripts/setup_compliance.sh
```

### 4. Force an Immediate Re-scan

After remediation, clear the SCA cache and restart the agent to ensure the new compliance state is reported immediately to the Manager:

```bash
# Clear the local SCA database
sudo rm -f /var/ossec/etc/db/*

# Restart the agent to force immediate reporting
sudo systemctl restart wazuh-agent

# Monitor the scan in real time
sudo tail -f /var/ossec/logs/ossec.log | grep -i "sca"
```

### 5. Validate in the Wazuh Dashboard

Navigate to: **Security Configuration Assessment → pt_cncs_ubuntu22_v.1.0. → Results**

Expected score after remediation: **100% Passed · 0 Failed · 7 N/A**

---

## ⚙️ Automated Hardening Script

`setup_compliance.sh` implements **CIS Benchmark** and **QNRCS** best practices across **seven critical OS layers**, designed to be idempotent and fully auditable.

<details>
<summary><b>🌐 Layer 1 — Network Stack Hardening (sysctl)</b></summary>

```bash
# Anti-spoofing & anti-routing
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_source_route = 0

# Anti-DoS
net.ipv4.tcp_syncookies = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Forged traffic detection
net.ipv4.conf.all.log_martians = 1

# IPv6 disable (unnecessary attack surface)
net.ipv6.conf.all.disable_ipv6 = 1
```
</details>

<details>
<summary><b>🧠 Layer 2 — Kernel Protection</b></summary>

```bash
# Maximum ASLR
kernel.randomize_va_space = 2

# Restrict kernel information exposure
kernel.dmesg_restrict = 1
kernel.kptr_restrict = 2

# Disable core dumps and kexec
fs.suid_dumpable = 0
kernel.kexec_load_disabled = 1

# BPF JIT hardening
net.core.bpf_jit_harden = 2
```
</details>

<details>
<summary><b>🔑 Layer 3 — Secure Remote Access (SSH)</b></summary>

```bash
# Applied to /etc/ssh/sshd_config
Protocol 2
PermitRootLogin no
MaxAuthTries 4
HostbasedAuthentication no
IgnoreRhosts yes
```
</details>

<details>
<summary><b>👤 Layer 4 — Identity & Session Management</b></summary>

```bash
# /etc/login.defs
PASS_MAX_DAYS   90
PASS_MIN_DAYS    7
PASS_WARN_AGE   14

# /etc/profile — global session timeout
export TMOUT=600
readonly TMOUT
```
</details>

<details>
<summary><b>🔐 Layer 5 — Filesystem & Privileges</b></summary>

```bash
# Least-privilege on sensitive files
chmod 640 /etc/shadow
chmod 440 /etc/sudoers
chmod 600 /etc/crontab

# Restrict compilers to root (prevents local exploit compilation)
chmod 700 /usr/bin/gcc
chmod 700 /usr/bin/g++
```
</details>

<details>
<summary><b>🔌 Layer 6 — Physical Security & Anti-Exfiltration</b></summary>

```bash
# /etc/modprobe.d/blacklist-cncs.conf
install usb-storage /bin/true   # Block USB storage
install dccp /bin/true           # Block DCCP protocol
install sctp /bin/true           # Block SCTP protocol
```
</details>

<details>
<summary><b>🤖 Layer 7 — Wazuh Agent Integration</b></summary>

```bash
# Clear local SCA database to force fresh state reporting
rm -f /var/ossec/etc/db/*

# Restart agent to report new compliance state immediately
systemctl restart wazuh-agent
```
</details>

---

## 🚀 Enterprise Automation — Ansible Integration

For large-scale environments where manual remediation is not feasible, the **Wazuh Sovereign Shield** includes native support for **Ansible**. This allows simultaneous enforcement of the **Sovereign Gold** policy across entire server fleets, ensuring uniform NIS2 compliance at scale.

### Key Benefits

| Benefit | Description |
|---------|-------------|
| **Scalability** | Deploy the hardening framework to hundreds of Ubuntu nodes with a single command |
| **Idempotency** | The playbook verifies the desired state before applying changes — no redundant operations |
| **Compliance-as-Code** | Audit results and remediation logic are fully integrated into your DevOps pipeline |

### How to Deploy at Scale

**1. Prepare your inventory:**

```ini
# ansible/inventory.ini
[production_servers]
server-01.example.pt
server-02.example.pt
server-03.example.pt
```

**2. Execute the playbook:**

```bash
ansible-playbook -i ansible/inventory.ini ansible/deploy_shield.yml
```

**3. Verify fleet compliance:**

After execution, all nodes in the inventory will report **100% Passed** to the Wazuh Manager simultaneously. Green lines (`ok`) confirm the desired state was already present; yellow lines (`changed`) confirm remediation was applied.

> This orchestration ensures that **Digital Sovereignty** and **Defense-in-Depth** are not just theoretical concepts, but a scalable, repeatable reality for Portuguese critical infrastructure.

---

## ✅ Evidence of Compliance (PoC)

> Score obtained after running `setup_compliance.sh` on a clean Ubuntu 22.04 LTS host.

```
┌──────────────────────────────────────────────────────┐
│          WAZUH SCA — pt_cncs_ubuntu22_gold           │
│──────────────────────────────────────────────────────│
│  ✅  Passed          :  43  (100% of applicable)     │
│  ❌  Failed          :   0                           │
│  ➖  Not Applicable  :   7  (services not present)   │
│──────────────────────────────────────────────────────│
│  Compliance Score    :  100%  ████████████████████   │
└──────────────────────────────────────────────────────┘
```
<img width="940" height="429" alt="image" src="https://github.com/user-attachments/assets/8903cb64-d63f-4a6b-8320-efab81ecf171" />

*Figure 1: Wazuh Dashboard — 0% failure rate across all audited controls.*

### On "Not Applicable" (N/A) Results

The 7 N/A controls are **not failures** — they are positive evidence of cyber hygiene. They reference legacy and insecure services (Telnet, NIS, rsh) that are simply not installed on the audited host. In compliance with the **Function Minimisation principle (QNRCS/PR.6)**, the absence of these components reduces the attack surface — precisely the outcome an external auditor expects to see.

---

## 💎 Why This Project Stands Out

| Capability | Generic Framework | Sovereign Gold |
|:-----------|:-----------------:|:--------------:|
| Direct QNRCS (CNCS) mapping | ❌ | ✅ |
| Full NIS2 Art. 21 coverage | Partial | ✅ Complete |
| Deep kernel hardening (ASLR/BPF/kexec) | ❌ | ✅ |
| Supply chain audit (GCC/Netcat) | ❌ | ✅ |
| Idempotent remediation script | ❌ | ✅ |
| Ansible fleet-wide orchestration | ❌ | ✅ |
| Dashboard-filterable nomenclature | ❌ | ✅ |
| Audit-ready evidence (PoC) | ❌ | ✅ 100% verified |
| Dual-layer legal mapping (EU + National) | ❌ | ✅ |

---

## 🌍 Strategic Vision: Digital Sovereignty

This project is built on a conviction: world-class open-source tooling must serve **Portuguese digital sovereignty**. Implementing this framework is not merely configuring a SIEM — it is laying the technical foundations for national resilience.

The transposition of **NIS2** and the evolution of the **QNRCS** demand a paradigm shift: from static compliance (annual audits) to **continuous compliance** (real-time assurance). This project is a concrete, reproducible implementation of that shift.

### Roadmap

- [ ] **Executive Dashboards** — CNCS-domain-aligned Wazuh visualisations for CISO-level reporting
- [ ] **Multi-OS Expansion** — RHEL, Debian and Windows Server under the same national standard
- [ ] **National SIEM Integration** — Connectors for CNCS threat intelligence sharing platforms
- [ ] **Automated PDF Reports** — Audit-ready compliance reports generated on demand

---

## 🤝 Contributing & Community

This repository is open to contributions from cybersecurity professionals who want to:

- Refine or expand the existing 50 controls
- Port the framework to additional operating systems
- Improve mappings for future QNRCS revisions
- Add test coverage and CI validation

```bash
# How to contribute
git clone https://github.com/TiagoCCRaposo/Wazuh-CNCS-Portugal.git
git checkout -b feature/my-improvement
# ... implement changes ...
git push origin feature/my-improvement
# Open a Pull Request describing the control and its regulatory reference
```

---

<div align="center">

**Developed by**

### Tiago Raposo
*Cybersecurity & Compliance*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/tiagocnraposo)
[![GitHub](https://img.shields.io/badge/GitHub-TiagoCCRaposo-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/TiagoCCRaposo)

<br/>

*Built for Portugal · Aligned with Europe · Open to the World*

</div>
