# 🐳 Docker Security Benchmark — QNRCS Compliance Mapping

This page provides the official technical mapping between the **Sovereign Shield Docker Benchmark (v1.1)** and the **Portuguese National Cybersecurity Reference Framework (QNRCS)** requirements, published by the Centro Nacional de Cibersegurança (CNCS).

Each control is assigned a severity level and cross-referenced to its QNRCS domain, enabling direct traceability during NIS2 Article 21 compliance audits.

---

## Severity Legend

| Level | Meaning |
|:------|:--------|
| 🔴 **Critical** | Exploitable immediately; blocks compliance sign-off |
| 🟠 **High** | Significant risk; must be remediated before production |
| 🟡 **Medium** | Important hardening; should be addressed in sprint |

---

## 1. Host Configuration & Docker Daemon Security

Controls applied at the host OS level and to the Docker daemon itself. These form the foundation of a secure container environment.

| Check ID | Control Name | Description | QNRCS Ref | Severity |
|:--------:|:-------------|:------------|:---------:|:--------:|
| 30001 | Partition Isolation | Ensure `/var/lib/docker` resides on a dedicated partition to prevent container activity from exhausting host disk space. | **DP-1** | 🟡 Medium |
| 30002 | Docker Socket Permissions | Restrict access to `/var/run/docker.sock` — equivalent to root access on the host. | **AC-3** | 🔴 Critical |
| 30003 | Non-Root User Enforcement | Ensure containers run as a non-root user defined in the Dockerfile with the `USER` directive. | **AC-1** | 🟠 High |
| 30004 | Inter-Container Communication (ICC) | Disable ICC by default so containers cannot communicate freely on the bridge network. | **SC-7** | 🟠 High |
| 30005 | Keep Docker Up to Date | Ensure the Docker Engine version is current to mitigate known CVEs in the container runtime. | **SI-2** | 🟠 High |
| 30006 | Audit Docker Files & Directories | Configure `auditd` to track changes under `/var/lib/docker` for forensic traceability. | **AU-2** | 🟡 Medium |
| 30007 | Audit Docker Daemon Binary | Configure `auditd` to monitor `/usr/bin/docker` for unexpected binary modifications. | **AU-2** | 🟡 Medium |
| 30008 | Restrict Inter-Container Networking | Confirm ICC is disabled at the daemon level via `--icc=false` in the Docker daemon configuration. | **SC-7** | 🟠 High |
| 30009 | Disable Legacy Registry (V1) | Allow only V2 registries to ensure authenticated and signed image pulls. | **SI-1** | 🟠 High |
| 30010 | Enable Live Restore | Configure `--live-restore` so containers continue running if the Docker daemon is restarted or crashes. | **IR-2** | 🟡 Medium |
| 30011 | User Namespace Remapping | Enable user namespace remapping (`userns-remap`) to isolate container root from host root. | **AC-3** | 🟠 High |
| 30012 | Default ulimit Settings | Set appropriate default `ulimit` values on the daemon to prevent resource exhaustion and fork bomb attacks. | **SI-1** | 🟡 Medium |

---

## 2. Docker Image & Build Security

Controls applied during the image build phase. Secure images are the prerequisite for secure containers.

| Check ID | Control Name | Description | QNRCS Ref | Severity |
|:--------:|:-------------|:------------|:---------:|:--------:|
| 30013 | Use Trusted Base Images | Pull images exclusively from verified registries or internal mirrors with digest pinning. | **SI-2** | 🟠 High |
| 30014 | No SSH Inside Containers | Remove SSH daemons from all images; use `docker exec` for interactive access instead. | **AC-1** | 🟠 High |
| 30015 | HEALTHCHECK Instruction | Ensure every production image includes a `HEALTHCHECK` instruction for availability monitoring. | **IR-2** | 🟡 Medium |
| 30016 | Remove Setuid/Setgid Bits | Strip `setuid` and `setgid` permissions from binaries in images to prevent privilege escalation. | **AC-3** | 🟠 High |
| 30017 | COPY Instead of ADD | Use `COPY` in Dockerfiles rather than `ADD` to avoid unintended URL fetching or archive extraction. | **SI-1** | 🟡 Medium |
| 30018 | No Secrets in Dockerfiles | Ensure no passwords, API keys, or tokens are hardcoded in any Dockerfile layer. | **DP-1** | 🔴 Critical |
| 30019 | Multi-Stage Builds | Use multi-stage builds to minimise production image size and exclude build tools from the final image. | **CM-1** | 🟡 Medium |

---

## 3. Container Runtime Protection

Controls enforced at runtime to limit what a running container can do on the host.

| Check ID | Control Name | Description | QNRCS Ref | Severity |
|:--------:|:-------------|:------------|:---------:|:--------:|
| 30020 | Read-Only Root Filesystem | Mount the container root filesystem as read-only (`--read-only`) wherever the application allows. | **SI-1** | 🟠 High |
| 30021 | CPU & Memory Limits | Enforce hard resource limits (`--memory`, `--cpus`) on all containers to prevent resource exhaustion. | **SI-1** | 🟠 High |
| 30022 | Disable Privileged Mode | Never run containers with the `--privileged` flag — it grants full host capabilities. | **AC-3** | 🔴 Critical |
| 30023 | No Sensitive Host Mounts | Do not bind-mount sensitive host paths (`/`, `/boot`, `/dev`, `/etc`) into containers. | **DP-1** | 🔴 Critical |
| 30024 | Restrict PID Limit | Set a `--pids-limit` on all containers to prevent fork bomb denial-of-service attacks. | **SI-1** | 🟠 High |
| 30025 | Secure Computing (seccomp) | Apply the default Docker seccomp profile or a custom restrictive profile to all containers. | **SI-1** | 🟠 High |
| 30026 | AppArmor / SELinux Profile | Ensure a mandatory access control profile (AppArmor or SELinux) is applied to all running containers. | **SI-1** | 🟠 High |
| 30027 | No New Privileges | Set `--security-opt=no-new-privileges` to prevent containers from gaining additional capabilities via `setuid`. | **AC-3** | 🟠 High |

