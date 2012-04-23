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

Please read the README in examples directory.

License
-------

This code is placed in Public Domain.
