#!/bin/bash

set -e

VERSION=v26
VERSION_INDEXER=v26.0.1
CLUSTER=rapidpro-test

echo "Building RapidPro..."

docker build \
  --build-arg RAPIDPRO_VERSION=$VERSION \
  -t rapidpro:$VERSION \
  ./docker/rapidpro

echo "Building Mailroom..."

docker build \
  -t mailroom:$VERSION \
  https://github.com/nyaruka/mailroom.git#$VERSION

echo "Building Courier..."

docker build \
  -t courier:$VERSION \
  https://github.com/nyaruka/courier.git#$VERSION

echo "Building Indexer..."

docker build \
  -t indexer:$VERSION_INDEXER \
  https://github.com/nyaruka/rp-indexer.git#$VERSION_INDEXER

echo "Loading images into KIND..."

kind load docker-image rapidpro:$VERSION --name $CLUSTER
kind load docker-image mailroom:$VERSION --name $CLUSTER
kind load docker-image courier:$VERSION --name $CLUSTER
kind load docker-image indexer:$VERSION_INDEXER --name $CLUSTER

echo "Done 🚀"