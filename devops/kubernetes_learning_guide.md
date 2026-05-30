# Kubernetes Complete Learning Guide

## Purpose

This guide serves as a comprehensive Kubernetes reference for:

- Learning Kubernetes
- Daily DevOps Operations
- Platform Engineering
- Cloud-Native Development
- Interview Preparation
- Quick Revision

By the end of this guide, you should understand:

- What Kubernetes is
- Why Kubernetes is used
- Kubernetes Architecture
- Pods
- ReplicaSets
- Deployments
- Services
- ConfigMaps
- Secrets
- Volumes
- Ingress
- Namespaces
- StatefulSets
- Kubernetes Lifecycle
- Common kubectl Commands
- Best Practices
- Interview Questions

---

# What is Kubernetes?

Kubernetes (K8s) is an open-source Container Orchestration Platform used to deploy, manage, scale, and monitor containerized applications.

Originally developed by Google and now maintained by CNCF (Cloud Native Computing Foundation).

---

# Why Kubernetes?

Without Kubernetes:

    Container 1
    Container 2
    Container 3

Problems:

- Manual deployments
- Manual scaling
- Manual recovery
- Difficult upgrades
- No self-healing

With Kubernetes:

    Kubernetes Cluster
            |
            +--> Deploy
            +--> Scale
            +--> Heal
            +--> Monitor

Benefits:

- Automated Deployments
- Auto Scaling
- Self Healing
- Load Balancing
- High Availability

---

# Kubernetes Architecture

    +----------------------------------+
    |          Control Plane           |
    +----------------------------------+
           |      |      |      |
           |      |      |      |
           v      v      v      v

      API Server
      Scheduler
      Controller Manager
      ETCD

                 |
                 |
                 v

    +--------------------------+
    |      Worker Nodes        |
    +--------------------------+

       Kubelet
       Kube Proxy
       Pods

---

# Control Plane Components

## API Server

The front door of Kubernetes.

Responsibilities:

- Receives requests
- Validates requests
- Updates cluster state

Example:

    kubectl get pods

communicates with API Server.

---

## ETCD

Distributed key-value database.

Stores:

- Cluster state
- Configuration
- Secrets
- Deployments

Think of ETCD as:

    Database of Kubernetes

---

## Scheduler

Decides where Pods run.

Responsibilities:

- Resource allocation
- Node selection
- Workload distribution

---

## Controller Manager

Ensures desired state matches actual state.

Example:

Desired:

    3 Pods

Actual:

    2 Pods

Controller automatically creates:

    1 New Pod

---

# Worker Node Components

## Kubelet

Agent running on every node.

Responsibilities:

- Communicate with API Server
- Start containers
- Monitor Pods

---

## Kube Proxy

Handles networking.

Responsibilities:

- Traffic routing
- Load balancing
- Service communication

---

# Kubernetes Objects

Everything in Kubernetes is an object.

Examples:

- Pod
- ReplicaSet
- Deployment
- Service
- Namespace
- ConfigMap
- Secret
- StatefulSet

---

# Pod

Smallest deployable unit in Kubernetes.

A Pod can contain:

    Container

or

    Container 1
    Container 2

Example:

    nginx-pod

Think of Pod as:

    Wrapper around containers

---

# Pod Lifecycle

    Pending
       |
       v
    Running
       |
       v
   Succeeded

or

     Failed

---

# ReplicaSet

Ensures desired number of Pods are running.

Example:

Desired:

    3 Pods

Current:

    2 Pods

ReplicaSet creates:

    1 Pod

Benefits:

- High Availability
- Self Healing

---

# Deployment

Most commonly used Kubernetes object.

Responsibilities:

- Create Pods
- Manage ReplicaSets
- Rolling Updates
- Rollbacks

Example:

    Deployment
          |
          v
      ReplicaSet
          |
          v
         Pods

---

# Service

Pods are temporary.

IP addresses can change.

Services provide stable access.

Types:

1. ClusterIP
2. NodePort
3. LoadBalancer
4. ExternalName

---

## ClusterIP

Default Service Type.

Accessible only inside cluster.

Example:

    frontend-service

---

## NodePort

Exposes application using node port.

Example:

    http://node-ip:30080

---

## LoadBalancer

Creates external load balancer.

Common in:

- OCI
- AWS
- Azure
- GCP

---

# Namespace

Logical separation inside cluster.

Examples:

    default
    kube-system
    dev
    test
    prod

Benefits:

- Isolation
- Security
- Organization

---

# ConfigMap

Stores non-sensitive configuration.

Examples:

    APP_PORT=8080
    APP_NAME=myapp

