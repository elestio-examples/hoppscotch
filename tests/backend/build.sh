#!/usr/bin/env bash
cp -rf ./packages/hoppscotch-backend/* ./
rm -f docker-compose.yml
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --output type=docker,name=elestio4test/hoppscotch-backend:latest | docker load
