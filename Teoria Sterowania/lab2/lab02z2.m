% Zad. 2. Przekszta³canie do postaci kanonicznej sterowalnej
close all; clear all; clc;

% Wybór uk³adu
uklad = 1;
switch uklad
    case 1
        A = [-10 3; -32 10];
        B = [1; 3]; C = [-1 1]; D = 0;
    case 2
        A = [-3 1 -3; 1 -1 -3; 1 2 -4];
        B = [2; 3; 2]; C = [1 1 0]; D = 0;
    case 3
        A = [1 0 0; 0 3 1; 0 0 4];
        B = [0; 0; 2]; C = [0 0.5 0.5]; D = 0;
end
% nasze
poly(A)

% uklad 1
A2 = [0, 1; 4, 0];
B2 = [0; 1];
% uklad 2
% A2 = [0, 1, 0; 0, 0, 1; -38, -27, -8];
% B2 = [0; 0; 1]

S1 = ctrb(A,B)
S2 = ctrb(A2, B2)
P=S2*S1^(-1)

alpha = P*A*P^(-1)

beta = P*B
odwroconeL = C*P^(-1)
delta = D
[l, m] = ss2tf(A2,B2,odwroconeL,delta)
