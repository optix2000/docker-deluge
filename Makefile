
all: alpine debian

alpine:
	docker build -f Dockerfile.alpine-base . -t optix2000/deluge-base:latest
	docker build -f Dockerfile.deluge . -t optix2000/deluge:latest
	docker build -f Dockerfile.web . -t optix2000/deluge-web:latest
	./tag.sh optix2000/deluge:latest
	./tag.sh optix2000/deluge-web:latest

debian:
	docker build -f Dockerfile.debian-base . -t optix2000/deluge-base:debian
	docker build -f Dockerfile.deluge . -t optix2000/deluge:debian --build-arg BASE_TAG=debian
	docker build -f Dockerfile.web . -t optix2000/deluge-web:debian --build-arg BASE_TAG=debian
	./tag.sh optix2000/deluge:debian
	./tag.sh optix2000/deluge-web:debian

upload:
	docker push optix2000/deluge:latest
	docker push optix2000/deluge:debian
	docker push optix2000/deluge-web:latest
	docker push optix2000/deluge-web:debian
