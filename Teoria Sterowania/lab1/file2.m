a = 0.9;
b = 2000;

A = [1-a];
B = [b];
C = [1];
D = [0];

ob = ss(A, B, C, D, -1);
step(ob)