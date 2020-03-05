# RDP problem

Below is the fatal error that affected communication with our older systems:

```
OpaqueRect - SERVER BUG: The support for this feature was not announced! Use /relax-order-checks to ignore
```

This error indicates that 'OpaqueRect' order was **not** part of the initial negotiation between the guacd rdp client and the xrdp server, but nonetheless was sent by the server. FreeRDP changed the default behavior of the client, and it no longer accepts such orders.



'RDP support for Guacamole is provided by the libguac-client-rdp library, which will be installed as part of guacamole-server if the required dependencies are present during the build.'

https://guacamole.apache.org/doc//gug/configuring-guacamole.html

## possible culprit

https://raw.githubusercontent.com/FreeRDP/FreeRDP/master/ChangeLog

```
* improve order handling - only orders that were enabled
  during capability exchange are accepted (#4926).
	WARNING and NOTE: some servers do improperly send orders that weren't negotiated,
	for such cases the new command line option /relax-order-checks was added to
	disable the strict order checking. If connecting to xrdp the options
	/relax-order-checks *and* +glyph-cache are required.
```
MR responsible for this mess:

* https://github.com/FreeRDP/FreeRDP/pull/4926

Commit related to adding option for bypassing order checks:

* https://github.com/FreeRDP/FreeRDP/pull/4926/commits/7b860ce96abf313b64e5b59f10534557456a2560

And relevant tidbit from gucacamole's code, in `guacamole-server/src/protocols/rdp`

```
#ifdef HAVE_RDPSETTINGS_ALLOWUNANOUNCEDORDERSFROMSERVER
    /* Do not consider server use of unannounced orders to be a fatal error */
    rdp_settings->AllowUnanouncedOrdersFromServer = TRUE;
#endif
```

Which would imply we need to pass `HAVE_RDPSETTINGS_ALLOWUNANOUNCEDORDERSFROMSERVER` to the pre-processor.


Additional info:

https://issues.apache.org/jira/browse/GUACAMOLE-962


## glyph support

Here are the commits related to disabling/enabling glyph support:

https://www.mail-archive.com/commits@guacamole.apache.org/msg01524.html


## libguac-client-rdp

This is how guacamole-server includes libguac-client-rdp:
```
protocols/rdp/Makefile.am
29:lib_LTLIBRARIES = libguac-client-rdp.la
```

libguac-client-rdp.la is a text file for libtools, used to indicate which files make up the library




## guac containers

* https://github.com/apache/guacamole-client/tree/master/guacamole-docker
* https://github.com/apache/guacamole-server/blob/master/Dockerfile


## Debian packages

guac 1.0 uses debian stretch (9), with `libfreerdp-dev`, while guac 1.1 uses debian buster (10) with `freerdp2-dev`

* https://packages.debian.org/stretch/libfreerdp-dev
* https://packages.debian.org/buster/freerdp2-dev

### Relevant changes

Changelog in freerdp:

```
2318-2018-10-15 15:27:17 +0200 Armin Novak (e5d60370b)
2319-
2320:	* Fixed MultiOpaqueRect
--
2322-2018-10-15 15:23:04 +0200 Armin Novak (479233ced)
2323-
2324:	* Fix bounding rectangle of OpaqueRect
```

libguac-client-rdp

```
freerdp2-2.0.0~git20190204.1.2693389a/client/common/cmdline.h
    { "relax-order-checks", COMMAND_LINE_VALUE_FLAG, NULL, NULL, NULL, -1, "relax-order-checks", "Do not check if a RDP order was announced during capability exchange, only use when connecting to a buggy server" }
```



2018-10-15 15:27:17 +0200 Armin Novak (e5d60370b)
        * Fixed MultiOpaqueRect
2018-07-31 11:29:59 +0200 Armin Novak (619ce84cd)
        * release: version 2.0.0-rc3


## changes between release


* glyph stuff

https://github.com/FreeRDP/FreeRDP/commit/10cc3199734ebbade2a99adba96532b35f170eec

* 'Adjust rectangles where appropriate.'

https://github.com/FreeRDP/FreeRDP/commit/14321a2d52a646c29fb09cd94b101fa52f61f9af

## testing


Docker + ubuntu 14.04 ansible

```
apt update
apt install xrdp
xrdp-keygen xrdp /etc/xrdp/rsakeys.ini
xrdp -nodaemon
```

on client
```
brew install freerdp
```

```
xfreerdp /v:localhost:3389 /relax-order-checks +glyph-cache
```
