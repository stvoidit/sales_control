include .env
export

run.dev.backend:
	cd src/backend && pnpm run start

ddl.dump.schema:
	pg_dump -v \
	--format=plain \
	--create \
	--use-set-session-authorization \
	--no-password \
	--schema-only \
	--dbname=sales_control \
	--host=${PGHOST} \
	--port=${PGPORT} \
	--username=postgres \
	-f scripts/docker-entrypoint-initdb/0_create_database.sql


docker.clean.db:
	docker-compose down && docker volume rm fatify-server_pgdata


curl.insert.user:
	curl -X POST -o - \
	-H "Content-Type: application/json" \
	--data '{"email":"alex","password":"xyz123", "name":"Александр","address":"Москва"}' \
	http://localhost:3000/api/users
