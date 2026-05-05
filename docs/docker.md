# Relatório de Implementação: Hardening de Contentores — Sovereign Shield

> **Data:** 05 de Maio de 2026
> **Responsável:** Tiago Raposo
> **Alvo:** Infraestrutura Docker (Ubuntu 22.04 LTS)
> **Frameworks:** QNRCS (Portugal) & Diretiva NIS2 (Artigo 21.º)

---

## 1. Resumo Executivo

Foi implementado um módulo customizado de **Security Configuration Assessment (SCA)** no Wazuh para monitorização contínua da postura de segurança do motor Docker. O benchmark, designado **"Sovereign Shield"**, foca-se na redução da superfície de ataque e na conformidade com as normas nacionais de cibersegurança.

---

## 2. Metodologia de Hardening

O benchmark está estruturado em **4 pilares críticos**:

| # | Pilar | Descrição |
|---|-------|-----------|
| 1 | **Configuração do Host** | Isolamento de partições (`/var/lib/docker`) e auditoria de binários via `auditd` |
| 2 | **Segurança de Imagens** | Proibição de segredos em variáveis de ambiente e uso de instruções seguras (`COPY` vs `ADD`) |
| 3 | **Proteção de Runtime** | Restrição de privilégios (`no-new-privileges`), limites de recursos (CPU/RAM) e isolamento de namespaces |
| 4 | **Governação e Segredos** | Controlo de permissões do socket Unix e integração de logs centralizada |

---

## 3. Detalhes Técnicos da Implementação

### 3.1. Integração com o Agente Wazuh

- **Localização da Política:** `/var/ossec/etc/sca/docker-qnrcs.yml`
- **Configuração do Agente:** O ficheiro `ossec.conf` foi ajustado para incluir a nova política, garantindo a execução no arranque e a cada **12 horas**.
- **Permissões:** O utilizador `wazuh` foi adicionado ao grupo `docker` para permitir a execução de comandos de inspeção sem necessidade de privilégios de root.

### 3.2. Resolução de Conflitos (Parser)

Durante a implementação, identificou-se uma sensibilidade do motor SCA a:

- Caracteres de fim de linha (**LF vs CRLF**)
- Ordem de processamento de ficheiros YAML

A solução passou pela simplificação da sintaxe e garantia de **codificação Unix pura (LF)**.

---

## 4. Lista de Controlos Ativos

| ID | Controlo | Objetivo |
|----|----------|----------|
| `30002` | Permissões do Socket | Impedir que utilizadores não autorizados lancem contentores |
| `30003` | User Root | Garantir que nenhum processo dentro do contentor tem privilégios de admin no host |
| `30022` | Read-Only Rootfs | Impedir modificações persistentes em caso de compromisso do contentor |
| `30049` | No-New-Privileges | Bloquear a escalada de privilégios via binários SUID |

---

## 5. Próximos Passos e Manutenção

- **Monitorização de Dashboards:** Revisão semanal dos alertas de falha no dashboard SCA do Wazuh.
- **Remediação:** Aplicar as correções sugeridas para os IDs que apresentem estado `Failed`.
- **Atualização:** Revisão semestral do benchmark para alinhar com novas versões do Docker Engine (atualmente na **v29.4**).

---

*Documento gerado no âmbito do projeto Sovereign Shield — Infraestrutura Docker segura e conforme com a Diretiva NIS2.*
