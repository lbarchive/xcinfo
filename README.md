xcinfo
======

*xcinfo* provides information of X cursor including, also the output:

    x y sw sh cw ch cx cy

where:

 * `x`, `y` : cursor position
 * `sw`, `sh`: screen resolution
 * `cw`, `ch`: cursor image size
 * `cx`, `cy`: cursor hotspot position

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

License
-------

This code is placed in Public Domain.
