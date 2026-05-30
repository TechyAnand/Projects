# YAML Complete Learning Guide

## Purpose

This guide is a practical reference for learning YAML, revising key concepts, and using YAML in DevOps, cloud, CI/CD, and automation workflows.

By the end of this guide, you should understand:

- What YAML is
- Why YAML is used
- YAML syntax and structure
- Scalars, lists, and mappings
- Indentation rules
- YAML documents and anchors
- Common mistakes
- YAML in DevOps tools
- Best practices
- Interview questions

---

# What is YAML?

YAML stands for:

    YAML Ain't Markup Language

It is a human-readable data serialization format used to write configuration files.

YAML is commonly used in:

- Ansible playbooks
- Kubernetes manifests
- GitHub Actions workflows
- Docker Compose files
- CI/CD pipelines
- Application configuration files

---

# Why YAML?

YAML is popular because it is:

- Easy to read
- Easy to write
- Human-friendly
- Good for structured configuration
- Widely supported by DevOps tools

Example of a simple YAML file:

    name: DevOps
    level: beginner
    active: true

---

# YAML Basics

YAML is made up of:

- Keys
- Values
- Indentation
- Lists
- Nested objects

YAML uses indentation instead of braces and semicolons.

---

# Basic Syntax

Simple key-value pair:

    app_name: myapp

String:

    owner: kartheek

Number:

    port: 8080

Boolean:

    enabled: true

Null:

    description: null

---

# YAML Data Types

## 1. String

    name: ansible

## 2. Integer

    replicas: 3

## 3. Float

    version: 1.2

## 4. Boolean

    active: false

## 5. Null

    value: null

## 6. Date

    created_at: 2026-05-30

---

# YAML Collections

YAML supports three major collection types:

- Scalars
- Sequences
- Mappings

---

# Scalars

A scalar is a single value.

Examples:

    name: Terraform
    count: 5
    enabled: true

---

# Sequences

A sequence is a list of items.

Example:

    fruits:
      - apple
      - banana
      - mango

Equivalent JSON:

    {
      "fruits": ["apple", "banana", "mango"]
    }

---

# Mappings

A mapping is a key-value structure.

Example:

    server:
      host: localhost
      port: 8080

Equivalent JSON:

    {
      "server": {
        "host": "localhost",
        "port": 8080
      }
    }

---

# Indentation Rules

Indentation is very important in YAML.

Use spaces, not tabs.

Correct:

    app:
      name: demo
      port: 8080

Incorrect:

    app:
    name: demo
      port: 8080

One wrong space can break the file.

---

# Lists in YAML

List with hyphen syntax:

    servers:
      - web01
      - web02
      - web03

List of objects:

    users:
      - name: alice
        role: admin
      - name: bob
        role: developer

---

# Nested Structures

YAML supports nesting.

Example:

    app:
      name: demo
      env:
        type: dev
        region: ap-south-1

---

# Comments

Comments begin with `#`.

Example:

    # This is a comment
    app_name: sample

Comments are ignored by YAML parsers.

---

# Strings in YAML

## Plain strings

    message: hello world

## Quoted strings

    message: "hello world"
    message: 'hello world'

Quotes are useful when the string contains special characters.

---

# Multi-line Strings

YAML supports multi-line text in two common ways.

## Literal block style

Preserves line breaks:

    script: |
      echo "Hello"
      echo "World"

## Folded block style

Folds lines into a single line:

    description: >
      This is a long sentence
      that will become a single line.

---

# Boolean Values

Common boolean values:

    true
    false
    yes
    no
    on
    off

For clarity, prefer:

    true
    false

---

# Null Values

Null values can be written as:

    null
    ~

Example:

    value: null

---

# YAML Documents

A YAML file can contain multiple documents.

Each document begins with:

    ---

Example:

    ---
    name: app1
    port: 8080
    ---
    name: app2
    port: 9090

Document end marker:

    ...

---

# Anchors and Aliases

Anchors allow reuse of content.

