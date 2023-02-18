# Northwind on RDBMS (MariaDB) vs Graph Database (Neo4j)

This project was created to compare working with the same data using 2 different storage paradigms: graph database versus relational database.

## Getting started

- Browse the graph-migrated Northwind dataset by visiting http://northwind.techiteasy.ca:7474 with username `neo4j` and password `password`
- Query the Northwind dataset in its original form with a MySQL client (ie. [MySQL Workbench](https://www.mysql.com/products/workbench/)) by connecting to the following:
  - Hostname: `northwind.techiteasy.ca`
  - port: `3310`
  - Username: `mariadb`
  - Password: `password`

## DIY

To self-host the databases, refer to the following:

### pre-requisites

The following assumes you have `docker` engine & `docker-compose` installed.  Also, the MySQL root password is taken from your system's environment variable "`NORTHWIND_MYSQL`" which should be set in order for steps #1 & #2 below to work.

### building the environment

1. start the database engines by checking out this repo and running the following from the repo's root:
```
docker-compose -f ./environment/dbz.yml up -d
```
  - note: when running `docker-compose` as root you may lose permission to the data directory.  To fix this run:
```
sudo chmod -R 777 ./environment/data
```
2. populate the relational database with the following:
```
docker exec -i nice_rdbms mysql -u root --password=$NORTHWIND_MYSQL < ./environment/data/northwind.sql
```
3. populate the graph database with the following:
```
docker exec -i nice_graph /var/lib/neo4j/bin/cypher-shell -u neo4j -p password < ./environment/data/import_csv.cypher
```

### tearing down the environment

```
docker-compose -f ./environment/dbz.yml down
sudo rm -rf ./environment/sql
sudo rm -rf ./environment/cql
```

## 2do

- expand on the exercises & answers sections to get a better sense of how working with the 2 paradigms differs:
  - devise a query that spans all tables
- find and import the data for customer demographics.
- import the data for region, territory, employee territory, customer demographics, and state into Neo4j.
- format the numbers nicely (ie. $3,002.67) in neo4j queries - this might involve the installation of apoc.
- generate a very large data set to see how the performance of each paradigm scales.
- implement CI infrastructure that checks SQL answers against CQL answers and flags mis-matches in PR's.

## References

- Many of the exercises were adapted from [SQL Practice Problems: 57 beginning, intermediate, and advanced challenges for you to solve using a “learn-by-doing” approach](https://www.amazon.ca/SQL-Practice-Problems-learn-doing-ebook/dp/B01N41VQFO) by Sylvia Moestl Vasilik
