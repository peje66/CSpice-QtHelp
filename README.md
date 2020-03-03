# CSpice-QtHelp
Makefile to create QtHelp document from cspice documentation from naif.jpl.nasa.gov

## Prerequisites
You will need:
* cspice installation [Toolkit](http://naif.jpl.nasa.gov/naif/toolkit.html) (spice, mice or icy should theoretically work, untested)
* qhelpgenerator
* assistant (for test)
* awk
* sed


## Procedure
Install CSpice from http://naif.jpl.nasa.gov/naif/toolkit.html.
Then:
```Shell
    cd ~
    git clone https://github.com/peje66/CSpice-QtHelp.git
    cd <cspice-dir>/doc/html
    make -f ~/CSpice-QtHelp/Makefile
```
Optionally:
```Shell
    make -f ~/CSpice-QtHelp/Makefile test
```
Now you have a `cspice.qch` ready for use in `assistant` or `kdevelop`

