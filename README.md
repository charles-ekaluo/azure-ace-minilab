# Azure ACE Minimal Lab – Terraform, Monitoring & Incident Response

## Overview
This project demonstrates a minimal but production-relevant Azure infrastructure deployment using Terraform, combined with monitoring, alerting, and incident response practices.

The focus is on **infrastructure as code**, **observability**, and **operational thinking**, rather than feature volume.

---

## Architecture
The following resources were deployed in Azure:

- Resource Group (with governance tags)
- Virtual Network (10.10.0.0/16)
- Subnet (10.10.1.0/24)
- Network Security Group (SSH restricted to a single IP)
- Ubuntu Linux Virtual Machine
- Azure Monitor (Log Analytics + VM Insights)
- CPU usage alert (threshold: >60%)

All core infrastructure was provisioned using **Terraform**.

---

## Infrastructure as Code (Terraform)
Terraform was used to:
- Provision Azure networking and compute resources
- Apply security controls via NSGs
- Ensure repeatable and auditable deployments

The Terraform configuration can be found in the `terraform/` directory.

---

## Monitoring & Alerting
Azure Monitor and Log Analytics were configured to collect VM metrics.

An alert rule was created to trigger when:
- **Average CPU utilization exceeds 60%**

This validates proactive monitoring and early detection of performance issues.

---

## Incident Simulations
Two controlled incidents were simulated to demonstrate incident response and root cause analysis:

### 1. High CPU Utilization
- Triggered intentionally using a CPU stress process
- Alert fired via Azure Monitor
- Incident documented with RCA

### 2. SSH Access Blocked
- Caused by NSG inbound rule misconfiguration
- SSH access failed while VM remained healthy
- Access restored and RCA documented

Incident reports are available in `docs/rca.md`.

---

## Evidence
Screenshots validating deployment, monitoring, alerting, and incidents are available in the `screenshots/` directory.

---

## Key Skills Demonstrated
- Azure infrastructure deployment
- Terraform (IaC)
- Network security (NSGs)
- Monitoring and alerting
- Incident response and RCA documentation
- Operational troubleshooting

---

## Notes
This lab is intentionally minimal to reflect real-world engineering priorities:
clarity, correctness, and operational relevance over complexity.

