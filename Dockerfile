FROM guacamole/guacamole:1.0.0 as guac_client

LABEL maintainer="Dominik L. Borkowski"

# generate initial schema from our guacamole client
RUN /opt/guacamole/bin/initdb.sh --postgres >> /tmp/guacamole-initdb.sql

# prepare a new postgres container
FROM postgres:12-alpine
COPY --from=guac_client ./tmp/guacamole-initdb.sql /docker-entrypoint-initdb.d/guacamole-initdb.sql
