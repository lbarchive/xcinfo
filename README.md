xcinfo
======

*xcinfo* provides information of X cursor including, also the output:

    x y sw sh cw ch cx cy

where:

 * `x`, `y` : cursor position
 * `sw`, `sh`: screen resolution
 * `cw`, `ch`: cursor image size
 * `cx`, `cy`: cursor hotspot position

Compilation
-----------

    $ make

Installation
------------

    # By default, to install to `/usr/local`, run:
    $ make install

    # Or to `/usr`:
    $ make install PREFIX=/usr

    # Or to your home:
    $ make install PREFIX=$HOME

To uninstall, use `uninstall` target with `PREFIX` if supplied during installation.

Usage
-----

This code is written intentedly being used in shell script, e.g.

    :::bash
    read x y sw sh cw ch cx cy <<< "$(xcinfo)"

You can discard unneeded outputs, e.g.

    :::bash
    read x y sw sh _ <<< "$(xcinfo)"

Examples
--------

### bzen2.sh

A dzen2 which bounches, simply run:

    bzen2.sh message here, blah blah blah...

You can watch a screenshot in this [blog post][bzen2-post].

[bzen2-post]: http://blog.yjl.im/2011/09/bzen2-dzen2-which-bounces.html

### mouse trail

Scripts to record and render mouse trail as a SVG file, for example:

    $ mousetrack-record.sh mouse.pos
    Press Q to stop recording
    $ mousetrack-svg.sh mouse.pos mouse.svg

    # Converting to PNG format
    $ inkscape mouse.svg --export-background=FFF --export-png=mouse.png

    # or simply
    $ inkscape mouse.svg -b FFF -e mouse.png

### snap.sh

A script snaps a screenshot when mouse has movements every 5 minutes. It requires xsnap program to grab a screenshot.

License
-------

This code is placed in Public Domain.
