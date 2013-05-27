use <scadlib/fasteners.scad>;
use <scadlib/materials.scad>;
$fn = 50;
Infinity = 9001;

module gearmotor() {
  translate([0, 7, 0]) {
    steel() cylinder(r = 12 / 2, h = 3);
    translate([0, 0, 4]) stainless() render() intersection() {
      cylinder(r = 5 / 2, h = 14);
      union() {
        translate([0, 1, 0] * Infinity / -2 + [-2, 0, 4]) cube(Infinity);
        translate([1, 1, 0] * Infinity / -2) cube([Infinity, Infinity, 4]);
      }
    }
  }
  mirror([0, 0, 1]) {
    steel() cylinder(r = 37 / 2, h = 14);
    color([1, 1, 1] * 0.6) translate([0, 0, 14])
      cylinder(r = 42 / 2, h = 37 - 14);
  }
}

module gearmotor_screws(h) mirror([0, 0, 1]) {
  for (i = [-1, 1]) translate([27 / 2 * i, 0, 0]) {
    bolt(n = 3, h = h);
  }
}

gearmotor();
translate([0, 0, 10]) gearmotor_screws(10);
