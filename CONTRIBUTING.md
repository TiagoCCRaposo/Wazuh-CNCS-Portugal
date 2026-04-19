# Contributing to Sovereign Shield 🛡️

**Sovereign Shield** is an automated Security Configuration Assessment (SCA) and Remediation engine designed to enforce compliance with the **Portuguese National Cybersecurity Framework (QNRCS)** and the **EU NIS2 Directive**.

Instead of manual audits, Sovereign Shield provides **Continuous Compliance as Code**, using Wazuh to monitor, alert, and automatically remediate non-compliant configurations.

---

## Ways to Contribute

### 1. SCA Policy Controls

We aim to expand our **Platinum** framework to cover more technologies. If you have hardening expertise in any of the following, please add or update YAML files in `/frameworks/`:

- **Containers:** Docker, Kubernetes
- **Web Servers:** Nginx, Apache
- **Databases:** PostgreSQL, MySQL, MongoDB
- **Operating Systems:** Debian, RHEL, AlmaLinux

### 2. Remediation Scripts

Help us build the **Self-Healing** engine — Bash or Python scripts that automatically fix failed security checks via Wazuh Active Response.

Location: `/remediation/scripts/`

### 3. Ansible Playbooks

For large-scale infrastructure, we provide Infrastructure as Code (IaC) to apply security baselines consistently across environments.

Location: `/remediation/ansible/`

---

## Submission Process

1. **Fork** the repository.
2. **Create a feature branch:**
```bash
   git checkout -b feature/nginx-hardening
```
3. **Commit your changes** with a descriptive message:
```bash
   git commit -m 'Add: Nginx hardening SCA rules'
```
4. **Push** to your branch:
```bash
   git push origin feature/nginx-hardening
```
5. **Open a Pull Request** and describe what you changed and why.

---

## Coding Standards

| Rule | Requirement |
|------|-------------|
| **Language** | All documentation, comments, and commit messages must be written in English. |
| **Logging** | Remediation scripts must log all actions to `/var/ossec/logs/active-responses.log`. |
| **Security** | Never hardcode credentials in scripts or playbooks. Use environment variables or secret managers. |

---

## Community & Support

Found a bug or have a suggestion? Please open an **[Issue](../../issues)**.

Let's build a more secure, sovereign infrastructure — together.
