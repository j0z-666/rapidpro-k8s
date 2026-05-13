Build Rapidpro Images and load them locally

chmod +x scripts/build-images.sh
./scripts/build-images.sh


helm upgrade rapidpro ./charts/rapidpro -n rapidpro -f ./charts/rapidpro/values.yaml