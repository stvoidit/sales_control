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
	--host=localhost \
	--port=5432 \
	--username=postgres \
	-f scripts/docker-entrypoint-initdb/0_init_db.sql


docker.clean.db:
	docker-compose down && docker volume rm fatify-server_pgdata
