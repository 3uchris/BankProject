postgres:
	docker run --name postgres12 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root BankProject

dropdb:
	docker exec -it postgres12 dropdb BankProject

migrateup:
	migrate -path db/migration -database "postgresql://root:qwertyuiop1111@bank-project.ck0becx39sni.ca-central-1.rds.amazonaws.com:5432/bank_project" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/BankProject?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/BankProject?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/BankProject?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/3uchris/BankProject/db/sqlc Store 

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock