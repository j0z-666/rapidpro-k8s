#!/bin/bash

set -e

VERSION2600=v26.0.0
VERSION2601=v26.0.1
CLUSTER=rapidpro-test

echo "Building RapidPro..."

docker build \
  --build-arg RAPIDPRO_VERSION=$VERSION2600 \
  -t rapidpro:$VERSION2600 \
  ./docker/rapidpro

echo "Building Mailroom..."

docker build \
  -t mailroom:$VERSION2600 \
  https://github.com/nyaruka/mailroom.git#$VERSION2600

echo "Building Courier..."

docker build \
  -t courier:$VERSION2601 \
  https://github.com/nyaruka/courier.git#$VERSION2601

echo "Building Indexer..."

docker build \
  -t indexer:$VERSION2601 \
  https://github.com/nyaruka/rp-indexer.git#$VERSION2601

echo "Loading images into KIND..."

kind load docker-image rapidpro:$VERSION2600 --name $CLUSTER
kind load docker-image mailroom:$VERSION2600 --name $CLUSTER
kind load docker-image courier:$VERSION2601 --name $CLUSTER
kind load docker-image indexer:$VERSION2601 --name $CLUSTER

echo "Done 🚀"