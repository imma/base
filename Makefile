include $(_ubuntu_home)/Makefile.dream
include $(_ubuntu_home)/Makefile.build

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

docker_default = docker-base

aws_default = aws-base

docker-base:
	$(MAKE)
	$(make) build

aws-base:
	$(MAKE)
	env van rebase base

reset-docker:
	docker pull ubuntu:xenial
	docker tag ubuntu:xenial $(registry)/block:xenial
	docker tag $(registry)/block:xenial $(registry)/$(image)

new-cidata:
	$(MAKE) clean-cidata
	$(MAKE)
