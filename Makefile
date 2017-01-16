include Makefile.docker

docker_default = docker-image

docker-image:
	time $(make) reset-xenial build publish

docker-update:
	time $(make) clean daemon build publish clean

docker-bump:
	$(make) bump
	git add .serial
	git commit -m "bump to $(shell cat .serial)"
	git push
	$(make) docker-image
