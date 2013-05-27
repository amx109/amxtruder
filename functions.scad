x=0;
y=1;
z=2;

function centerof(a, b) = [(a[x]+b[x])/2, (a[y]+b[y])/2, (a[z]+b[z])/2];
function sizeof(a, b) = [b[x]-a[x], b[y]-a[y], b[z]-a[z]];
function minof(a, b) = [a[x]-b[x]/2, a[y]-b[y]/2, a[z]-b[z]/2];
function maxof(a, b) = [a[x]+b[x]/2, a[y]+b[y]/2, a[z]+b[z]/2];

function pitch_radius(number_of_teeth, modulus=1) = number_of_teeth * modulus / 2;
