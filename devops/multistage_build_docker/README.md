# Docker Multi-Stage Build Demo

## Overview

This repository demonstrates Docker Multi-Stage Builds using a simple Go application.

Multi-stage builds are a Docker best practice that allows developers to separate the build environment from the runtime environment, resulting in:

- Smaller container images
- Faster deployments
- Improved security
- Cleaner Dockerfiles
- Better CI/CD integration

---

## Repository Structure

text docker-multistage-demo/ ├── .dockerignore ├── Dockerfile ├── README.md ├── go.mod ├── main.go └── main_test.go 

---

## What is a Multi-Stage Build?

A traditional Docker image often contains:

- Application source code
- Build tools
- Package managers
- Runtime dependencies

This increases image size and security exposure.

A multi-stage build separates the build process into multiple stages:

text Build Stage     |     |-- Compile application     |-- Execute tests     |     v Runtime Stage     |     |-- Copy only compiled artifacts     |     v Production Image 

The final image contains only the files required to run the application.

---

## Dockerfile Walkthrough

### Stage 1 – Base Stage

dockerfile FROM golang:1.22-alpine AS base  WORKDIR /src  RUN apk add --no-cache ca-certificates 

#### Purpose

Creates a reusable base image containing:

- Alpine Linux
- Go 1.22 SDK
- SSL certificates

#### Why?

This stage provides a common foundation that can be reused by later stages, reducing duplication.

---

### Stage 2 – Dependency Stage

dockerfile FROM base AS deps  COPY go.mod ./  RUN go mod download 

#### Purpose

Downloads all Go module dependencies.

#### Why?

Separating dependency downloads improves Docker layer caching.

If application code changes but dependencies remain the same, Docker reuses this layer and avoids downloading modules again.

---

### Stage 3 – Test Stage

dockerfile FROM deps AS test  COPY . .  RUN go test ./... 

#### Purpose

Executes unit tests during the container build process.

#### Why?

Ensures application quality before creating deployable artifacts.

Benefits include:

- Early failure detection
- CI/CD validation
- Automated quality checks

---

### Stage 4 – Build Stage

dockerfile FROM deps AS build  COPY . .  RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \     go build -o /out/app ./main.go 

#### Purpose

Compiles the application into a standalone executable.

#### Output

text /out/app 

#### Why?

Production environments do not require source code or compilers.

Only the compiled binary is needed.

---

### Stage 5 – Runtime Stage

dockerfile FROM gcr.io/distroless/static-debian12:nonroot AS runtime  WORKDIR /  COPY --from=build /out/app /app  EXPOSE 8080  USER nonroot:nonroot  ENTRYPOINT ["/app"] 

#### Purpose

Creates the final production image.

#### Why Distroless?

Distroless images contain only the runtime components required to execute the application.

They intentionally exclude:

- Shells
- Package managers
- Debugging tools
- Build utilities

Benefits:

- Reduced attack surface
- Smaller image size
- Improved security posture

---

### Copying Build Artifacts

dockerfile COPY --from=build /out/app /app 

Copies the compiled application from the build stage into the runtime image.

Only the executable is included.

Source code and build dependencies are excluded.

---

### Exposing the Application Port

dockerfile EXPOSE 8080 

Documents that the application listens on TCP port 8080.

---

### Running as a Non-Root User

dockerfile USER nonroot:nonroot 

Running containers as a non-root user is a security best practice and reduces privilege escalation risks.

---

### Application Startup

dockerfile ENTRYPOINT ["/app"] 

Defines the executable that starts when the container launches.

---

## Build Process Flow

text +----------------------+ | Base Stage           | | Go + Alpine          | +----------+-----------+            |            v +----------------------+ | Dependency Stage     | | Download Modules     | +----------+-----------+            |            v +----------------------+ | Test Stage           | | Execute Unit Tests   | +----------+-----------+            |            v +----------------------+ | Build Stage          | | Compile Application  | +----------+-----------+            |            v +----------------------+ | Runtime Stage        | | Copy Binary Only     | +----------------------+ 

---

## Building the Image

Build the production image:

bash docker build -t docker-multistage-demo . 

Build only the test stage:

bash docker build --target test -t docker-multistage-demo-test . 

Build only the build stage:

bash docker build --target build -t docker-multistage-demo-build . 

---

## Running the Application

bash docker run --rm -p 8080:8080 docker-multistage-demo 

Access the application:

text http://localhost:8080 

---

## Benefits of Multi-Stage Builds

| Benefit | Description |
|----------|-------------|
| Smaller Images | Only runtime artifacts are included |
| Improved Security | Build tools are excluded from production |
| Faster Deployments | Reduced image size improves transfer speed |
| Better Maintainability | Clear separation of responsibilities |
| CI/CD Friendly | Tests and builds can be executed independently |
| Optimized Caching | Dependencies are cached separately |

---

## Key Takeaways

- Multi-stage builds separate build and runtime concerns.
- Production images should contain only runtime artifacts.
- Dependency caching improves build performance.
- Distroless images reduce security risks.
- Running as a non-root user is a recommended container security practice.

Docker Multi-Stage Builds are widely adopted across modern cloud-native environments and are considered a standard approach for building production-ready container images.
