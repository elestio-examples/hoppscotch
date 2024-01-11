#!/usr/bin/env bash
# cp -rf ./packages/hoppscotch-selfhost-web/Dockerfile ./
rm -f docker-compose.yml
cp ./prod.Dockerfile ./Dockerfile
mv docker-compose-new.yml docker-compose.yml

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 5282,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT


docker buildx build . --target app --output type=docker,name=elestio4test/hoppscotch-app:latest | docker load
