thickness = 3;

size_inner_x = 111;
size_inner_y = 111 - thickness;
size_z = 38;
size_x = size_inner_x + thickness;
size_y = size_inner_y + thickness;

box_screw_column_radious = 3;

arduino_screw_column_radious = 6;
arduino_screw_column_z = 6;

boundary_size_x = 60;
relay_size_x = 70;

box_y = 0;
arduino_box_x = 0;
relay_box_x = 140;

$fn = 40; 


module usb_port() {
  translate([15, 0, arduino_screw_column_z])
    cube([13, thickness, 13], false);
}
	
module jack_port(){
  translate([53, thickness, 6.5 + arduino_screw_column_z])
    rotate([90,00,0])
      cylinder(h = thickness + 1, r1 = 6.5, r2 = 6.5, center = false); 
}

module ethernet_port() {
  translate([70, 0, arduino_screw_column_z])
    cube([19, thickness, 16], false);
}

module boundary_port(origin_x) {
  translate([origin_x, (size_y - boundary_size_x) / 2, 5])
    rotate([0, 0, 90])
      cube([boundary_size_x, thickness + 10, 16], false);
}

module relay_port() {
  translate([(size_y - boundary_size_x) / 2, 0, arduino_screw_column_z])
    cube([relay_size_x, thickness, 16], false);
}

module box_screw_column() {
  cylinder(h = size_z, r1 = box_screw_column_radious, r2 = box_screw_column_radious, center = false);
}

module box_screw_columns() {
  translate([thickness, thickness, 0])
    box_screw_column();
  translate([size_x - thickness, thickness, 0])
    box_screw_column();
  translate([size_x - thickness, size_y - thickness, 0])
    box_screw_column();
  translate([thickness, size_y - thickness, 0])
    box_screw_column();
}

module arduino_screw_column() {
  cylinder(h = arduino_screw_column_z, r1 = arduino_screw_column_radious, r2 = arduino_screw_column_radious, center = false);
}

module arduino_screw_columns() {
  translate([10, 20, 0])
    arduino_screw_column();
  translate([20, 40, 0])
    arduino_screw_column();
  translate([50, 60, 0])
    arduino_screw_column();
}

module arduino_box() {
  difference() {
    cube([size_x, size_y, size_z], false);
    translate([thickness/2, thickness/2, thickness/2])
      cube([size_inner_x, size_inner_y, size_z], false);    
	  usb_port();
	  jack_port();
    ethernet_port();
    boundary_port(arduino_box_x + size_x);
  }
  box_screw_columns();
  arduino_screw_columns();
  
}

module relay_box() {
  translate([relay_box_x, box_y, 0]) {
    difference() {
      cube([size_x, size_y, size_z], false);
      translate([thickness/2, thickness/2, thickness/2])
        cube([size_inner_x, size_inner_y, size_z], false);    
      boundary_port(thickness);
      relay_port();
    }
    box_screw_columns()
    arduino_screw_columns();
  }
}

arduino_box();
relay_box();

