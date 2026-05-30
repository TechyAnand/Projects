# CI/CD Complete Learning Guide

## Purpose

This guide serves as a comprehensive reference for understanding Continuous Integration (CI) and Continuous Delivery/Deployment (CD).

It is designed for:

- Learning DevOps Fundamentals
- Interview Preparation
- Daily DevOps Work
- CI/CD Pipeline Design
- Quick Revision

By the end of this guide, you will understand:

- What CI is
- What CD is
- Difference between CI and CD
- CI/CD Lifecycle
- CI/CD Pipeline Components
- Popular CI/CD Tools
- Deployment Strategies
- Best Practices
- Interview Questions

---

# What is CI/CD?

CI/CD is a DevOps practice that automates software development, testing, and deployment.

CI/CD helps teams deliver software:

- Faster
- More Frequently
- More Reliably
- With Fewer Errors

---

# Why CI/CD?

Traditional Deployment Process:

    Developer Writes Code
             |
             v
    Manual Build
             |
             v
    Manual Testing
             |
             v
    Manual Deployment
             |
             v
         Production

Problems:

- Slow Releases
- Human Errors
- Inconsistent Deployments
- Delayed Feedback

CI/CD solves these challenges through automation.

---

# What is Continuous Integration (CI)?

Continuous Integration is the practice of frequently merging code changes into a shared repository and automatically validating them.

Goal:

    Detect Problems Early

---

## CI Workflow

    Developer
         |
         v
    Git Commit
         |
         v
    Build
         |
         v
    Unit Tests
         |
         v
    Code Quality Checks
         |
         v
     Success

---

# What Happens in CI?

Whenever code is pushed:

1. Source Code Checkout
2. Build Application
3. Run Unit Tests
4. Run Code Quality Checks
5. Security Scanning
6. Generate Artifacts

Example:

Developer Pushes Code

    git push

Automatically triggers:

    Build
      |
      v
    Test
      |
      v
    Validation

---

# Benefits of CI

- Early Bug Detection
- Faster Feedback
- Better Code Quality
- Reduced Integration Issues
- Automated Testing

---

# What is Continuous Delivery (CD)?

Continuous Delivery ensures that code is always ready for deployment.

After CI completes:

    Build Artifact
          |
          v
     Deploy to Test
          |
          v
      Deploy to Stage
          |
          v
     Ready for Production

Production deployment still requires manual approval.

---

# What is Continuous Deployment?

Continuous Deployment goes one step further.

Every successful change is automatically deployed to production.

    Code Commit
          |
          v
        Build
          |
          v
        Test
          |
          v
       Deploy
          |
          v
      Production

No manual approval required.

---

# Difference Between CI and CD

| Feature | Continuous Integration | Continuous Delivery | Continuous Deployment |
|----------|----------|----------|----------|
| Build Automation | Yes | Yes | Yes |
| Test Automation | Yes | Yes | Yes |
| Deployment Automation | No | Partial | Full |
| Production Approval Required | N/A | Yes | No |
| Main Goal | Validate Code | Prepare Release | Automatic Release |

---

# Simple Understanding

CI:

    "Is my code good?"

CD (Delivery):

    "Is my code ready to deploy?"

CD (Deployment):

    "Deploy my code automatically."

---

# Complete CI/CD Lifecycle

    Developer Commit
            |
            v
       Source Control
            |
            v
        Build Stage
            |
            v
        Unit Tests
            |
            v
     Code Quality Scan
            |
            v
     Security Scanning
            |
            v
        Package Build
            |
            v
      Artifact Storage
            |
            v
       Deploy to Dev
            |
            v
      Deploy to Test
            |
            v
      Deploy to Stage
            |
            v
      Production Approval
            |
            v
      Deploy Production

---

# CI Pipeline Stages

## Stage 1: Source Code Checkout

Retrieve code from Git.

Examples:

    GitHub
    GitLab
    Bitbucket
    Oracle SCM

---

## Stage 2: Build

Compile application.

Examples:

Java:

    mvn clean package

NodeJS:

    npm install

Go:

    go build

---

## Stage 3: Unit Testing

Run automated tests.

Examples:

    JUnit
    PyTest
    Jest
    Go Test

Purpose:

- Detect bugs early
- Validate functionality

---

## Stage 4: Code Quality Analysis

Analyze code quality.

Popular Tools:

    SonarQube
    Checkstyle
    PMD

Checks:

- Code Smells
- Bugs
- Technical Debt

---

## Stage 5: Security Scanning

Analyze vulnerabilities.

Popular Tools:

    Trivy
    Snyk
    OWASP Dependency Check

Checks:

