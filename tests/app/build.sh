#!/usr/bin/env bash
# cp -rf ./packages/hoppscotch-selfhost-web/Dockerfile ./
rm -f docker-compose.yml
cp ./prod.Dockerfile ./Dockerfile
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --target app --output type=docker,name=elestio4test/hoppscotch-app:latest | docker load
