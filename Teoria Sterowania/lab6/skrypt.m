clear all;

A = [0 2; -1 -3];
Q = eye(2);

R = lyap(A',Q) %laponuw jest wyprowadzony inaczej niż na labach (inna transpozycja)

[x1, x2] = meshgrid(-10:0.1:10, -10:0.1:10);
Vdot = -x1.^2 - x2.^2;


V = x1.^2 + x1.*x2 + 0.5*x2.^2;
figure
plot3(x1, x2, Vdot)
figure
plot3(x1, x2, V)
