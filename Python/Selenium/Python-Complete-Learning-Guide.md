# Python Complete Learning Guide

## Purpose

This guide serves as a complete Python learning and revision reference for:

- Beginners
- DevOps Engineers
- DevSecOps Engineers
- Cloud Engineers
- Automation Engineers
- Interview Preparation

By the end of this guide, you will understand:

- Python Basics
- Variables
- Data Types
- Operators
- Control Flow
- Functions
- Modules
- File Handling
- Exception Handling
- OOP Concepts
- Python for Automation
- DevOps Use Cases

---

# What is Python?

Python is a high-level, interpreted, object-oriented programming language.

It is widely used for:

- Automation
- Web Development
- Data Science
- Machine Learning
- DevOps
- Cloud Engineering
- Security Automation

---

# Why Python?

Advantages:

- Easy to learn
- Readable syntax
- Large ecosystem
- Cross-platform
- Great for automation

Example:

    print("Hello World")

---

# Variables

Variables store data.

Example:

    name = "Kartheek"
    age = 30

Print:

    print(name)
    print(age)

---

# Data Types

String:

    name = "DevOps"

Integer:

    count = 10

Float:

    version = 1.5

Boolean:

    enabled = True

List:

    servers = ["web1", "web2"]

Tuple:

    ports = (80, 443)

Dictionary:

    user = {
        "name": "admin",
        "role": "devops"
    }

Set:

    unique_ids = {1, 2, 3}

---

# Operators

Arithmetic:

    +  -  *  /  %

Example:

    x = 10
    y = 5

    print(x + y)

Comparison:

    ==
    !=
    >
    <
    >=
    <=

Logical:

    and
    or
    not

---

# Conditional Statements

If:

    age = 18

    if age >= 18:
        print("Adult")

If Else:

    if age >= 18:
        print("Adult")
    else:
        print("Minor")

---

# Loops

For Loop:

    for i in range(5):
        print(i)

While Loop:

    count = 0

    while count < 5:
        print(count)
        count += 1

---

# Functions

Example:

    def greet(name):
        print("Hello", name)

    greet("DevOps")

Return Value:

    def add(a, b):
        return a + b

    result = add(5, 10)

---

# Lists

Create List:

    fruits = ["apple", "banana"]

Add Item:

    fruits.append("mango")

Remove Item:

    fruits.remove("banana")

Loop:

    for fruit in fruits:
        print(fruit)

---

# Dictionaries

Example:

    server = {
        "host": "localhost",
        "port": 8080
    }

Access Value:

    print(server["host"])

---

# String Operations

Upper Case:

    text.upper()

Lower Case:

    text.lower()

Replace:

    text.replace("old", "new")

Split:

    text.split(",")

---

# File Handling

Write File:

    with open("file.txt", "w") as f:
        f.write("Hello")

Read File:

    with open("file.txt", "r") as f:
        print(f.read())

---

# Exception Handling

Example:

    try:
        x = 10 / 0
    except ZeroDivisionError:
        print("Cannot divide by zero")

Finally:

    try:
        pass
    finally:
        print("Cleanup")

---

# Modules

Import Module:

    import os

Current Directory:

    print(os.getcwd())

---

# Common Modules

OS:

    import os

System:

    import sys

JSON:

    import json

Date:

    import datetime

Regex:

    import re

Subprocess:

    import subprocess

Requests:

    import requests

---

# Object-Oriented Programming

Class:

    class Server:

        def __init__(self, name):
            self.name = name

        def show(self):
            print(self.name)

Object:

    server = Server("web01")
    server.show()

---

# List Comprehension

Traditional:

    numbers = []

    for i in range(5):
        numbers.append(i)

List Comprehension:

    numbers = [i for i in range(5)]

---

# Lambda Functions

Example:

    square = lambda x: x * x

    print(square(5))

---

# Python Virtual Environment

Create:

    python3 -m venv venv

Activate Linux:

    source venv/bin/activate

Deactivate:

    deactivate

---

# Pip Package Manager

Install Package:

    pip install requests

List Packages:

    pip list

Upgrade:

    pip install --upgrade requests

---

# Python for DevOps

Common Use Cases:

- Infrastructure Automation
- Cloud Automation
- CI/CD Pipelines
- Monitoring
- Security Scanning
- Configuration Management

---

# Python and Linux

Execute Commands:

    import subprocess

    subprocess.run(["ls", "-la"])

---

# Python and APIs

Example:

    import requests

    response = requests.get("https://api.github.com")

    print(response.status_code)

---

# Python and JSON

Read JSON:

    import json

    data = '{"name":"devops"}'

    obj = json.loads(data)

Write JSON:

    json.dumps(obj)

---

# Python and YAML

Install:

    pip install pyyaml

Read YAML:

    import yaml

    with open("config.yml") as f:
        data = yaml.safe_load(f)

---

# Python Automation Example

Check Disk Usage:

    import shutil

    total, used, free = shutil.disk_usage("/")

    print(free)

---

# Python Best Practices

1. Use meaningful variable names
2. Follow PEP8
3. Use virtual environments
4. Handle exceptions properly
5. Write reusable functions
6. Use logging instead of print
7. Keep code modular

---

# Common Interview Questions

What is Python?

A high-level interpreted programming language.

---

Difference between List and Tuple?

List:

    Mutable

Tuple:

    Immutable

---

What is a Dictionary?

Key-value data structure.

---

What is Exception Handling?

Mechanism to handle runtime errors.

---

What is PIP?

Python package manager.

---

What is a Virtual Environment?

Isolated Python environment for dependencies.

---

# Quick Revision Cheat Sheet

Variables:

    x = 10

List:

    items = [1, 2, 3]

Dictionary:

    data = {"key": "value"}

Function:

    def test():
        pass

Loop:

    for i in range(5):
        pass

File:

    open("file.txt")

Exception:

    try:
        pass
    except:
        pass

Install Package:

    pip install requests

Virtual Environment:

    python3 -m venv venv

---

# Key Takeaway

Python is one of the most important languages for DevOps and DevSecOps engineers.

Mastering:

- Variables
- Functions
- Lists
- Dictionaries
- Files
- Exceptions
- APIs
- Automation

provides the foundation required for infrastructure automation, cloud operations, security tooling, and CI/CD automation.
