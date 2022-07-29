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
