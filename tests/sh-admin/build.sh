#!/usr/bin/env bash
cp -rf ./packages/hoppscotch-sh-admin/Dockerfile ./
rm -f docker-compose.yml
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --output type=docker,name=elestio4test/hoppscotch-sh-admin:latest | docker load