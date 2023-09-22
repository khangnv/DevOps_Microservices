#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="khangnv09/project3"

# Step 2
# Run the Docker Hub container with Kubernetes
kubectl run project3 \
    --image=$dockerpath \
    --port=80 --labels "app=project3"

# Step 3:
# List Kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward project3 8000:80