- CVEs
- Dependency Vulnerabilities
- Security Risks

---

## Stage 6: Package Artifact

Create deployable package.

Examples:

    .jar
    .war
    Docker Image
    Binary

---

# Artifact Repository

Artifacts are stored in repositories.

Popular Options:

    Nexus
    Artifactory
    OCI Artifact Registry
    Docker Hub

Purpose:

- Version Control
- Artifact Storage
- Release Management

---

# CD Pipeline Stages

## Deploy to Development

Purpose:

- Initial validation
- Developer testing

---

## Deploy to QA

Purpose:

- Functional Testing
- Regression Testing

---

## Deploy to Staging

Purpose:

- Production-like testing
- User Acceptance Testing

---

## Deploy to Production

Purpose:

- Release application to end users

---

# CI/CD Architecture

    Developers
         |
         v
       Git
         |
         v
      CI Tool
         |
         v
       Build
         |
         v
       Test
         |
         v
      Artifact
         |
         v
     CD Pipeline
         |
         v
     Dev / Test
         |
         v
      Staging
         |
         v
     Production

---

# Popular CI/CD Tools

## Jenkins

Most widely used CI/CD tool.

Features:

- Pipelines
- Plugins
- Distributed Builds

---

## GitHub Actions

Built into GitHub.

Features:

- Workflow Automation
- CI/CD Pipelines
- Cloud Native Integration

---

## GitLab CI/CD

Integrated with GitLab.

Features:

- Pipelines
- Runners
- Security Scans

---

## OCI DevOps

Oracle Cloud Native CI/CD Service.

Features:

- Build Pipelines
- Deployment Pipelines
- OKE Integration

---

## Azure DevOps

Microsoft DevOps Platform.

Features:

- Repositories
- Pipelines
- Boards

---

# Deployment Strategies

## Recreate

Old version removed first.

    V1 Removed
         |
         v
    V2 Deployed

Simple but causes downtime.

---

## Rolling Deployment

Gradually replaces instances.

    V1 V1 V1 V1
         |
         v
    V2 V1 V1 V1
         |
         v
    V2 V2 V1 V1

No downtime.

---

## Blue-Green Deployment

Two environments:

    Blue
    Green

Switch traffic after validation.

Benefits:

- Fast Rollback
- Low Risk

---

## Canary Deployment

Deploy to a small group first.

    5% Users → V2

If successful:

    100% Users → V2

Benefits:

- Risk Reduction
- Gradual Release

---

# CI/CD Best Practices

1. Commit Frequently
2. Automate Everything
3. Keep Pipelines Fast
4. Run Unit Tests Early
5. Shift Security Left
6. Store Secrets Securely
7. Use Versioned Artifacts
8. Implement Rollback Strategies
9. Monitor Deployments
10. Use Infrastructure as Code

---

# Common Interview Questions

## What is CI?

Continuous Integration is the process of automatically building and testing code whenever changes are committed.

---

## What is CD?

Continuous Delivery or Continuous Deployment automates application releases.

---

## Difference Between Continuous Delivery and Continuous Deployment?

Continuous Delivery:

    Manual Production Approval

Continuous Deployment:

    Automatic Production Deployment

---

## Why is CI Important?

Benefits:

- Faster Feedback
- Better Quality
- Early Bug Detection

---

## What Happens During a CI Pipeline?

    Checkout
    Build
    Test
    Scan
    Package

---

## What Happens During a CD Pipeline?

    Deploy Dev
    Deploy QA
    Deploy Stage
    Deploy Production

---

## What is an Artifact?

A deployable package generated during build.

Examples:

    JAR
    WAR
    Docker Image
    Binary

---

## What is a Rollback?

Returning to a previous stable version after deployment failure.

---

# Quick Revision Cheat Sheet

CI:

    Build
    Test
    Validate

CD:

    Release
    Deploy
    Deliver

Pipeline:

    Code
      |
      v
    Build
      |
      v
    Test
      |
      v
    Scan
      |
      v
    Package
      |
      v
    Deploy

Popular Tools:

    Jenkins
    GitHub Actions
    GitLab CI/CD
    OCI DevOps
    Azure DevOps

Deployment Strategies:

    Recreate
    Rolling
    Blue-Green
    Canary

---

# Key Takeaway

CI/CD is the backbone of modern DevOps.

Continuous Integration focuses on:

- Building
- Testing
- Validating code

Continuous Delivery/Deployment focuses on:

- Releasing
- Deploying
- Delivering software

Mastering CI/CD concepts is essential for DevOps Engineers, Cloud Engineers, Platform Engineers, and Site Reliability Engineers because nearly every modern software delivery process depends on automated pipelines.
