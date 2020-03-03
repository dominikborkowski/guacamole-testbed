# Testing glyph problems with guacamole

The following set of containers provides a test environment for testing guacamole.

## setup

```
docker-compose up
```

* Login as 'guacadmin'/'guacadmin' at http://localhost:8080
* Configure several new connections:

All of them will need the following config options set:

* Protocol: RDP
* Ignore server certificate: yes
* Port: 3389

* ubuntu-14.04
    * hostname: ubuntu-14.04
* ubuntu-16.04
    * hostname: ubuntu-16.04
* ubuntu-18.04
    * hostname: ubuntu-18.04


### manual tests

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


## new connections

Once logged into guacamole interface at
