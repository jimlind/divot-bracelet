bracelet(
    length = 18,
    radius = 22,
    space = 35,
    resolution = 24
);

/**
 * Experimental Flat Bottom Bracelet.
 *
intersection() {
    bracelet(
        length = 18,
        radius = 22,
        space = 35,
        resolution = 24
    );
    
    translate([-50,-50,-4.5])
    cube([100,100,10]);
}
**/


module bracelet(length, radius, space, resolution) {
    push = (length-space)/2;
    angle = asin(push/radius);
    
    difference() {        
        oval(length, radius, resolution);
        
        rotate([0,0,angle])
        translate([0,0,-6])
            cube([radius+3,length/2,12]);
        
        translate([0,length,0])
        rotate([0,0,-angle])
        translate([0,length/-2,-6])
            cube([radius+3,length/2,12]);
        
        translate([radius-6,-3,-6])
            cube([12,length+6,12]);
    }
    
    outward = sqrt(pow(radius,2) - pow(push,2));
    
    
    translate([outward,push,0])
    rotate([0,0,angle-6])
        cap(resolution);

    translate([outward,length-push,0])
    rotate([0,0,-angle+6])
        cap(resolution);

}

module cap(resolution) {
    difference() {
        scale([1,1,2])
            sphere(r=2.5, $fn=resolution*2);
        
        translate([2,5,0])
        rotate([90,0,0])
            cylinder(h=10,r=2.25,$fn=resolution*2);
    }
}

module oval(length, radius, resolution) {    
    half(radius, resolution);
    translate([0,length,0])
    rotate([0,0,180])
        half(radius, resolution);
    
    translate([radius,length,0])
    rotate([90,0,0])
    piece(length, resolution);
    
    translate([-1 * radius,length,0])
    rotate([90,180,0])
    piece(length, resolution);
}

module pattern(resolution) {
    difference() {
        scale([1,2,1])
            circle(r=2.5, $fn=resolution*2);
        translate([2,0,0])
            circle(r=2.25, $fn=resolution*2);
    }
}

module piece(length, resolution) {
    translate([0,0,-0.1])
    linear_extrude(height=length + 0.2, $fn=resolution)
        pattern(resolution);
}

module full(radius, resolution) {
    rotate_extrude($fn=resolution * 4)
        translate([radius,0,0])
        pattern(resolution);
}

module half(radius, resolution) {
    difference() {
        full(radius, resolution);
        translate([0,20,0])
            cube([60,40,10], true);
    }
}