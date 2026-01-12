# Incident Reports (RCA)

This document contains incident reports generated during the Azure ACE Minimal Lab.
All incidents were handled using standard incident response steps:
detection, analysis, resolution, and lessons learned.

------------------------------------------------------------------------------

## Incident 1: High CPU Utilization on Linux VM

**Date/Time:**  
Saturday January 10, 2026

**Impact:**  
Elevated CPU usage could degrade application performance if sustained.

**Detection:**  
Azure Monitor alert triggered when average CPU usage exceeded 60%.

**Root Cause:**  
Intentional CPU stress process executed on the VM to validate monitoring and alerting behavior.

**Resolution:**  
CPU-intensive process completed and terminated, returning CPU utilization to normal levels.

**Prevention:**  
Establish baseline performance thresholds and investigate unexpected CPU spikes promptly.

**Lessons Learned:**  
Metric-based alerts provide early visibility into performance issues before they affect availability.

---

## Incident 2: SSH Access Blocked Due to NSG Misconfiguration

**Date/Time:**  
Saturday, January 10, 2026

**Impact:**  
Administrative access to the VM was unavailable, preventing routine management tasks.

**Detection:**  
Manual detection after repeated SSH connection failures.

**Root Cause:**  
Inbound NSG rule was modified with an incorrect source IP, blocking legitimate access.

**Resolution:**  
Restored the SSH inbound rule with the correct source IP (/32), re-enabling access.

**Prevention:**  
Apply change tracking for NSG modifications and restrict admin access using Bastion or VPN.

**Lessons Learned:**  
Network security misconfigurations can cause availability-like incidents even when compute is healthy.

