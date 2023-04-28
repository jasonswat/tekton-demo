#!/bin/bash
minikube start --kubernetes-version "v1.24.0" --addons registry --addons registry-aliases --container-runtime containerd
