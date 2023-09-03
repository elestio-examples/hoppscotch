#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

docker-compose exec -T hoppscotch-backend /bin/sh -c "pnpx prisma migrate deploy"




target=$(docker-compose port hoppscotch-backend 3170)

curl http://${target}/v1/auth/signin?origin=admin \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'pragma: no-cache' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
  --data-raw '{"email":"'${ADMIN_EMAIL}'"}' \
  --compressed

docker-compose exec -T hoppscotch-db sh -c "psql -U postgres postgres <<EOF
\c hoppscotch
UPDATE \"User\" SET \"displayName\"='admin', \"isAdmin\"='true' WHERE \"email\"='${ADMIN_EMAIL}';
EOF";