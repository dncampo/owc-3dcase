DEBUG = 0;

box_thickness = 3.0;

box_screw_column_radious = 3.0;
arduino_screw_column_radious = 4.0;
arduino_thickness = 1.58; // pcb thickness in mm
arduino_screw_column_z = 5; //this would be the new "floor"
arduino_comp_baseline_z = arduino_screw_column_z + arduino_thickness; //components baseline
arduino_comp_baseline_x = box_thickness + 2*box_screw_column_radious;

real_screw_radio = 3.0 / 2.0; //given that the cylinder is drawn from its center and the measures were made from the perimeter of the real hole, we need this adjustment factor

//sizes
size_inner_x = 116.0 + 2.0*box_screw_column_radious;
size_inner_y = 118.0 + 2.0*box_screw_column_radious;
size_z = 40.0;
size_x = size_inner_x + box_thickness;
size_y = size_inner_y + box_thickness;
arduino_width = 57.0;
arduino_length = 111.7;

boundary_size_x = 20.0;
relay_size_x = 70.0;

box_y = 0.0;
arduino_box_x = 0.0;
relay_box_x = 0.0;

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


//display
x_size_disp = 71.0;
y_size_disp = 26.0;
dx_disp = size_x/2 - x_size_disp/2;
dy_disp = 11*y_size_disp / 4 ;

//buttons
x_size_buttons = 40.0;
y_size_buttons = 10.0;
dx_buttons = size_x/2 - x_size_buttons/2; 
dy_buttons = 20*y_size_buttons/4 - 5;

//relay
relay_size_x = 64.0;
relay_size_z = 8.5;
relay_pos_x  = size_x - relay_size_x - box_screw_column_radious - box_thickness;
relay_pos_z  = size_z - relay_size_z;


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
  translate([dx1, dy1, 0])
    arduino_screw_column();    
  translate([dx2, dy1, 0])
    arduino_screw_column();        
  translate([dx1, dy2, 0])
    arduino_screw_column();        
  translate([dx2, dy2, 0])
    arduino_screw_column();        
}

module ethernet_port() {    
  translate([dx_ethernet, 0.0, arduino_comp_baseline_z])
    cube([16.8, box_thickness, 14.3], false);
}



module relay_port() {

  translate([relay_pos_x, 0.0, relay_pos_z ])
    cube([relay_size_x, box_thickness, relay_size_z], false);
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
    // for testing in 2D projection
      if (DEBUG) {
        translate([0.0, 0.0, -3*arduino_screw_column_z/2.0]) 
            cylinder(h = 4*arduino_screw_column_z / 2.0 + box_thickness, r1 =   arduino_screw_column_radious/3.0, r2 = arduino_screw_column_radious/3.0 , center = false);      
      }
      else {
          translate([0.0, 0.0, arduino_screw_column_z/1.5]) 
            cylinder(h = arduino_screw_column_z /2 , r1 =   arduino_screw_column_radious/3.0, r2 = arduino_screw_column_radious/3.0 , center = false);            
      
      }
  }
}

module usd_screw_columns() {
    dx1 = arduino_comp_baseline_x + arduino_width + 1.7 + real_screw_radio;
    dx2 = dx1 + 35.5;
    dy1 = arduino_comp_baseline_x + 55.6 + real_screw_radio;  
    dy2 = dx1 + 37.0;
    
    translate([dx1 , dy1 , 0])
        arduino_screw_column();
    translate([dx2 , dy1 , 0])
        arduino_screw_column();   
    translate([dx1 , dy2 , 0])
        arduino_screw_column();    
    translate([dx2 + 0.5, dy2 , 0])
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
  
    
  translate([pos_x_first_screw, pos_y_first_screw, 0])
    arduino_screw_column();
  translate([pos_x_first_screw + screws_x_distance, pos_y_first_screw- 1.0, 0])
    arduino_screw_column();
  translate([pos_x_first_screw + 1.0, pos_y_first_screw + screws_y1_distance, 0])
    arduino_screw_column();
translate([pos_x_first_screw + screws_x_distance + 1.0, pos_y_first_screw + screws_y2_distance, 0])
    arduino_screw_column();    
translate([pos_x1_inner_screw, pos_y_inner_screw, 0])
    arduino_screw_column();    
translate([pos_x2_inner_screw+0.35, pos_y_inner_screw, 0])
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

module relay_screw_columns() {
    pos_x1_first_screw = 31.0;
    pos_y1_first_screw = 26.5;
    
    x_distance = 60.2 + real_screw_radio;
    y_distance = 89.0 + real_screw_radio;
    
    pos_x2_first_screw = pos_x1_first_screw + x_distance;
    pos_y2_first_screw = pos_y1_first_screw + y_distance;
    
    translate([pos_x1_first_screw, pos_y1_first_screw, 0]) 
        arduino_screw_column();        
       
    translate([pos_x2_first_screw, pos_y1_first_screw, 0])
        arduino_screw_column();    
translate([pos_x1_first_screw, pos_y2_first_screw, 0])
        arduino_screw_column();            
    translate([pos_x2_first_screw, pos_y2_first_screw, 0])
        arduino_screw_column();
    
    //interfase screws
    translate([size_x/2, 7, 0]) 
        cube([20, 7, relay_pos_z-1.5]);
    translate([size_x - 25, 15, 0]) 
        cube([20, 7, relay_pos_z-1.5]);        
}

module relay_box() {
  translate([relay_box_x, box_y, 0.0]) {
      difference() {
        difference() {
          cube([size_x, size_y, size_z], false);
          translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0])
            cube([size_inner_x, size_inner_y, size_z], false);    
          boundary_port(box_thickness);
          relay_port();
        }
        breathing_holes();
    }
    box_screw_columns();
    relay_screw_columns();
  }
}

