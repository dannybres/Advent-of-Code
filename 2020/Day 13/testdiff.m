syms x y z t
f = 17*x == t;
g = 13*y == t+2;
h = 19*z == t+3;



a = solve([f g h],[x y z])