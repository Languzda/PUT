% Zad. 4. Przekszta³canie do postaci diagonalnej - wartoœci zespolone
close all; clear all; clc;

% Wybór uk³adu
uklad = 3;
switch uklad
    case 1
        A = [-1 1; -4 1];
        B = [0; 1]; C = [1 0]; D = 0;
    case 2
        A = [1 -2 3; -2 0 -3; -4 2 -5];
        B = [1; -1; 0]; C = [2 1 0]; D = 0;
    case 3
        A = [0 -1 0 0; 1 -2 -1 1; -43 70 36 -83; -20 33 17 -40];
        B = [-1; 2; 1; 1]; C = [1 0 2 0]; D = 0;
end

load('lab02_M_data.mat')
P = M43^(-1)
A2 = P * A * P^(-1)

