
IMAGE ?= argoworkflow-addon
IMAGE_REGISTRY ?= docker.io/mikeshng
IMAGE_TAG ?= latest
IMG ?= $(IMAGE_REGISTRY)/$(IMAGE):$(IMAGE_TAG)

.PHONY: docker-build
docker-build: ## Build docker image
	docker build -t ${IMG} .

.PHONY: docker-push
docker-push: ## Push docker image with the manager
	docker push ${IMG}
