m = 1;
k = 1;
b = 2;

A = [0 1; -k/m -b/m];
B = [0; 1/m];
C = [1 0];
D = 0;
ob = ss(A, B, C, D);
step(ob);

% x0 = [1; -5];
% initial(ob, x0);

% zadanie 6
A = [1 0; 0 b];
B = [0; 0];