---

## 4. Advanced Networking & Logging

Controls governing container network exposure and log management.

| Check ID | Control Name | Description | QNRCS Ref | Severity |
|:--------:|:-------------|:------------|:---------:|:--------:|
| 30028 | Bind to Specific IP | Never bind services to `0.0.0.0`; explicitly specify the host IP address for published ports. | **SC-7** | 🟠 High |
| 30029 | Centralised Log Driver | Configure a log driver (Fluentd, Syslog, or Wazuh agent) to forward container logs to a central SIEM. | **AU-3** | 🟠 High |
| 30030 | Minimise Exposed Ports | Expose only ports strictly required by the application; disable all others. | **SC-7** | 🟠 High |
| 30031 | No Host Network Mode | Avoid `--network host` to prevent containers from bypassing network isolation and accessing host interfaces directly. | **SC-7** | 🔴 Critical |

---

## 5. Storage & Secrets Management

Controls for data protection, image integrity, and secure secrets handling.

| Check ID | Control Name | Description | QNRCS Ref | Severity |
|:--------:|:-------------|:------------|:---------:|:--------:|
| 30032 | No Secrets in Environment Variables | Audit `docker inspect` output to ensure no passwords or API keys are present in environment variables. | **DP-1** | 🔴 Critical |
| 30033 | Docker Content Trust (DCT) | Enable `DOCKER_CONTENT_TRUST=1` to verify image signatures before pulling. | **SI-2** | 🟠 High |
| 30034 | Automated Vulnerability Scanning | Integrate `docker scout` or Trivy with the Wazuh pipeline to scan images on every build. | **IR-1** | 🟠 High |
| 30035 | Prune Unused Images & Volumes | Regularly remove dangling images and unused volumes to reduce the local attack surface. | **CM-1** | 🟡 Medium |
| 30036 | TLS for Remote Docker Socket | If the Docker daemon is exposed remotely, enforce mutual TLS authentication. | **AC-1** | 🔴 Critical |
| 30037 | No Docker-in-Docker (DinD) | Never mount `/var/run/docker.sock` inside a container — it grants full host control. | **AC-3** | 🔴 Critical |
| 30038 | Mount `/tmp` as tmpfs | Use ephemeral `tmpfs` mounts for `/tmp` to prevent sensitive data from persisting on disk. | **SI-1** | 🟡 Medium |
| 30039 | Docker Swarm mTLS (if used) | If Swarm mode is active, ensure mutual TLS is enforced for all node-to-node communication. | **AC-1** | 🟠 High |
| 30040–50 | Custom Application Hardening | Organisation-specific controls mapping application-in-container requirements to QNRCS/CM-2. | **CM-2** | 🟡 Medium |

---

## QNRCS Reference Glossary

| QNRCS Code | Domain | Description |
|:----------:|:-------|:------------|
| **AC-1** | Identity & Access | Identity management, authentication, and access control |
| **AC-3** | Least Privilege | Restricting permissions to the minimum required |
| **AU-2** | Audit Events | Defining which system events must be audited |
| **AU-3** | Audit Content | Ensuring logs contain sufficient forensic detail |
| **CM-1** | Configuration Management | Baseline configuration and change control |
| **CM-2** | Configuration Management | Application-level configuration hardening |
| **DP-1** | Data Protection | Preventing exposure of sensitive data |
| **IR-1** | Incident Response | Detection and vulnerability management |
| **IR-2** | Incident Response | Availability and recovery planning |
| **SC-7** | Network Boundary Protection | Controlling network traffic and segmentation |
| **SI-1** | System Integrity | Protecting system components from tampering |
| **SI-2** | Flaw Remediation | Patch management and vulnerability remediation |

---

## Coverage Summary

| Category | Controls | Critical | High | Medium |
|:---------|:--------:|:--------:|:----:|:------:|
| Host & Daemon Security | 12 | 1 | 7 | 4 |
| Image & Build Security | 7 | 2 | 4 | 3 |
| Container Runtime | 8 | 3 | 5 | 0 |
| Networking & Logging | 4 | 1 | 3 | 0 |
| Storage & Secrets | 10 | 4 | 4 | 2 |
| **Total** | **41+** | **11** | **23** | **9** |

---

> 📌 **Note:** Controls 30040–50 are reserved for organisation-specific application hardening requirements and must be defined per deployment. See the [Contributing Guide](Contributing) for instructions on submitting new control definitions.

---

*Sovereign Shield Docker Benchmark v1.1 — Mapped to QNRCS (CNCS) · NIS2 Article 21 · April 2026*
*Maintained by [TiagoCCRaposo](https://github.com/TiagoCCRaposo)*
