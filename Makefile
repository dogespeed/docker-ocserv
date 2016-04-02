all: docker

docker:
	docker build -t dogespeed/anyconnect .
