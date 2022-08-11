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




--Golang Unit test
I will write unit test for those CURD operation, to see whether the automatcally generated code works.
all those unit test will be wrote in the sqlc folder: account_test.go, entry_test.go, and transfer.test.go
in order to write teh test, we have to set up the connection and the Queries object first , and we write a main_test.go

we create folder "util" and we are gonna create a better way to generate test data instead of filling them manually as what we did for the create account arguement, we create a random.go. It is very important if we have a column with unique constrain in the database.




--Golang DB Transaction(combines some operations from several tables)
Database Transaction is a single unit of work, that often made up of multiple database operations.

In this case, we firstly create a transfer record with specific amount, and create two entries for account1 and account2, and subtract and add the specific amount to the two accounts.

We use database transaction, because (1)to provide a reliable and consistent unit of work, even in case of system failure (2)To provide isolation between programs that access the database concurrently
ACID property:(1)Atomicity:Either all operations complete successfully or the transaction fails and the db is unchanged.(2)Consistency:The db state must be valid after the transaction. All constraints must be statisfied. (3)Isolation:Concurrent transaction must not affect each other.(4)Durability: Data written by a successful transaction must be recorded in persistent storage.

we start a transaction with the BEGIN statement, then we write a series of normal SQL queries, if all the transaction is successful, we COMMIT the transaction to make it permanent, ROLLBACK the transaction otherwise.

DB transaction and handle deadlock in Golang: Test-Driven Development(TDD)
We write tests first to make our current code breaks, then we gradually improve the code until the tests pass.

we detect deadlock, and we print out some logs to see which transaction is calling which query and in which order. fixed the deadlock issue caused by the foreign key constraints.

The best defense against deadlocks is to avoid them by making sure that our application always acquire locks in a consistent order.
