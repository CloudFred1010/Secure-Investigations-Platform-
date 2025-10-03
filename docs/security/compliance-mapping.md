# Compliance Mapping
Placeholder for ISO27001 / NIST CSF / GDPR alignment.

# Compliance Mapping – Clue Secure Investigations Platform (SIP)

## Purpose
This document demonstrates how the Clue Secure Investigations Platform (SIP) aligns with recognised standards and regulations. It provides traceability from security controls in the platform to compliance requirements in **ISO 27001**, **NIST Cybersecurity Framework (CSF)**, and the **General Data Protection Regulation (GDPR)**.  

The goal is to evidence that security has been considered by design, implemented through Azure-native controls, and validated with operational processes.

---

## ISO 27001 Alignment

| ISO 27001 Control | Implementation in Clue SIP | Details |
|-------------------|-----------------------------|---------|
| **A.9.1 – Access Control Policy** | RBAC enforced across all resources. Key Vault access limited to App Service (Secrets User role) and Azure DevOps SP (Secrets Officer role). | Prevents excessive privilege by removing Contributor/Owner assignments. All access is least privilege and scoped to resource level only. |
| **A.9.2 – User Access Management** | Azure AD identities managed via Entra ID, with MFA enforced for engineers. | Reduces risk of credential misuse and ensures access traceability. |
| **A.10.1 – Cryptographic Controls** | Azure SQL and Key Vault enforce encryption at rest by default; TLS/HTTPS enforced for all web traffic. | Protects data in transit and at rest, using Microsoft-managed keys (BYOK optional). |
| **A.12.4 – Logging and Monitoring** | Application Insights and Log Analytics collect telemetry, metrics, and diagnostic logs. | Centralised monitoring ensures security and operational events are captured and auditable. |
| **A.12.6 – Technical Vulnerability Management** | Microsoft Defender for Cloud enabled at subscription scope for SQL, App Services, and Key Vaults. | Provides baseline recommendations, vulnerability scans, and secure score tracking. |
| **A.17.1 – Business Continuity** | Azure SQL backups and auditing enabled; runbooks prepared for incident, rollback, and recovery. | Supports resilience and recovery in case of outages or security incidents. |

---

## NIST Cybersecurity Framework (CSF) Alignment

| NIST CSF Category | Implementation in Clue SIP | Details |
|-------------------|-----------------------------|---------|
| **Identify (ID.AM-1) – Asset Management** | Infrastructure defined in Terraform with outputs for key resource IDs and URIs. | Codified infrastructure ensures all assets are visible, reproducible, and version controlled. |
| **Protect (PR.AC-4) – Access Control** | RBAC role assignments scoped at Key Vault for App Service and DevOps SP. | Prevents privilege escalation and enforces role separation. |
| **Protect (PR.DS-5) – Data Protection** | All secrets stored in Key Vault with no plain-text storage in pipelines or code. | Eliminates risk of secret leakage and ensures confidentiality. |
| **Detect (DE.CM-7) – Security Continuous Monitoring** | Diagnostics streamed to Log Analytics; Defender for Cloud alerts reviewed. | Provides real-time and historical detection of anomalies and threats. |
| **Respond (RS.RP-1) – Response Planning** | Runbooks defined for incident response, on-call escalation, and rollback. | Ensures consistent, repeatable response during a live incident. |
| **Recover (RC.RP-1) – Recovery Planning** | Database restore processes tested; rollback runbooks documented. | Guarantees platform can be recovered within SLOs if compromised or unavailable. |

---

## GDPR Alignment

| GDPR Article | Implementation in Clue SIP | Details |
|--------------|-----------------------------|---------|
| **Art. 25 – Data Protection by Design and Default** | Architecture ensures separation of duties and principle of least privilege. Sensitive values (DB connection strings, API keys) are never stored in config or code. | Protects personal data at design stage; minimises exposure by default. |
| **Art. 32 – Security of Processing** | SQL Database encrypted at rest; Web App enforces HTTPS only; FTPS disabled. | Technical measures guarantee confidentiality, integrity, and resilience of systems. |
| **Art. 33 – Breach Notification** | Defender for Cloud and Log Analytics alerts notify of anomalies; incident runbook covers escalation procedures. | Supports timely detection and reporting of breaches to supervisory authorities within 72 hours. |
| **Art. 35 – Data Protection Impact Assessment (DPIA)** | Threat model in `/docs/security/threat-model.md` highlights risks around personal data and mitigation steps. | Provides structured risk assessment for processing of case data. |

---

## Summary
The Clue SIP platform demonstrates compliance alignment by:  

- Using **RBAC and managed identities** for strict access control.  
- Storing all **sensitive data in Key Vault**, with no secrets in code or pipelines.  
- Enabling **Defender for Cloud** to identify vulnerabilities and enforce secure configurations.  
- Centralising **logs and monitoring** with Log Analytics and Application Insights.  
- Providing **runbooks and recovery documentation** to demonstrate operational readiness.  
- Supporting **ISO 27001, NIST CSF, and GDPR** obligations in a traceable, auditable manner.  

This mapping closes the **Phase 4 requirement (Security Foundations)** and provides the compliance evidence needed for the PoC.

