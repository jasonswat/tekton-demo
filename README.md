### Tekton Demo

Github: https://github.com/tektoncd/


### Setup

 1. Install minicube
 2. Start minicube kubernetes cluster
```
minikube start --kubernetes-version "v1.24.0" --addons registry --addons registry-aliases --container-runtime containerd
```

### Install Tekton

Installs pipelines and triggers
```
./tekton_install.sh
```

Install dashboard
```
./install_dashboard.sh
```

Install tekton cli
```
brew install tektoncd-cli
```

Install git-clone task
```
tkn hub install task git-clone
```

### Setup Github Triggers

Triggers should already be installed

 1. Install the service account rbac role:
```
kc apply -f even-triggers-rbac.yaml
```
 2. Create the event listener:
```
kc apply -f event-listener.yml
tkn eventlisteners list
NAME        AGE              URL                                                  AVAILABLE
github-pr   12 seconds ago   http://el-github-pr.default.svc.cluster.local:8080   False
```
 3. Listener is only internal at this point, we'll forward the port to ngrok to make it availible
```
kubectl port-forward svc/el-github-pr 8080:8080
```
 4. Install sign up and install ngrok https://dashboard.ngrok.com/ and start ngrok
```
ngrok http http://localhost:8080
```




## Troubleshooting

#### testing dns

Run a small image to test dns
```
kubectl run -it --rm busybox --image=busybox /bin/sh
# nslookup www.google.com
```
Test minikube dns
```
$ minikube ssh
$ nslookup kube-dns.kube-system.svc.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local
```


#### delete and start new minikube cluster
```
minikube delete
minikube start --kubernetes-version "v1.24.0" --addons registry --addons registry-aliases --container-runtime containerd
```


### Resources:

 * https://dev.to/leandronsp/tekton-ci-part-iii-listen-to-github-events-1h3i
 * Event Listener Rbac: https://gist.github.com/leandronsp/7cdf211797397ae513fc1d0dc0c5cf8b
