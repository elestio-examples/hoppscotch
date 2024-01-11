#!/usr/bin/env bash
docker-compose up -d;
sleep 45s;

docker-compose run -T hoppscotch-backend /bin/sh -c "pnpx prisma migrate deploy"

docker-compose down;
docker-compose up -d;

sleep 120s;

docker-compose exec -T hoppscotch-db sh -c "psql -U postgres postgres <<EOF
\c hoppscotch
UPDATE \"User\" SET \"displayName\"='admin', \"isAdmin\"='true' WHERE \"email\"='${ADMIN_EMAIL}';
EOF";