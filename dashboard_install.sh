#!/bin/bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/previous/v0.35.0/release.yaml
# Port forward
echo "To port forward run the following"
echo "kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097"
