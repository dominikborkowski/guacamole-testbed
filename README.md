# Guacamole test bed

The goal of this environment is to quickly stand up three versions of Guacamole along with three versions of Ubuntu, and provide means of testing RDP connectivity. It was created as a way to test a problem related to the change of FreeRDP 1.x to 2.x.

The idea is to perform a comparison between two tagged releases of guacamole versions, and the latest source, to identify any potential issues.

_Relevant bug report_: https://issues.apache.org/jira/browse/GUACAMOLE-962

## Setup

* Place relevant 'previous' and 'new' version numbers in `.env` file in the main directory. Eg:

```
# versions of guacamole:
PREVIOUS=1.0.0
NEW=1.1.0
```
If that file doesn't exist, `docker-compose.yml` will default to 1.0.0 and 1.1.0 respectively.

* Check out necessary submodules (guacamole-server & client)

```
git submodule update --init
```

* Stand up the stack. Running it in foreground will provide good way to see all the logs collated in one stream.

```
docker-compose up
```

## Testing

* Navigate to one of the three versions of guacamole:
    * **previous**: http://localhost:8080/guacamole/#/
    * **new**: http://localhost:8081/guacamole/#/
    * **latest git**: http://localhost:8082/guacamole/#/
* Login as **guacadmin** with password **guacadmin**
* You will have three versions of ubuntu as pre-configured connections. If things work correctly, you will be prompted with a login window
* Try logging in as user **ubuntu** with password **ubuntu**, with the default xrdp module:
    * Ubuntu 14.04: **sesman-Xvnc** (_actual session is not working at the moment_)
    * Ubuntu 16.04: **sesman-Xvnc**
    * Ubuntu 18.04: **Xorg**

Problems with RDP will be apparent right away, and guacamole will not be able to connect to some systems. For example Guacamole 1.1.0 won't be able to connect to Ubuntu 14.04 and 16.04.


## What's included

We have a total of **three** test containers, and **nine** service ones:

* previous guacamole
    * guacamole-previous - http://localhost:8080/guacamole/#/
    * guacd-previous
    * postgres-previous
* new guacamole - http://localhost:8081/guacamole/#/
    * guacamole-new
    * guacd-new
    * postgres-new
* git guacamole (latest git) - http://localhost:8082/guacamole/#/
    * guacamole-git
    * guacd-git
    * postgres-git
* three test clients with the following RDP integrations:
    * ubuntu-14.04, linuxvnc
    * ubuntu-16.04, vnc4server
    * ubuntu-18.04, xorgrdp

### Default settings

* Postgres
    * each instance is preloaded with default guacamole SQL schema
    * in addition, we add three connections for the Ubuntu containers, each configured as **RDP**, with certificate checks **disabled**
* Ubuntu
    * We install xrdp, enable debugging, and start it on startup
    * to keep things small, in an already large setup, **xterm** is used as the default desktop manager


## Manual tests

If you have `xfreerdp` client installed on your host machine, you can directly connect to xrdp service on one of the Ubuntu containers with the following syntax:

```
xfreerdp /v:localhost:PORT_NUMBER /relax-order-checks +glyph-cache
```

Where **PORT_NUMBER** is:

* ubuntu-14.04: `14389`
* ubuntu-16.04: `16389`
* ubuntu-18.04: `18389`

## Database manipulation

* connect to postgres
```
psql -U guac_db_user guac_db
```
* dumping entire database:
```
pg_dumpall -U guac_db_user > original_db.sql
```
