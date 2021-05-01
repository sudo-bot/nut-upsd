IMAGE_TAG ?= nut-upsd
PLATFORMS ?= linux/amd64,linux/arm64,linux/ppc64le,linux/arm/v7,linux/arm/v6

.PHONY: update-tags docker-build

docker-build:
	# https://github.com/docker/buildx#building
	docker buildx build \
		--tag $(IMAGE_TAG) \
		--platform $(PLATFORMS) \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--load \
		./docker
