include .env
export

run.dev.backend:
	cd src/backend && pnpm run dev
run.dev.frontend:
	cd src/frontend && pnpm run dev

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
	--username=${PGUSER} \
	-f scripts/docker-entrypoint-initdb/0_create_database.sql


docker.clean.db:
	docker-compose down && docker volume rm fatify-server_pgdata
docker.build:
	docker build -f ${PWD}/Dockerfile -t sales_control_application:latest .


curl.insert.user:
	curl -X POST -o - \
	-H "Content-Type: application/json" \
	--data '{"login":"admin","password":"123", "name":"admin","address":"root"}' \
	http://localhost:8080/api/users
