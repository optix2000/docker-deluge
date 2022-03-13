
all: alpine debian

alpine:
	docker build -f Dockerfile.alpine-base . -t optix2000/deluge-base:latest
	docker build -f Dockerfile.alpine-geoip . -t optix2000/deluge-base:geoip
	docker build -f Dockerfile.deluge . -t optix2000/deluge:latest
	docker build -f Dockerfile.web . -t optix2000/deluge-web:latest
	docker build -f Dockerfile.deluge . -t optix2000/deluge:geoip --build-arg BASE_TAG=geoip
	docker build -f Dockerfile.web . -t optix2000/deluge-web:geoip --build-arg BASE_TAG=geoip
	./tag.sh optix2000/deluge:latest
	./tag.sh optix2000/deluge-web:latest
	./tag.sh optix2000/deluge:geoip
	./tag.sh optix2000/deluge-web:geoip

debian:
	docker build -f Dockerfile.debian-base . -t optix2000/deluge-base:debian
	docker build -f Dockerfile.deluge . -t optix2000/deluge:debian --build-arg BASE_TAG=debian
	docker build -f Dockerfile.web . -t optix2000/deluge-web:debian --build-arg BASE_TAG=debian
	./tag.sh optix2000/deluge:debian
	./tag.sh optix2000/deluge-web:debian

upload:
	docker push --all-tags optix2000/deluge
	docker push --all-tags optix2000/deluge-web
