#!/usr/bin/env bash
# cp -rf ./packages/hoppscotch-sh-admin/Dockerfile ./
cp ./prod.Dockerfile ./Dockerfile
rm -f docker-compose.yml
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


docker buildx build . --target sh_admin --output type=docker,name=elestio4test/hoppscotch-sh-admin:latest | docker load
