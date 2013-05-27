$fa = 0.01;
$fs = 1;

motor_rotation = 270;

wall_thickness = 2;

module fan(r = 4) {
	linear_extrude(height=7)
	difference() {
		hull() {
			translate([ 20 - r,  20 - r]) circle(r);
			translate([ 20 - r, -20 + r]) circle(r);
			translate([-20 + r,  20 - r]) circle(r);
			translate([-20 + r, -20 + r]) circle(r);
		}
		translate([ 20 - r,  20 - r]) circle(1.6);
		translate([ 20 - r, -20 + r]) circle(1.6);
		translate([-20 + r,  20 - r]) circle(1.6);
		translate([-20 + r, -20 + r]) circle(1.6);

		circle(18);
	}
}

module fan_negative(r = 4) {
	linear_extrude(height = 10) {
		translate([ 20 - r,  20 - r]) circle(1.6);
		translate([ 20 - r, -20 + r]) circle(1.6);
		translate([-20 + r,  20 - r]) circle(1.6);
		translate([-20 + r, -20 + r]) circle(1.6);
	}

	translate([ 20 - r,  20 - r, 9]) hull() {
		cylinder(r=5.5 / 2 / cos(180 / 6), h=2.5, $fn=6);
		translate([15, -5.5 / 2, 0]) cube([1, 5.5, 2.5]);
	}
	translate([ 20 - r, -20 + r, 9]) hull() {
		cylinder(r=5.5 / 2 / cos(180 / 6), h=2.5, $fn=6);
		translate([15, -5.5 / 2, 0]) cube([1, 5.5, 2.5]);
	}
	translate([-20 + r,  20 - r, 9]) hull() {
		cylinder(r=5.5 / 2 / cos(180 / 6), h=2.5, $fn=6);
		translate([-15, -5.5 / 2, 0]) cube([1, 5.5, 2.5]);
	}
	translate([-20 + r, -20 + r, 9]) hull() {
		cylinder(r=5.5 / 2 / cos(180 / 6), h=2.5, $fn=6);
		translate([-15, -5.5 / 2, 0]) cube([1, 5.5, 2.5]);
	}

	for(i=[-1, 1]) for (j=[-1, 1])
		translate([i*(20-r), j*(20-r), 9+2.5+.35])
		cylinder(h=10, r=1.6);
}

module motor() {
	render(convexity=4)
	union() {
		cylinder(r=35/2, h=41);
		difference() {
			hull() {
				translate([ 21, 0, 0]) cylinder(r=3.65, h=5);
				translate([-21, 0, 0]) cylinder(r=3.65, h=5);
				cylinder(r=35 / 2, h=5);
			}
			translate([ 21, 0, -1]) cylinder(r=3.5 / 2, h=7);
			translate([-21, 0, -1]) cylinder(r=3.5 / 2, h=7);
		}
		
		translate([0, 0, -18]) cylinder(r=5 / 2, h=20);
		translate([0, 0, -4.7]) cylinder(r=10 / 2, h=10);
		
		rotate([0, 0, -60]) translate([35 / 2 - 10 + 5.5, -9, 27]) cube([20, 18, 15]);
	}
}

module motor_negative() {
	motor();
	translate([ 21, 0, 0]) cylinder(r=3.6 / 2, h=5);
	translate([-21, 0, 0]) cylinder(r=3.6 / 2, h=5);
	
	/*translate([ 21, 0, 4]) hull() {
		cylinder(r=7 / 2, h=4);
		cylinder(r1=7 / 2, r2 = 0, h = 8);
	}
	translate([-21, 0, 4]) hull() {
		cylinder(r=7 / 2, h=4);
		cylinder(r1 = 7 / 2, r2 = 0, h = 8);
	}*/

	translate([ 21, 0, 5 + wall_thickness]) mirror([0, 0, 1]) m3pair();
	translate([-21, 0, 5 + wall_thickness]) mirror([0, 0, 1]) m3pair();
}

