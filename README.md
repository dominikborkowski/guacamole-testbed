# Test bed for guacamole

The following set of containers provides a test environment for testing guacamole.

## setup

* Pull latest `guacamole-server` repo and stand up the entire stack

```
git submodule update --init
docker-compose up
```

* Navigate to  http://localhost:8080
* Login as **guacadmin** with password **guacadmin**

## What's included

We have a total of **five** containers:

* guacamole client
* guacamole server/proxy
* postgres
* three test clients
    * ubuntu-14.04
    * ubuntu-16.04
    * ubuntu-18.04

## Manual tests

From your host machine:

```
xfreerdp /v:localhost:PORT_NUMBER /relax-order-checks +glyph-cache
```

Where PORT_NUMBER is:

* ubuntu-14.04
    * 14389
* ubuntu-16.04
    * 16389
* ubuntu-18.04
    * 18389

## Database manipulation

Once logged into guacamole interface at
* stand up entire stack with docker-compose
```
docker compose up
```
* enter existing container
```
docker exec -it <container> sh
```
* connect to postgres
```
psql -U guac_db_user guac_db
```
* dumping entire database:
```
pg_dumpall -U guac_db_user > original_db.sql
```