Example:

    default: &default_settings
      region: ap-south-1
      enabled: true

    dev:
      <<: *default_settings
      env: dev

    prod:
      <<: *default_settings
      env: prod

This helps avoid repetition.

---

# YAML vs JSON

| YAML | JSON |
|------|------|
| Easier to read | More verbose |
| Supports comments | No comments |
| Common in DevOps | Common in APIs |
| Supports multi-line text | Limited text formatting |

Example YAML:

    app:
      name: demo
      port: 8080

Equivalent JSON:

    {
      "app": {
        "name": "demo",
        "port": 8080
      }
    }

---

# YAML in DevOps

YAML is used heavily in DevOps tools.

## Ansible

Example:

    ---
    - name: Install nginx
      hosts: webservers
      tasks:
        - name: Install package
          apt:
            name: nginx
            state: present

## Kubernetes

Example:

    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-pod
    spec:
      containers:
        - name: nginx
          image: nginx:latest

## Docker Compose

Example:

    services:
      app:
        image: nginx
        ports:
          - "8080:80"

## GitHub Actions

Example:

    name: CI
    on: [push]
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4

---

# YAML Best Practices

1. Use spaces, not tabs
2. Keep indentation consistent
3. Prefer simple, readable keys
4. Quote strings when needed
5. Use comments for clarity
6. Avoid deeply nested structures when possible
7. Validate YAML before using it
8. Use meaningful names
9. Keep lists and mappings clean
10. Use block style for long text

---

# Common YAML Mistakes

## 1. Wrong indentation

Incorrect:

    app:
    name: demo

Correct:

    app:
      name: demo

---

## 2. Using tabs

YAML does not like tabs.

Always use spaces.

---

## 3. Missing colon

Incorrect:

    name demo

Correct:

    name: demo

---

## 4. Mixing list and mapping incorrectly

Incorrect:

    users:
      name: alice
      - role: admin

Correct:

    users:
      - name: alice
        role: admin

---

## 5. Unquoted special values

Some values may be interpreted unexpectedly.

Example:

    yes
    no
    on
    off

When in doubt, quote the value.

---

# YAML Validation

Always validate YAML before using it.

Common tools:

- yamllint
- ansible-playbook --syntax-check
- kubectl apply --dry-run=client
- GitHub Actions workflow validation tools

Example command:

    yamllint file.yml

---

# Sample YAML for Learning

Example configuration:

    application:
      name: sample-app
      version: 1.0
      environment: local
      enabled: true
      ports:
        - 8080
        - 9090
      database:
        host: localhost
        port: 5432

---

# Real-World Use Cases

YAML is used for:

- Infrastructure automation
- Application deployment
- CI/CD pipelines
- Kubernetes deployments
- Configuration management
- Cloud-native application definitions

---

# Interview Questions

## What is YAML?

YAML is a human-readable data serialization format used mainly for configuration.

---

## Why is YAML used in DevOps?

Because it is simple, readable, and widely supported by automation tools.

---

## What is the difference between YAML and JSON?

YAML is more human-friendly and supports comments and multiline text.

---

## Why is indentation important in YAML?

Indentation defines structure and hierarchy.

---

## Can YAML contain multiple documents?

Yes, using `---` to separate documents.

---

## What are anchors and aliases?

They are YAML features used to reuse content and avoid repetition.

---

## Why are tabs discouraged in YAML?

Because YAML expects spaces for indentation.

---

# Quick Revision Cheat Sheet

Key syntax:

    key: value

List:

    items:
      - item1
      - item2

Nested object:

    app:
      name: demo
      port: 8080

Multi-line text:

    message: |
      line 1
      line 2

Document separator:

    ---

Comments:

    # comment

---

# Key Takeaway

YAML is a simple, readable configuration language that is widely used in DevOps and cloud tooling.

If you master:

- indentation
- mappings
- lists
- multi-line strings
- anchors
- validation

you will be able to work confidently with tools like Ansible, Kubernetes, Docker Compose, and CI/CD pipelines.
