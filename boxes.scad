box_thickness = 3.0;

box_screw_column_radious = 3.0;
arduino_screw_column_radious = 4.0;
arduino_thickness = 1.58; // pcb thickness in mm
arduino_screw_column_z = 3.0; //this would be the new "floor"
arduino_comp_baseline_z = box_thickness + arduino_screw_column_z + arduino_thickness; //components baseline
arduino_comp_baseline_x = box_thickness + 2*box_screw_column_radious;

real_screw_radio = 3.0 / 2.0; //given that the cylinder is drawn from its center and the measures were made from the perimeter of the real hole, we need this adjustment factor

//sizes
size_inner_x = 116.0 + 2.0*box_screw_column_radious;
size_inner_y = 118.0 + 2.0*box_screw_column_radious;
size_z = 38.0;
size_x = size_inner_x + box_thickness;
size_y = size_inner_y + box_thickness;
arduino_width = 57.0;
arduino_length = 111.7;

boundary_size_x = 60.0;
relay_size_x = 70.0;

box_y = 0.0;
arduino_box_x = 0.0;
relay_box_x = 140.0;

size_x_usd = 49.0;

$fn = 80.0;

//components
dx_usb_port  = 9.5 + arduino_comp_baseline_x;
x_size_usb_port = 14.5;
z_size_usb_port = 13.2;

dx_jack_port = dx_usb_port + x_size_usb_port + 16.2;
x_size_jack_port = 11.6;
z_size_jack_port = 12.8;

dx_ethernet  = arduino_comp_baseline_x + arduino_width + 7.0;



module usd_module(){
    usd_screw_columns();
}


module usb_port() {
  translate([dx_usb_port , 0.0, arduino_comp_baseline_z])
    cube([x_size_usb_port, box_thickness, z_size_usb_port], false);
}
	
module jack_port(){
    translate([dx_jack_port, 0.0, arduino_comp_baseline_z])
    cube([x_size_jack_port, box_thickness, z_size_jack_port], false);  
  //translate([dx_jack_port, box_thickness, 6.5 + arduino_screw_column_z])
    
    //rotate([90,00,0])      
      //cylinder(h = box_thickness + 1, r1 = 6, r2 = 6, center = false); 
}

module ethernet_screw_columns() {
  dx1 = arduino_comp_baseline_x + arduino_width + 0.7 + real_screw_radio;
  dy1 = 1.0 + real_screw_radio + box_thickness;
  dx2 = dx1 + 27.5;
  dy2 = dy1 + 48.2;
  translate([dx1, dy1, box_thickness])
    arduino_screw_column();    
  translate([dx2, dy1, box_thickness])
    arduino_screw_column();        
  translate([dx1, dy2, box_thickness])
    arduino_screw_column();        
  translate([dx2, dy2, box_thickness])
    arduino_screw_column();        
}

module ethernet_port() {    
  translate([dx_ethernet, 0.0, arduino_comp_baseline_z])
    cube([16.8, box_thickness, 14.3], false);
}

module boundary_port(origin_x) {
  translate([origin_x, (size_y - boundary_size_x) / 2.0, 5.0])
    rotate([0.0, 0.0, 90.0])
      cube([boundary_size_x, box_thickness + 10.0, 16.0], false);
}

module relay_port() {
  translate([(size_y - boundary_size_x) / 2.0, 0.0, arduino_screw_column_z])
    cube([relay_size_x, box_thickness, 16.0], false);
}

module box_screw_column() {
  difference() {
    cylinder(h = size_z , r1 = box_screw_column_radious, r2 =    box_screw_column_radious, center = false);
    translate([0.0, 0.0, 0.01+2.0*size_z/3.0])
        cylinder(h = size_z / 3.0, r1 = box_screw_column_radious /3.0, r2 =    box_screw_column_radious / 3.0, center = false);      
  }
}

module box_screw_columns() {
  translate([box_thickness, box_thickness, 0.0])
    box_screw_column();
  translate([size_x - box_thickness, box_thickness, 0.0])
    box_screw_column();
  translate([size_x - box_thickness, size_y - box_thickness, 0.0])
    box_screw_column();
  translate([box_thickness, size_y - box_thickness, 0.0])
    box_screw_column();
}

