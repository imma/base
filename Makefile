include Makefile.docker

docker_default = docker-image

docker-image:
	time $(make) nc reset-xenial build

docker-update:
	time $(make) nc clean daemon build

docker-bump:
	$(make) bump
	git add .serial
	git commit -m "bump to $(shell cat .serial)"
	git push
	$(make) docker
