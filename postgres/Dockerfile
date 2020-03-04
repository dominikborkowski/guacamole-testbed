ARG GUAC_VERSION
FROM guacamole/guacamole:${GUAC_VERSION:-1.0.0} as guac_client

# generate initial schema from our guacamole client
RUN /opt/guacamole/bin/initdb.sh --postgres >> /tmp/guacamole-initdb.sql

# prepare a new postgres container
FROM postgres:12-alpine
COPY --from=guac_client ./tmp/guacamole-initdb.sql /docker-entrypoint-initdb.d/10-guacamole-initdb.sql
COPY ./test-connections.sql /docker-entrypoint-initdb.d/20-test-connections.sql