module display_screws (cover_z_size){
    dx_screw_1 = dx_disp - 3.0;
    dy_screw_1 = dy_disp - 7.0;
    x_separation = 76;
    y_separation = 37.6;
    
    //rotate([0,180,0])
    mirror([0,0,0]) {
    translate([dx_screw_1, dy_screw_1, 21.3 - cover_z_size])
        arduino_screw_column();
    translate([dx_screw_1 + x_separation, dy_screw_1, 21.3-cover_z_size])
        arduino_screw_column();    
    translate([dx_screw_1 + x_separation + 1.2, dy_screw_1 + y_separation - 1.0, 21.3 - cover_z_size])
        arduino_screw_column();        
    translate([dx_screw_1-0.5, dy_screw_1 + y_separation, 21.3 - cover_z_size])
        arduino_screw_column();                
    }
}

module buttons_screws (cover_z_size){
    dx_screw_1 = dx_buttons - 4.5;
    dy_screw_1 = dy_buttons - 1.5;
    x_separation = 50;
    y_separation = 13;
    
    //rotate([0,180,0])
    mirror([0,0,0]) {
    translate([dx_screw_1, dy_screw_1, 21.3 - cover_z_size])
        arduino_screw_column();
    translate([dx_screw_1 + x_separation, dy_screw_1, 21.3-cover_z_size])
        arduino_screw_column();    
    translate([dx_screw_1 + x_separation, dy_screw_1 + y_separation, 21.3 - cover_z_size])
        arduino_screw_column();        
    translate([dx_screw_1, dy_screw_1 + y_separation, 21.3 - cover_z_size])
        arduino_screw_column();                
    }
}

// TO DO: Make an inner cylinder to make an low stamped effect
module buttons(cover_z_size) {
    translate([dx_buttons+5, dy_buttons+5,0])
        difference()
            cylinder(cover_z_size, y_size_buttons/2, y_size_buttons/2,true);
    translate([dx_buttons+20, dy_buttons+5,0])
        cylinder(cover_z_size, y_size_buttons/2, y_size_buttons/2,true);    
    translate([dx_buttons+35, dy_buttons+5,0])
        cylinder(cover_z_size, y_size_buttons/2, y_size_buttons/2,true);        
        //cube([x_size_buttons, y_size_buttons, cover_z_size], false); 
}

module display(cover_z_size) {    
    translate([dx_disp, dy_disp,0])
        cube([x_size_disp, y_size_disp, cover_z_size], false); 

}

module cover_screw_column(cover_z_size) {
  difference() {
    cylinder(h = cover_z_size , r1 = box_screw_column_radious, r2 =    box_screw_column_radious, center = false);
    translate([0.0, 0.0, 0])
        cylinder(h = cover_z_size, r1 = box_screw_column_radious /3.0, r2 =    box_screw_column_radious / 3.0, center = false);      
  }
}

module cover_screw_columns(cover_z_size) {
  translate([box_thickness, box_thickness, -cover_z_size])
    cover_screw_column(cover_z_size);
  translate([size_x - box_thickness, box_thickness, -cover_z_size])
    cover_screw_column(cover_z_size);
  translate([size_x - box_thickness, size_y - box_thickness, -cover_z_size])
    cover_screw_column(cover_z_size);
  translate([box_thickness, size_y - box_thickness, -cover_z_size])
    cover_screw_column(cover_z_size);
}


module arduino_cover() {
    cover_z_size = 20;
    translate([0, 0, 0]) {
        difference() {
            cube([size_x, size_y, cover_z_size], false);
            translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0])
                cube([size_inner_x, size_inner_y, cover_z_size], false);
            display(cover_z_size);
            buttons(cover_z_size);
        }
        
    }
         
    if (DEBUG) {
            display(cover_z_size);
            buttons(cover_z_size);
    }
    
    display_screws(cover_z_size);
    buttons_screws(cover_z_size);
    mirror([0,0, 1]) cover_screw_columns(cover_z_size);
}

module breathing_holes (){
// "breathing"s holes  
for (x = [box_thickness:10:size_x - box_thickness],
    y = [4.0:5.0:23.0],
    z = [0.0] )
    translate([x,y*5.5-10.0,z]){ 
        cube([4.0, 22.0, box_thickness],0.0, false);
    }    
}

module relay_cover() {
    cover_z_size = 20;
    difference() {
        difference() {
            cube([size_x, size_y, cover_z_size], false);
            translate([box_thickness/2.0, box_thickness/2.0, box_thickness/2.0])
                cube([size_inner_x, size_inner_y, cover_z_size], false);    
        }
            breathing_holes();
    }
    
    mirror([0,0, 1]) cover_screw_columns(cover_z_size);
}

module boundary_port(origin_x) {
  translate([origin_x, (size_y - boundary_size_x) / 2.0, 5.0])
    rotate([0.0, 0.0, 90.0])
      cube([boundary_size_x, box_thickness + 10.0, 9.0], false);
}

//projection() {arduino_box();}
arduino_box();

//projection() {
translate([0,150,0]) {
    rotate([0,0,0]){
        arduino_cover();
    }
}
//}

translate([150, 0, 0])
    relay_box();

translate([150, 150, 0])
    relay_cover();

 