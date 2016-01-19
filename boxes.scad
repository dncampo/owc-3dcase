thickness = 2;
size_x = 50;
size_y = 75;
size_inner_x = size_x - thickness;
size_inner_y = size_y - thickness;
$fn=40; 


module usb_port() {
    translate([15, size_y/2, -10])
        cube([13, 2, 13], true);
}
	
module jack_port(){
  translate([-15, size_y/2, -10])
  rotate([90,00,0])
  cylinder(h = thickness, r1 = 5, r2 = 5, center = true);
  
}

module example001()
{
difference() {
    cube([size_x, size_y, size_x], true);
    translate([0, 0, thickness])
		cube([size_inner_x, size_inner_y, size_x], true);    
	 usb_port();
	 jack_port();
 }
}

example001();
//translate([-15, size_y/2, -10]);
//usb_port();
rotate([90,00,0])
  cylinder(h = thickness, r1 = 2, r2 = 2, center = true);
