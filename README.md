# GraphDB playground
 playground for Graph Database

## pre-requisites

- docker engine & docker compose

## build the environment

- `docker-compose -f ./environment/dbz.yml up -d`
- `docker exec -i nice_rdbms mysql -u root --password=pass < ./data/northwind.sql`
- `docker exec -i nice_graph /var/lib/neo4j/bin/cypher-shell -u neo4j -p pass < ./environment/data/import_csv.cypher`

## 2do

- find and import the data for region, territory, employee territory, and state.
