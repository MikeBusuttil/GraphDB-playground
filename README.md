# Northwind on RDBMS (MariaDB) vs Graph Database (Neo4j)

This project was created to compare working with the same data using 2 different storage paradigms: graph database versus relational database.

## Getting started

- Browse the graph-migrated Northwind dataset by visiting http://northwind.techiteasy.ca:7474 with username `neo4j` and password `pass`
- Query the Northwind dataset in its original form with a MySQL client (ie. [MySQL Workbench](https://www.mysql.com/products/workbench/)) by connecting to the following:
  - Hostname: `northwind.techiteasy.ca`
  - port: `3310`
  - Username: `mariadb`
  - Password: `pass`

## DIY

To self-host the databases, refer to the following:

### pre-requisites

The following assumes you have `docker` engine & `docker-compose` installed.  Also, the MySQL root password is taken from your systems environment variable `NORTHWIND_MYSQL` which should be set to `pass` in order for step #2 below to work.

### building the environment

1. start the database engines by checking out this repo and running `docker-compose -f ./environment/dbz.yml up -d` from the repo's root.
    - note: when running `docker-compose` as root you may lose permission to the data directory.  To fix this run `sudo chmod -R 777 ./environment/data`
2. populate the relational database with the following: `docker exec -i nice_rdbms mysql -u root --password=pass < ./data/northwind.sql`
3. populate the graph database with the following: `docker exec -i nice_graph /var/lib/neo4j/bin/cypher-shell -u neo4j -p pass < ./environment/data/import_csv.cypher`

## 2do

- expand on the exercises & answers sections to get a better sense of how working with the 2 paradigms differs.
- find and import the data for region, territory, employee territory, customer demographics, and state.
- format the numbers nicely (ie. $3,002.67) in neo4j queries - this might involve the installation of apoc.
