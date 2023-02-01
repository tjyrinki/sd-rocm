.DEFAULT_GOAL := help

bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

build:
	docker build --tag webui --build-arg HSA_OVERRIDE_GFX_VERSION=10.3.0 .

run:
	docker run \
		--tty \
		--interactive \
		--device /dev/dri \
		--device /dev/kfd \
		--network host \
		--ipc host \
		--cap-add SYS_PTRACE \
		--security-opt seccomp=unconfined \
		--group-add render \
		--expose 9090 \
		--env HSA_OVERRIDE_GFX_VERSION=10.3.0 \
                --volume $(CURDIR)/cache:/root/.cache \
		--volume $(CURDIR)/output:/root/invokeai/outputs \
		--rm \
		webui

help:
	@printf '\n'
	@printf 'Run $(bold)make build$(sgr0) to build the container\n'
	@printf '\n'
	@printf 'Run $(bold)make run$(sgr0) to run the container\n'
	@printf '\n'
	@printf '\n'
	@printf 'Inside the container, the following commands are useful:\n'
	@printf '\n'
	@printf 'python scripts/preload_models.py # select models to use and download\n'
	@printf 'python scripts/invoke.py --web # start the web ui\n'
	@printf '\n'

