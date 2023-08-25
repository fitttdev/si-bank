postgres:
	docker run --name postgresql -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 --restart unless-stopped postgres:15-alpine

createdb:
	docker exec -it postgresql createdb --username=postgres --owner=postgres si_bank

dropdb:
	docker exec -it postgresql dropdb --username=postgres si_bank

pshell:
	docker exec -it postgresql psql -U postgres

create-migration:
	migrate create -ext sql -dir db/migrations -seq $(arg) # make create-migration arg=schema_name

upmigrate:
	migrate -path db/migrations -database "postgresql://postgres:postgres@localhost:5432/si_bank?sslmode=disable" -verbose up

downmigrate:
	migrate -path db/migrations -database "postgresql://postgres:postgres@localhost:5432/si_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb pshell create-migration upmigrate downmigrate sqlc test
