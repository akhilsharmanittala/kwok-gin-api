# Stage 1: Build the Go binary
FROM golang:1.24-alpine AS builder  
# Updated Go version

# Install necessary tools
RUN apk update && apk add --no-cache git

# Set working directory inside the container
WORKDIR /workspace

# Copy the entire project into the workspace
COPY . .

# Build the Go binary
RUN go build -o manager main.go

# Stage 2: Final image based on Kwok cluster image
FROM registry.k8s.io/kwok/cluster:v0.4.0-k8s.v1.28.0

# Set working directory
WORKDIR /opt/interceptor

# Install bash for running shell scripts (if needed)
RUN apk update && apk add --no-cache bash

# Copy the built Go binary from the builder stage
COPY --from=builder /workspace/manager .

# Copy all shell scripts from builder stage
COPY --from=builder /workspace/scripts/*.sh ./

# Ensure all scripts are executable
RUN chmod +x *.sh

# Set entrypoint to the Go binary
ENTRYPOINT ["./manager"]
