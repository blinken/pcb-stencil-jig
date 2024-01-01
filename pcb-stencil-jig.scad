/*
    A short OpenSCAD script to generate a simple jig to hold a two-sided 
    PCB while solder paste is applied with a stencil.
    
    Customise the variables below and print two jigs, to hold opposite
    corners of the board. Align against the PCB and tape to the bench. 
    Tape the stencil to the platform, apply the solder paste, and repeat 
    as required.
    
    The jig raises the PCB off the bench enough to allow components on 
    the underside of the board to sit clear.
    
    Copyright 2023 Patrick Coleman (https://github.com/blinken)
    Licensed under Creative Commons BY-SA 4.0. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/
*/


// set to ~2mm less than the long edge of the PCB panel
y_length=110; // mm

// set to ~2mm less than the short edge of the PCB panel
x_length=70; // mm

// the width of the platform for the stencil - set wide enough that you'll have space to tape
// the stencil
platform=50; // mm

// total height, set slightly more than the tallest component on the 
// bottom of the board
height=16; // mm

// width & thickness of the skirt for taping to the bench
skirt_width=20; // mm
skirt_thickness=1; // mm

// thickness of the PCB (sets the depth of the cutout ledge)
pcb_thickness=1.6; // mm

// width of the ledge - set equal to your PCB rail width, if you have them, or
// otherwise a width around the edges of the board clear of components.
pcb_ledge_width=4; // mm 

// radius for the rounded corners
corner_radius=5; // mm

fudge=1;
union() {
    difference() {
        translate([corner_radius, corner_radius, 0]) {
            linear_extrude(height) {
                minkowski($fn=100) {
                    square([skirt_width+x_length-2*corner_radius,y_length+skirt_width-2*corner_radius]);
                    circle(5);
                }
            }
        }

        translate([-fudge, -fudge, skirt_thickness]) {
            cube([skirt_width+fudge, y_length+skirt_width+2*fudge, height+fudge]);
        }
        translate([-fudge, y_length, skirt_thickness]) {
            cube([skirt_width+x_length+2*fudge, skirt_width+fudge, height+fudge]);
        }
        
        translate([skirt_width-corner_radius, y_length-corner_radius, skirt_thickness]) {
            rotate([0, 0, 0]) {
                cube([corner_radius*2, corner_radius*2, height-skirt_thickness+fudge]);
            }
        }
        
        translate([skirt_width+platform, -fudge, -fudge]) {
            cube([x_length-platform+fudge, y_length-platform+fudge, height+2*fudge]);
        }
        
        translate([skirt_width+platform-pcb_ledge_width, -fudge, height-pcb_thickness]) {
            cube([x_length-platform+pcb_ledge_width+fudge, y_length-platform+pcb_ledge_width+fudge, pcb_thickness+fudge]);
        }
    }

    translate([skirt_width+corner_radius, y_length-corner_radius, skirt_thickness]) {
        cylinder(height-skirt_thickness, corner_radius, corner_radius, $fn=100);
    }
}
