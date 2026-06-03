#!/bin/bash

set -e

VERSION2600=v26.0.0
VERSION2601=v26.0.1
REGISTRY=us-central1-docker.pkg.dev/mgcp-10078073-nono-card-dev/nonodev-rapidpro

echo "Building RapidPro..."

docker build \
  --no-cache \
  --build-arg RAPIDPRO_VERSION=$VERSION2600 \
  -t rapidpro:$VERSION2600 \
  -t $REGISTRY/rapidpro:$VERSION2600 \
  ./docker/rapidpro

echo "Building Mailroom..."

docker build \
  -t mailroom:$VERSION2600 \
  -t $REGISTRY/mailroom:$VERSION2600 \
  https://github.com/nyaruka/mailroom.git#$VERSION2600

echo "Building Courier..."

docker build \
  -t courier:$VERSION2601 \
  -t $REGISTRY/courier:$VERSION2601 \
  https://github.com/nyaruka/courier.git#$VERSION2601

echo "Building Indexer..."

docker build \
  -t indexer:$VERSION2601 \
  -t $REGISTRY/indexer:$VERSION2601 \
  https://github.com/nyaruka/rp-indexer.git#$VERSION2601

echo "Pushing images to Google Artifact Registry..."

docker push $REGISTRY/rapidpro:$VERSION2600
docker push $REGISTRY/mailroom:$VERSION2600
docker push $REGISTRY/courier:$VERSION2601
docker push $REGISTRY/indexer:$VERSION2601

echo "Done 🚀"
