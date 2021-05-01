IMAGE_TAG ?= nut-upsd

.PHONY: update-tags docker-build

docker-build:
	# https://github.com/docker/buildx#building
	docker buildx build \
		--tag $(IMAGE_TAG) \
		--platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6 \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--load \
		./docker

update-tags:
	git checkout main
	git tag -s -f -a -m "latest series" latest
	git checkout -
	git push origin refs/tags/latest -f