module roundcylinder(r=1, h=10, re=2) {
	rotate_extrude()
	translate([0, h / -2]) hull() {
		square([r - re - 0.5, h]);
		translate([r - re, re]) circle(re);
		translate([r - re, h - re]) circle(re);
	}
}

// motor();

module m3pair(h = 10) {
	render() {
		hull() {
			translate([0, 0, -10]) cylinder(r=3.5, h=10);
			translate([0, 0, -10]) mirror([0, 0, 1]) cylinder(r1=3.5, r2=2, h=35);
		}
		translate([0, 0, -1]) cylinder(r=1.6, h=h + 1 - 0.2);
		translate([0, 0, h]) cylinder(r=5.5 / 2 / cos(180 / 6), h=25, $fn=6);
	}
}

module shroud() {
	difference() {
		shroud_positive();

		shroud_negative();
	}
}

module shroud_positive() {
	render(convexity=4)
	union() {
		hull() {
			translate([0, 0, -2]) roundcylinder(45 / 2 + wall_thickness, 36, 3);
			translate([29.5, 0, -3]) rotate([0, -90, 0]) fan();
			translate([0,  21, -20]) cylinder(r=11 / 2, h=36);
			translate([0, -21, -20]) cylinder(r=11 / 2, h=36);
		}
		/*hull() {
			translate([-5, 18, -5 ]) cube([10, 10, 10]);
			translate([-8, 16, -12]) cube([20, 5, 24]);
		}
		mirror([0, 1, 0]) hull() {
			translate([-5, 18, -5]) cube([10, 10, 10]);
			translate([-8, 16, -12]) cube([20, 5, 24]);
		}*/
	}
}

module shroud_negative() {
	render(convexity=4)
	union() {
		translate([0, 0, -30]) cylinder(r=36 / 2, h=60);
		translate([0, 0, -25]) rotate([0, 0, motor_rotation]) { motor_negative(); %motor(); }
		hull() {
			translate([ 0, 0, -2]) roundcylinder(45 / 2, 36 - (wall_thickness * 2), 3 - wall_thickness);
			translate([27, 0, -3]) rotate([0, 90, 0]) cylinder(r=18, h=1);
		}
		translate([20  , 0, -3]) rotate([0,  90, 0]) cylinder(r=18, h=20);
		translate([36.5, 0, -3]) rotate([0, -90, 0]) { fan_negative(); }

		//translate([-5,  25.5, 0]) rotate([0, 90, 0]) m3pair(10);
		//translate([-5, -25.5, 0]) rotate([0, 90, 0]) m3pair(10);
	}
}

module piece1() {
	translate([0, 0, 29.5])
	rotate([0, 90, 0])
//	render()
	difference() {
		shroud();
		difference() {
			translate([-220, -100, -100]) cube([200, 200, 200]);
			translate([0,  21, -20]) cylinder(r=9 / 2, h=wall_thickness);
			translate([0, -21, -20]) cylinder(r=9 / 2, h=wall_thickness);
		}
		translate([-200, -18, -100]) cube([200, 36, 200]);
	}
}

module piece2() {
	translate([0, 0, 20])
	render()
	difference() {
		union() {
			shroud_positive();
			difference() {
				translate([0, 0, -5]) roundcylinder(45 / 2, 50, 3);
				translate([0, 0, -35]) cylinder(r=50, h=15);
			}
		}
		shroud_negative();
		translate([0, 0, 5]) cylinder(r=43 / 2, h=45);
		translate([0, 0, -25]) cylinder(r=35 / 2, h=10);
		translate([0, 0, 1]) roundcylinder(43 / 2, 40, 2);
		translate([0, -100, -100]) cube([200, 200, 200]);
		rotate([0, 0, motor_rotation - 240]) translate([-35, -9, 1]) cube([20, 18, 20]);
	}
}

translate([ 25, 0, 0]) piece1();
//translate([0, 0, 0]) piece2();

//translate([0, 70, 20]) shroud();

//shroud();

//piece1();
//translate([-20, 0, 24.5]) rotate([0, 90, 0]) 
//  piece2();

