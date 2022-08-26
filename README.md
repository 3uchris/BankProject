# Bank Services
This is a backend web service for a bank. It will provide APIs for the frontend to do the following things:<br/><br/>

## Services and Functions
1. Create and manage bank accounts, which are composed of owner’s name, balance, and currency.
2. Record all balance changes to each of the account. So every time some money is added to or subtracted from the account, an account entry record will be created.
3. Perform a money transfer between 2 accounts. This should happen within a transaction, so that either both accounts’ balance are updated successfully or none of them are.<br/><br/>

## Step 1: Working with Database - Postgres
* Design DB schema and generate SQL code with dbdiagram.io
* Use Docker + Postgres + TablePlus to create DB
* Write and run database migration in Golang
* Generate CRUD code in Golang using sqlc
* Write unit tests for database CURD
* Handle deadlock and DB transaction lock 
* Setup Github Actions to run automated tests<br/><br/>
  
## Step 2: Building RESTful HTTP JSON API - Gin
* Implement RESTful HTTP API in Go using Gin
* Load config frm file & environment variable in Go with Viper
* Mock DB for testing HTTP API in Go and achieve 100% coverage
* Implement transfer money API with a custom params validator
* Add users table with unique & foreign key constraints in PostgreSQL
* Hash password in Go with Bcrypt
* Write and verify JWT and PASETO token
* Implement login user API that returns PASETO or JWT access Token in GO
* Implement authentication middleware and authorization rules in Golang using Gin<br/><br/>
  
## Step 3: Deploying the application to produciton - Kubernetes + AWS
* Build a minimal Golang Docker image with a multistage Dockerfile
* Use docker network to connect 2 stand-alone containers
* Auto build & push docker image to AWS ECR with Github Actions
* Create a production DB on AWS RDS
* Store & retrieve production secrets with AWS secrets manager
* Kubernetes architecture & create an EKS cluster on AWS
* Use kubectl & k9s to connect to a kubernetes cluster on AWS EKS
* Deploy a web app to Kubernetes cluster on AWS EKS
* Register a domain name & set up A-record using Route53
* Uuse Ingress to route traffics to different services in Kubernetes
* Automatic issue TLS certificates in Kubernetes with Let's Encrypt
* Automatic deploy to Kubernetes with Github Action 
  <br/><br/>
  <br/><br/>
# Local Setup
### Migrate
```
brew install golang-migrate
```
### Gomock
```
go install github.com/golang/mock/mockgen@v1.6.0
```
### SQLC
```
brew install sqlc
```
