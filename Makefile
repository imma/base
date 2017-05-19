include Makefile.dream
include Makefile.docker

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

docker_default = docker-base

aws_default = aws-base

docker-base:
	$(MAKE)
	time $(make) build
	$(make) tag_hub

aws-base:
	$(MAKE)
	time env AWS_TYPE=$(aws_type) van rebase base

reset:
	docker pull ubuntu:xenial
	docker tag ubuntu:xenial $(registry)/block:xenial
	docker tag $(registry)/block:xenial $(registry)/$(image)

new-cidata:
	$(MAKE) clean-cidata
	$(MAKE)

virtualbox:
	$(make) virtualbox-iso

virtualbox-iso:
	$(MAKE) new-cidata
	time env http_proxy=http://$(cache_vip):3128 plane media base

virtualbox-ovf:
	$(MAKE) new-cidata
	time env http_proxy=http://$(cache_vip):3128 OVF_SOURCE="$$HOME/.vagrant.d/boxes/block:xenial/0/virtualbox/box.ovf" plane repackage base

