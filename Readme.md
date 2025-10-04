# Secure Investigations Platform (SIP) – Proof of Concept  

## Overview  
This Proof of Concept (PoC) demonstrates how to design, build, and operate a **secure, reliable, and developer-friendly Azure-native platform** aligned with the **Platform Engineer role at Clue**.  

The project delivers a lightweight **Investigations Portal** (frontend + API + database) and wraps it with the full platform engineering toolchain:  

- **Infrastructure as Code (IaC)** with Terraform.  
- **CI/CD automation** using Azure DevOps (with Octopus parity).  
- **DevSecOps practices** across code, infrastructure, and runtime.  
- **Secrets management & governance** using Key Vault and Azure Policy.  
- **Monitoring & reliability** with Application Insights, Log Analytics, SLOs, and runbooks.  
- **Developer experience improvements** with templates and automation.  
- **Cost optimisation** with budgets, autoscaling, and tagging.  

This project demonstrates the ability to provide **end-to-end lifecycle support** for Development, Test, and Production environments, with a strong focus on **security, reliability, and developer enablement**.  

---

## Architecture  
**Application Components:**  
- **Frontend**: React SPA hosted on Azure Static Web Apps.  
- **Backend**: .NET Minimal API (or Node/Express) deployed to Azure App Service.  
- **Database**: Azure SQL Database (auditing + backups enabled).  
- **Identity**: Entra ID (Azure AD) with role-based access (Investigator vs Viewer).  

**Platform Components:**  
- **Secrets**: Azure Key Vault.  
- **Observability**: Application Insights + Log Analytics.  
- **Governance**: Azure Policy (tagging, diagnostics, region compliance).  
- **Networking**: App Service restrictions + SQL firewall.  
- **Compliance/Security**: Defender for Cloud enabled.  


---

## Build Process  

### 1. Repository & Documentation  
- Set up repo and folder structure.  
- Write architecture overview (`docs/architecture.md`).  
- Create runbooks: incident, release, rollback, on-call.  
- Define SLOs and SLIs (`docs/security/sla-slo-sli.md`).  

### 2. Infrastructure as Code (IaC)  
- Build Terraform modules for App Service, Static Web App, SQL, Key Vault, App Insights, and Policy.  
- Configure remote state storage in Azure.  
- Apply Azure Policy for tags, diagnostics, and region restrictions.  

### 3. Application Layer  
- **Backend API**: CRUD for `Case` resource, with audit event logging.  
- **Frontend**: SPA to create/search cases.  
- **Identity**: Entra ID auth with Investigator/Viewer roles.  
- **Containerisation**: Dockerfile provided for API.  

### 4. Security Foundations  
- Secrets stored in **Key Vault**.  
- RBAC enforced for pipelines and engineers.  
- Compliance controls mapped to ISO 27001, NIST CSF, GDPR.  
- Defender for Cloud enabled.  

### 5. CI/CD Automation  
- Multi-stage Github actions pipeline with:  
  - **Build & Test** (compile, unit tests, SBOM).  
  - **Security Scans** (SAST, SCA, secrets, IaC, container).  
  - **Deploy** (Terraform apply, app deploy, secrets injection).  
  - **DAST Baseline** (OWASP ZAP).  
  - **Promotions** gated with manual approval and slot swaps.  
- Optional parity: Octopus Deploy release orchestration.  

### 6. Observability & Reliability  
- App Insights metrics: requests/sec, latency, error rate.  
- Log Analytics for infra logs.  
- Alerts: 5xx errors, latency p95 > 400ms, CPU > 80%, SQL DTU > 80%.  
- SLOs defined in `/docs/security/sla-slo-sli.md`.  
- Runbooks for incident management and rollback.  

### 7. Developer Experience  
- Reusable pipeline templates for build, deploy, and security.  
- One-click environment creation via Terraform + pipelines.  
- Onboarding documentation with local run + deployment steps.  

### 8. Cost Optimisation  
- Azure budgets + alerts configured.  
- Autoscale rules for App Service and SQL.  
- Tagging enforced via Azure Policy (Owner, CostCentre, Env).  
- FinOps checklist (`docs/finops.md`).  

---

## Deliverables  
- **Working Application**: Investigations Portal (cases create/search).  
- **Infrastructure as Code**: Terraform modules for full Azure stack.  
- **CI/CD Pipelines**: Azure DevOps multi-stage YAML with DevSecOps checks.  
- **Security**: Secrets in Key Vault, RBAC, DevSecOps scans, compliance mapping.  
- **Monitoring**: App Insights dashboards, alerts, SLOs.  
- **Documentation**: Architecture, runbooks, onboarding, FinOps.  

---

## Demo Script  
1. Trigger CI pipeline → build app, run tests, run security scans.  
2. Deploy infrastructure → App Service, Static Web App, SQL, Key Vault, App Insights.  
3. Deploy application → API + SPA, with secrets injected from Key Vault.  
4. Access the Investigations Portal → login with Entra ID, create/search cases.  
5. Show App Insights dashboard → latency, error rates, requests.  
6. Trigger test error → demonstrate alert in Azure Monitor.  
7. Show rollback runbook → perform slot swap rollback.  

---

