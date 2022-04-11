#!/bin/bash

REGISTRY=hub.17usoft.com/k8s-test
LOCAL_IMAGE=k8s-event:latest
docker build -f ./Dockerfile --build-arg ARCH="amd64" -t "$REGISTRY/$LOCAL_IMAGE" .
