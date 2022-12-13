% Zad. 3. Przekszta³canie do postaci diagonalnej - wartoœci rzeczywiste
close all; clear all; clc;

% Wybór uk³adu
uklad = 2;
switch uklad
    case 1
        A = [-4, -2; -1, -3];
        B = [1; 2]; C = [1 0]; D = 0;
    case 2
        A = [-1 -2 2; 3 -7 5; 1 -2 0];
        B = [1; -1; 0]; C = [1 1 0]; D = 0;
    case 3
        A = [-1.8 -1.21 -0.36 -0.16; 1 0 0 0; 0 1 0 0; 0 0 0.25 0];
        B = [2; 0; 0; 0]; C = [0 1 0.9 0.72]; D = 0;
end
load('lab02_M_data.mat')
[M, b] = jordan(A)

P = M^(-1)

% P = M32^(-1)
A2 = P * A * P^(-1)
