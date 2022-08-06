# BankProject
Design, develop and deploy a backend system that has operations of a bank from scratch using PostgreSQL, Golang and Docker.


The operations:
    1.Create and manage accounts that compose of owners, balances and currency
    2.Record all balance changes(create an account entry record for each change)
    3.Money transfer transaction(perform money transfer between two accounts consistently within a transaction)
  
 
    Step 1: Database Design:
    Tools that I uses: Docker, TablePlus
    * Design SQL database schema using dbdiagram.io
    * Automatically generate SQL code to create the schema in a target database engine: PostgreSQL/MySQL/SQL Server

we use homebrew to download golang-migrate and use command     migrate create -ext sql -dir db/migration -seq init_schema   to create two migration files(one is up, one is down), the up-script is to make a forward change to the schema, and the down-script is to revert the changes made by the up-script.

We generate the CURD Golang code, and CREATE is to insert new record to the databse, READ is to select or to search a records in the dataabse, UPDATE is to change some fields of the record in the database, and DELETE is to remove records from database.

There are serveal ways to implement CURD operations in Golang
1.use a low-level standard library database/sql package  
(We use the QueryRowContext()function, and pass in the raw SQL query and some parameters, then we scan the result into target variables. Pros: very fast and straightforward. Cons: manually mapping SQL fields to variables which is easy to make mistakes, the errors will only show up in rum time )
2.use a High-level object-relational-mapping libarary GORM in Golang
(CURD functions already implemented, which results in short production code, the only issue is that we need to learn how to writes queries using gorm's porvided funcitons, and it runs very slow if the traffic is high )
3.The middle-way approach: SQLX library
(Quit fast& easy to use, and fields mapping via query text&struct tags, yet the errors won't show up until runtime)
4.SQLC
(Very fast&easy to use, and more importantly idiomatic Golang CURD codes will be automatically generated, and it also catches SQL query errors before generating codes, yet it has full support on postgres, and MySQL is still experimental)

In this project, SQLC library will be used! 
1.You write SQL queries
2.You run sqlc to generate Go code that presents type-safe interfaces to those queries
3.You write application code that calls the methods sqlc generated

I will write unit test for those CURD operation, to see whether the automatcally generated code works.
all those unit test will be wrote in the sqlc folder: account_test.go, entry_test.go, and transfer.test.go
in order to write teh test, we have to set up the connection and the Queries object first , and we write a main_test.go