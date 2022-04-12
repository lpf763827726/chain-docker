#!/usr/bin/env bash

# Do docker login manually

set -e

function show_usage() {
    echo "Usage: $(basename "$0") chain_dir options"
    echo "Options:"
    echo "    -b docker build"
    echo "    -p docker push"
    echo "    -h help"
    exit 0
}

[ $# -lt 2 ] && show_usage

CHAIN=$(basename "$1"); shift

echo $CHAIN

while getopts 'bpdh' opt; do
    case "$opt" in
    b) DOCKER_BUILD=TRUE ;;
    p) DOCKER_PUSH=TRUE ;;
    h | ? | *) show_usage ;;
    esac
done

cd $CHAIN

DOCKER_IMAGE_TAG=${CHAIN}:dev

if [ "$DOCKER_BUILD" == TRUE ]; then
    echo "===> Deleting old docker images..."
    docker images --format '{{.Repository}} {{.ID}}' | grep "${CHAIN}" | cut -d' ' -f2 | xargs docker rmi | true

    echo "===> Docker build..."
    docker build -t "$DOCKER_IMAGE_TAG" .
fi

if [ "$DOCKER_PUSH" == TRUE ]; then
    echo "===> Docker pushing..."
    docker push "$DOCKER_IMAGE_TAG"
fi

cd --