include Makefile.docker

docker-image:
	time $(MAKE) reset-xenial build publish

docker-update:
	time $(MAKE) clean daemon build publish
