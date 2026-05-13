Build Rapidpro Images and load them locally

chmod +x scripts/build-images.sh
./scripts/build-images.sh

docker build --no-cache -f docker/rapidpro/Dockerfile -t us-central1-docker.pkg.dev/nonodev/nonodev/rapidpro:v26.0.0 docker/rapidpro

helm upgrade rapidpro ./charts/rapidpro -n rapidpro -f ./charts/rapidpro/values.yaml