module arduino_screw_column() {
  difference() {  
    cylinder(h = arduino_screw_column_z , r1 =   arduino_screw_column_radious, r2 = arduino_screw_column_radious, center = false);
      
    // screw hole  
    /* for testing in 2D projection
      #translate([0.0, 0.0, -3*arduino_screw_column_z/2.0]) 
        cylinder(h = 4*arduino_screw_column_z / 2.0 + box_thickness, r1 =   arduino_screw_column_radious/3.0, r2 = arduino_screw_column_radious/3.0 , center = false);      
      */
    #translate([0.0, 0.0, arduino_screw_column_z/2.0]) 
        cylinder(h = arduino_screw_column_z /2 , r1 =   arduino_screw_column_radious/3.0, r2 = arduino_screw_column_radious/3.0 , center = false);            
  }
}

module usd_screw_columns() {
    dx1 = arduino_comp_baseline_x + arduino_width + 1.7 + real_screw_radio;
    dx2 = dx1 + 35.5;
    dy1 = arduino_comp_baseline_x + 55.6 + real_screw_radio;  
    dy2 = dx1 + 37.0;
    
    translate([dx1 , dy1 , box_thickness])
        arduino_screw_column();
    translate([dx2 , dy1 , box_thickness])
        arduino_screw_column();   
    translate([dx1 , dy2 , box_thickness])
        arduino_screw_column();    
    translate([dx2 + 0.5, dy2 , box_thickness])
        arduino_screw_column();
    
}

module arduino_screw_columns() { 
  pos_x_first_screw = arduino_comp_baseline_x + 1.5 + real_screw_radio;
  pos_y_first_screw = box_thickness + 14.6;
    
  pos_x1_inner_screw = arduino_comp_baseline_x + 16.5 + real_screw_radio;
  pos_x2_inner_screw = pos_x1_inner_screw + 28.3;
  pos_y_inner_screw = arduino_comp_baseline_x + 58.0 + real_screw_radio;  
    
  screws_x_distance = 47.7;  
  screws_y1_distance = 75.0;
  screws_y2_distance = 80.5;
  
    
  translate([pos_x_first_screw, pos_y_first_screw, box_thickness])
    arduino_screw_column();
  translate([pos_x_first_screw + screws_x_distance, pos_y_first_screw- 1.0, box_thickness])
    arduino_screw_column();
  translate([pos_x_first_screw + 1.0, pos_y_first_screw + screws_y1_distance, box_thickness])
    arduino_screw_column();
translate([pos_x_first_screw + screws_x_distance + 1.0, pos_y_first_screw + screws_y2_distance, box_thickness])
    arduino_screw_column();    
translate([pos_x1_inner_screw, pos_y_inner_screw, box_thickness])
    arduino_screw_column();    
translate([pos_x2_inner_screw+0.35, pos_y_inner_screw, box_thickness])
    arduino_screw_column();
    
    //ethernet_screws
    ethernet_screw_columns();
}


module arduino_box() {
  difference() {
      difference() {
        cube([size_x, size_y, size_z], false);
        translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0])
          cube([size_inner_x, size_inner_y, size_z], false);    
          usb_port();
          jack_port();
        ethernet_port();
        boundary_port(arduino_box_x + size_x);
      }
    
    // "breathing"s holes  
    translate([18,4,0])
        cube([35,22,2*box_thickness], false);      
    translate([15,23,0])
        cube([47,39,2*box_thickness], false);
    translate([18,80,0])
        cube([35,40,2*box_thickness], false);
    translate([68,12,0])
        cube([50,35,2*box_thickness], false);        
    translate([97.1,71,0])
        cube([24,30.5,2*box_thickness], false);              
    translate([75,60,0])
        cube([23,60,2*box_thickness], false);
    
      
  }
    
  
  box_screw_columns();
  arduino_screw_columns();
  usd_module();              
  
}

module relay_box() {
  translate([relay_box_x, box_y, 0.0]) {
    difference() {
      cube([size_x, size_y, size_z], false);
      translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0])
        cube([size_inner_x, size_inner_y, size_z], false);    
      boundary_port(box_thickness);
      relay_port();
    }
    box_screw_columns()
    arduino_screw_columns();
  }
}

module arduino_cover() {
    translate([0, 0, size_z+1]) {
        difference() {
            cube([size_x, size_y, size_z/2.0], false);
            translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0-10.0])
                cube([size_inner_x, size_inner_y, size_z/2.0], false);
        }
    }
}

//projection() {arduino_box();}
arduino_box();
//relay_box();
//arduino_cover();




 