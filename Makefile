include Makefile.docker

docker-image:
	time $(MAKE) reset-xenial build publish

docker-update:
	time $(MAKE) clean daemon build publish clean

docker-bump:
	$(MAKE) bump
	git add .serial
	git commit -m "bump to $(shell cat .serial)"
	git push
	$(MAKE) docker-image