Benefits:

- Separate configuration from code

---

# Secret

Stores sensitive information.

Examples:

    Passwords
    Tokens
    API Keys

Never store secrets directly in deployment files.

---

# Volumes

Pods are ephemeral.

Without Volumes:

    Pod Deleted
          |
          v
       Data Lost

Volumes provide persistent storage.

---

# Ingress

Manages external HTTP/HTTPS access.

Without Ingress:

    Load Balancer per Application

With Ingress:

    Single Entry Point
            |
      ----------------
      |              |
      v              v

    App1          App2

Benefits:

- Cost Reduction
- Centralized Routing

---

# StatefulSet

Used for stateful applications.

Examples:

- MySQL
- PostgreSQL
- MongoDB
- Kafka

Provides:

- Stable Hostnames
- Stable Storage
- Ordered Deployment

---

# Kubernetes Lifecycle

Typical Workflow:

    Create YAML
          |
          v
    kubectl apply
          |
          v
     Deployment
          |
          v
      ReplicaSet
          |
          v
         Pods
          |
          v
      Service
          |
          v
      Application

---

# kubectl Commands

## Check Cluster

    kubectl cluster-info

---

## View Nodes

    kubectl get nodes

---

## View Pods

    kubectl get pods

Detailed:

    kubectl get pods -o wide

---

## View Deployments

    kubectl get deployments

---

## View Services

    kubectl get svc

---

## Describe Pod

    kubectl describe pod <pod-name>

---

## View Logs

    kubectl logs <pod-name>

Follow Logs:

    kubectl logs -f <pod-name>

---

## Execute Command

    kubectl exec -it <pod-name> -- bash

---

## Apply Configuration

    kubectl apply -f deployment.yaml

---

## Delete Resource

    kubectl delete -f deployment.yaml

---

## Scale Deployment

    kubectl scale deployment nginx --replicas=5

---

## Rollout Status

    kubectl rollout status deployment/nginx

---

## Rollback Deployment

    kubectl rollout undo deployment/nginx

---

# Kubernetes Deployment Lifecycle

    Create Deployment
            |
            v
      kubectl apply
            |
            v
        Deployment
            |
            v
        ReplicaSet
            |
            v
           Pods
            |
            v
         Service
            |
            v
         Users

---

# Common Interview Questions

## What is Kubernetes?

Kubernetes is a container orchestration platform used to automate deployment, scaling, and management of containerized applications.

---

## What is a Pod?

Smallest deployable unit in Kubernetes.

Contains one or more containers.

---

## What is ReplicaSet?

Ensures a specified number of Pods are always running.

---

## Difference Between Pod and Deployment?

Pod:

- Runs container

Deployment:

- Manages Pods
- Supports scaling
- Supports rollbacks

---

## Difference Between ConfigMap and Secret?

ConfigMap:

- Non-sensitive data

Secret:

- Sensitive data

---

## What is ETCD?

Distributed key-value database storing cluster state.

---

## What is Kubelet?

Agent running on every worker node.

---

## What is Ingress?

HTTP/HTTPS traffic routing mechanism.

---

## What is Namespace?

Logical separation within cluster.

---

## What is StatefulSet?

Workload controller for stateful applications.

---

# Best Practices

1. Use Namespaces
2. Use Resource Limits
3. Store Secrets in Kubernetes Secrets
4. Use Health Checks
5. Use Rolling Updates
6. Avoid Running Containers as Root
7. Use RBAC
8. Monitor Cluster Health
9. Use Ingress Controllers
10. Keep Images Lightweight

---

# Quick Revision Cheat Sheet

Check Nodes:

    kubectl get nodes

Check Pods:

    kubectl get pods

Check Services:

    kubectl get svc

Apply YAML:

    kubectl apply -f file.yaml

Delete Resource:

    kubectl delete -f file.yaml

View Logs:

    kubectl logs pod-name

Scale Deployment:

    kubectl scale deployment app --replicas=5

Rollback:

    kubectl rollout undo deployment/app

Describe Resource:

    kubectl describe pod pod-name

Execute Inside Pod:

    kubectl exec -it pod-name -- bash

---

# Key Takeaway

Kubernetes is the industry-standard platform for container orchestration.

Mastering:

- Pods
- Deployments
- Services
- ConfigMaps
- Secrets
- Ingress
- StatefulSets
- kubectl
- Kubernetes Architecture

provides the foundation required for modern DevOps, Platform Engineering, Cloud Engineering, and Site Reliability Engineering (SRE) roles.

Kubernetes is one of the most important technologies in today's cloud-native ecosystem and a must-have skill for every DevOps Engineer.
