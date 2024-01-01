## Solder-paste-stencil jig for two-sided PCBs

<img src="./doc/render.png" width=700/>

A short OpenSCAD script to generate a simple 3D-printed jig to hold a two-sided
PCB while solder paste is applied with a stencil.

The jig raises the PCB off the bench enough to allow components on the
underside of the board to sit clear.

### How to use

1. Customise the variables in the OpenSCAD file, generate an STL, and print two
   copies, to hold opposite corners of the board.
1. Align against the PCB and tape to the bench.
1. Tape the stencil to the jig platform, apply the solder paste, and repeat as
   required.

Pre-generated STL files are available in the `stl` folder, if you don't have
OpenSCAD available.
