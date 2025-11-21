# 🚀 Kubernetes Cluster Provisioning, Monitoring & Logging (Terraform + AKS + Prometheus + Grafana + Fluent Bit)

This project is a complete implementation of the assessment:

**“Provision a Kubernetes cluster using Terraform, configure networking policies, deploy monitoring using Prometheus/Grafana, deploy a DaemonSet logging/monitoring agent, create dashboards, alerts, and provide a detailed README explaining the design.”**

---

# 📘 Table of Contents
1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Tools & Technologies](#tools--technologies)
4. [Directory / Module Structure](#directory--module-structure)
5. [Terraform Workflow](#terraform-workflow)
6. [AKS Cluster Provisioning](#aks-cluster-provisioning)
7. [Kubernetes Networking Policies](#kubernetes-networking-policies)
8. [Monitoring Stack (Prometheus + Grafana)](#monitoring-stack-prometheus--grafana)
9. [DaemonSet Logging Agent (Fluent Bit)](#daemonset-logging-agent-fluent-bit)
10. [Alerts (PrometheusRule)](#alerts-prometheusrule)
11. [Grafana Dashboards](#grafana-dashboards)
12. [Validation Steps](#validation-steps)
13. [Design Decisions](#design-decisions)
14. [Assumptions](#assumptions)
15. [How to Clean Up](#how-to-clean-up)
16. [Screenshots (Placeholders)](#screenshots-placeholders)

---

# 📌 Overview

This solution provisions:

✔ A Kubernetes (AKS) Cluster using **Terraform**  
✔ A modular Terraform structure supporting **dev** and **prod**  
✔ **Network Policies** for pod-level traffic control  
✔ Full Monitoring Stack:
   - Prometheus  
   - Alertmanager  
   - Grafana  
   - Node Exporter  
   - Kube-State-Metrics  
✔ Custom **Alert Rule (High CPU alert)** using PrometheusRule  
✔ A **DaemonSet Logging Agent (Fluent Bit)** running on every node  
✔ Grafana Dashboards (including the famous **Node Exporter Full** dashboard)  
✔ LoadBalancer exposure for Grafana & Prometheus  
✔ Step-by-step manual operational guide

The goal is to demonstrate both **Infrastructure as Code (IaC)** and **Observability** best practices.

---

# 🧩 Architecture

Below is the **high-level architecture**:

```mermaid
flowchart TD

A[TERRAFORM APPLY] --> B[Azure AKS Cluster]
B --> C[Kubernetes API Server]

subgraph Monitoring Namespace
    D[Prometheus Operator]
    E[Prometheus Server]
    F[Alertmanager]
    G[Grafana]
    H[Node Exporter DaemonSet]
    I[Kube-State-Metrics]
    J[Fluent Bit DaemonSet]
end

C --> D
D --> E
D --> F
E --> G
B --> H
B --> I
B --> J
