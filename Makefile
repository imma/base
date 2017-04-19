include Makefile.dream
include Makefile.docker

docker_default = docker-base

docker-base:
	$(MAKE)
	time $(make) build

reset:
	docker pull ubuntu:xenial
	docker tag ubuntu:xenial $(registry)/block:xenial
	docker tag $(registry)/block:xenial $(registry)/$(image)

virtualbox:
	$(MAKE) clean-cidata
	$(MAKE)
	time env http_proxy=$(cache_vip) plane media packer
	$(MAKE) clean-cidata
	$(MAKE)
	plane vagrant destroy -f || true
	time env http_proxy=$(cache_vip) BASEBOX_SOURCE="inception:packer" plane build

aws:
	$(MAKE)
	time van rebase
