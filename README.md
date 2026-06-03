Build Rapidpro Images and load them locally

# Authenticate with Google Artifact Registry
gcloud auth configure-docker us-central1-docker.pkg.dev

# Build and push all images
chmod +x scripts/build-images.sh
./scripts/build-images.sh

docker build \
  --no-cache \
  --build-arg RAPIDPRO_VERSION=v26.0.0 \
  -t rapidpro:v26.0.0 \
  -t us-central1-docker.pkg.dev/mgcp-10078073-nono-card-dev/nonodev-rapidpro/rapidpro:v26.0.0 \
  ./docker/rapidpro

docker push us-central1-docker.pkg.dev/mgcp-10078073-nono-card-dev/nonodev-rapidpro/rapidpro:v26.0.0

helm upgrade rapidpro ./charts/rapidpro -n rapidpro -f ./charts/rapidpro/values.yaml
 kubectl rollout restart deployment/rapidpro-rapidpro-rapidpro -n rapidpro
