#!/usr/bin/env bash
rm package.json
cp -rf ./packages/hoppscotch-sh-admin/* ./
rm -f docker-compose.yml
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --output type=docker,name=elestio4test/hoppscotch-admin:latest | docker load
