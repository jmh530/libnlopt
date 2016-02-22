#libnlopt
**Bindings to [nlopt](http://ab-initio.mit.edu/wiki/index.php/NLopt) for the D 
programming language**

---

## Supported platforms

### Windows
Tested with DMD 32bit/64bit and LDC 64bit. 

### Linux
Tested with DMD 32bit/64bit.

### Mac OSX
Not tested.

---

## Installation

nlopt source is available here:

http://ab-initio.mit.edu/wiki/index.php/NLopt

### Windows
I have included nlopt dll/lib files that will work with DMD and 64bit LDC. 
These are built using MSVC 2013 Community and there might be issues if using
other versions.

Add the directory of the relevant dll/lib for the appropriate architecture to
the system path. An alternative would be to register the dll.

This library should then just work. 

### Linux
Follow the insallation instructions from the nlopt website to install nlopt.

This library should then just work. 

### Mac OSX
Not tested.