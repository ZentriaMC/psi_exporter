#!/bin/sh
set -e

docker build \
	-t zentria/psi-exporter \
	-t docker.zentria.ee/svc/psi-exporter \
	-f docker/Dockerfile .
