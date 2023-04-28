#!/bin/bash
# Install pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.47.0/release.yaml

# Install triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.23.0/release.yaml

# Install intercepters
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.23.0/interceptors.yaml
