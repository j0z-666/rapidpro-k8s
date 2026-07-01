#!/bin/bash

set -e

VERSION2600=main
VERSION2601=main
REGISTRY=us-central1-docker.pkg.dev/mgcp-10078073-nono-card-dev/nonodev-rapidpro

echo "Building RapidPro..."

docker build \
  --no-cache \
  --build-arg RAPIDPRO_VERSION=nonoBranch \
  -t rapidpro:nonoBranch \
  -t $REGISTRY/rapidpro:nonoBranch \
  ./docker/rapidpro

echo "Building Mailroom..."

docker build \
  -t mailroom:v26.2.0 \
  -t $REGISTRY/mailroom:v26.2.0 \
  https://github.com/nyaruka/mailroom.git#v26.2.0

echo "Building Courier..."

docker build \
  -t courier:v26.2.1 \
  -t $REGISTRY/courier:v26.2.1 \
  https://github.com/nyaruka/courier.git#v26.2.1

echo "Building Indexer..."

# docker build \ Ya no se usa en 2026-July Snapshot 
#   -t indexer:$VERSION2601 \
#   -t $REGISTRY/indexer:$VERSION2601 \
#   https://github.com/nyaruka/rp-indexer.git#$VERSION2601

echo "Pushing images to Google Artifact Registry..."

docker push $REGISTRY/rapidpro:nonoBranch
docker push $REGISTRY/mailroom:v26.2.0
docker push $REGISTRY/courier:v26.2.1
# docker push $REGISTRY/indexer:$VERSION2601

echo "Done 🚀"
