thickness = 3;

box_screw_column_radious = 3;
arduino_screw_column_radious = 3;
arduino_screw_column_z = 6;

//sizes
size_inner_x = 111 + 2*box_screw_column_radious;
size_inner_y = 111 + 2*box_screw_column_radious- thickness;
size_z = 38;
size_x = size_inner_x + thickness;
size_y = size_inner_y + thickness;


boundary_size_x = 60;
relay_size_x = 70;

box_y = 0;
arduino_box_x = 0;
relay_box_x = 140;

$fn = 40; 

//translations
dx_usb_port  = 15 + box_screw_column_radious;
dx_jack_port = 53 + box_screw_column_radious;
dx_ethernet  = 70 + box_screw_column_radious;


module usb_port() {
  translate([dx_usb_port , 0, arduino_screw_column_z])
    cube([13, thickness, 13], false);
}
	
module jack_port(){
  translate([dx_jack_port, thickness, 6.5 + arduino_screw_column_z])
    rotate([90,00,0])
      cylinder(h = thickness + 1, r1 = 6.5, r2 = 6.5, center = false); 
}

module ethernet_port() {
  translate([dx_ethernet, 0, arduino_screw_column_z])
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
  difference() {
    cylinder(h = size_z , r1 = box_screw_column_radious, r2 =    box_screw_column_radious, center = false);
    translate([0, 0, 0.01+2*size_z/3])
        cylinder(h = size_z / 3, r1 = box_screw_column_radious /3, r2 =    box_screw_column_radious / 3, center = false);      
  }
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
  difference() {  
    cylinder(h = arduino_screw_column_z, r1 =   arduino_screw_column_radious, r2 = arduino_screw_column_radious , center = false);
    translate([0, 0, 0.01+arduino_screw_column_z/2])
        cylinder(h = arduino_screw_column_z / 2, r1 =   arduino_screw_column_radious/3, r2 = arduino_screw_column_radious/3 , center = false);      
  }
}

module arduino_screw_columns() {
  pos_x_first_screw = 0.9 + 2*box_screw_column_radious + thickness;
  pos_y_first_screw = thickness + 14.4;
  translate([pos_x_first_screw, pos_y_first_screw, 0])
    arduino_screw_column();
  translate([pos_x_first_screw + 45.5, pos_y_first_screw, 0])
    arduino_screw_column();
  translate([pos_x_first_screw, pos_y_first_screw + 79.1, 0])
    arduino_screw_column();
translate([pos_x_first_screw + 45.5, pos_y_first_screw + 79.1, 0])
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

module arduino_cover() {
    translate([0, 0, 100]) {
        difference() {
            cube([size_x, size_y, size_z/2], false);
            translate([thickness/2, thickness/2, thickness/2-10])
                cube([size_inner_x, size_inner_y, size_z/2], false);
        }
    }
}

arduino_box();
relay_box();
//arduino_cover();
