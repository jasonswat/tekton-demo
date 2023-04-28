default: help

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[\/a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}' Makefile

check-var = $(if $(strip $($1)),,$(error var for "$1" is empty))

REVISION = "1.4"
STATSD_VERSION = "14.2"
REPOSITORY = ""
build: ## Build python Docker Image
	@docker build -t $(REPOSITORY)/statsd:$(STATSD_VERSION)-$(REVISION) -f Dockerfile .

run: ## Run docker image locally to check contents
	@docker run --rm -it $(REPOSITORY)/statsd:$(STATSD_VERSION)-$(REVISION) sh

push: ## Push Docker Images to artifactory
	@docker push $(REPOSITORY)/statsd:$(STATSD_VERSION)-$(REVISION)

deploy: ## Deploy to kubernetes
	@kubectl create -f deployment.yaml

delete: ## Delete kubernetes deployment, volume, and service
	@kubectl delete -f deployment.yaml
