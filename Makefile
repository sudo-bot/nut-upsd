IMAGE_TAG ?= nut-upsd

.PHONY: update-tags docker-build

docker-build:
	docker build ./docker \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--tag $(IMAGE_TAG)

update-tags:
	git checkout main
	git tag -s -f -a -m "latest series" latest
	git checkout -
	git push origin refs/tags/latest -f
