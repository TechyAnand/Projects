# syntax=docker/dockerfile:1

############################################################
# Base stage
############################################################
FROM golang:1.22-alpine AS base
WORKDIR /src
RUN apk add --no-cache ca-certificates

############################################################
# Dependency stage
############################################################
FROM base AS deps
COPY go.mod go.sum ./
RUN go mod download

############################################################
# Test stage
############################################################
FROM deps AS test
COPY . .
RUN go test ./...

############################################################
# Build stage
############################################################
FROM deps AS build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/app ./main.go

############################################################
# Runtime stage
############################################################
FROM gcr.io/distroless/static-debian12:nonroot AS runtime
WORKDIR /
COPY --from=build /out/app /app
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/app"]

############################################################
# Optional debug stage
############################################################
FROM alpine:3.20 AS debug
WORKDIR /
RUN apk add --no-cache curl bash ca-certificates
COPY --from=build /out/app /app
EXPOSE 8080
ENTRYPOINT ["/app"]
