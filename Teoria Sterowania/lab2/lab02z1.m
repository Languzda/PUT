% Zad. 1. Badanie sterowalnoœci i obserwowalnoœci
close all; clear all; clc;

% Wybór uk³adu
uklad = 1;
switch uklad
    case 1
        A = [2, 0; 4, -3];
        B = [5; 0]; C = [1 0]; D = 0;
    case 2
        A = [1 0 2; 0 1 0; 0 0 -3];
        B = [0; 1; 0]; C = [2 0 -1]; D = 3;
    case 3
        A = [1 0 1; 0 1 1; -3 0 -3];
        B = [0 1; 1 -1; 0 0];
        C = [3 0 1; 0 -1 1]; D = [0 0; 0 0];
end
% nasze

% ctrb control ability
% rank sprawdza rz¹d macierz
% obsv observability
S = ctrb(A, B)
rankS = rank(S)
O = obsv(A, C)
rankO = rank(O)
%licznik i mianownik transmitancji
% [l, m] = ss2tf(A,B,C,D)

