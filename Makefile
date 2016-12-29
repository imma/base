include Makefile.docker

docker:
	$(MAKE) reset-xenial build publish
