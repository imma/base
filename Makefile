include Makefile.dream
include Makefile.docker

docker_default = docker-image

docker-image:
	$(MAKE)
	time $(make) reset-xenial build

docker-update:
	$(MAKE)
	time $(make) clean daemon build

virtualbox:
	$(MAKE)
	time env http_proxy=$(cache_vip) plane rebase

aws:
	$(MAKE)
	time van rebase

clean-cidata:
	rm -rf cidata/.iso
	rm -rf .d/cidata
	rm -f cidata/meta-data
	rm -f cidata/user-data
