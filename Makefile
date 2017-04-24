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

new-cidata:
	$(MAKE) clean-cidata
	$(MAKE)

virtualbox:
	$(make) virtualbox-iso

virtualbox-iso:
	$(MAKE) new-cidata
	time env http_proxy=$(cache_vip) plane media base

virtualbox-ovf:
	$(MAKE) new-cidata
	time env http_proxy=$(cache_vip) OVF_SOURCE="$$HOME/.vagrant.d/boxes/block:xenial/0/virtualbox/box.ovf" plane repackage base

aws:
	$(MAKE)
	time van rebase base
