# Linux Commands for DevSecOps Engineers

## Overview

This guide contains the Linux commands most commonly used by DevSecOps engineers for:

- System administration
- Security investigations
- Log analysis
- Incident response
- Container troubleshooting
- Kubernetes operations
- Compliance checks

---

# System Information

Check OS:

    cat /etc/os-release

Kernel information:

    uname -a

Hostname:

    hostnamectl

Current user:

    whoami

Logged-in users:

    w

---

# File Operations

List files:

    ls -la

Find files:

    find / -name "*.log"

Search text:

    grep -Ri "password" /etc

View file:

    cat file.txt

Monitor logs:

    tail -f application.log

---

# User & Permission Management

User details:

    id username

Check sudo access:

    sudo -l

File permissions:

    ls -l

Change permissions:

    chmod 755 script.sh

Change ownership:

    chown user:group file.txt

Find SUID files:

    find / -perm -4000 2>/dev/null

Find world writable files:

    find / -type f -perm -0002 2>/dev/null

---

# Process Monitoring

Running processes:

    ps -ef

Real-time monitoring:

    top

Search process:

    ps -ef | grep nginx

Kill process:

    kill -9 PID

---

# Memory & Disk

Memory:

    free -m

Disk usage:

    df -h

Directory size:

    du -sh /var/log

---

# Network Troubleshooting

IP addresses:

    ip addr

Routes:

    ip route

Open ports:

    ss -tulpn

Active connections:

    ss -antp

DNS lookup:

    dig google.com

Connectivity:

    ping google.com

API testing:

    curl https://example.com

---

# Log Analysis

System logs:

    journalctl -xe

Service logs:

    journalctl -u nginx

Authentication logs:

    cat /var/log/auth.log

Failed logins:

    grep "Failed password" /var/log/auth.log

Successful logins:

    grep "Accepted password" /var/log/auth.log

---

# Security Auditing

SSH configuration:

    cat /etc/ssh/sshd_config

Enabled services:

    systemctl list-unit-files --state=enabled

Running services:

    systemctl list-units --type=service

Search SSH keys:

    find /home -name authorized_keys

Search private keys:

    find / -name "*.pem" 2>/dev/null

Firewall rules:

    iptables -L

SELinux:

    sestatus

AppArmor:

    aa-status

---

# Docker Security

Running containers:

    docker ps

Images:

    docker images

Container logs:

    docker logs CONTAINER_ID

Inspect container:

    docker inspect CONTAINER_ID

Container shell:

    docker exec -it CONTAINER_ID bash

---

# Kubernetes Security

Pods:

    kubectl get pods -A

Services:

    kubectl get svc -A

Secrets:

    kubectl get secrets -A

Pod logs:

    kubectl logs POD_NAME

Describe pod:

    kubectl describe pod POD_NAME

Pod shell:

    kubectl exec -it POD_NAME -- bash

---

# Incident Response Quick Checklist

Who is logged in?

    w

What processes are running?

    ps -ef

What ports are open?

    ss -tulpn

Any failed logins?

    grep "Failed password" /var/log/auth.log

Recent system events:

    journalctl -xe

Suspicious files:

    find /tmp -type f

---

# DevSecOps Cheat Sheet

System:

    uname -a
    hostnamectl
    free -m
    df -h

Processes:

    ps -ef
    top

Network:

    ip addr
    ss -tulpn
    curl

Logs:

    journalctl -xe
    tail -f app.log

Security:

    sudo -l
    find / -perm -4000
    grep "Failed password"

Docker:

    docker ps
    docker logs

Kubernetes:

    kubectl get pods
    kubectl logs

---

# Key Takeaway

Mastering these commands helps with:

- Security investigations
- Vulnerability analysis
- Compliance audits
- Container troubleshooting
- Kubernetes operations
- Incident response

These commands form the daily toolkit of most DevSecOps engineers.
