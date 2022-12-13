% Obserwator stanu - obliczenia do zadania
close all; clear all; clc;

% Model i jego parametry
R = 3;      % [Om]
L = 0.05;   % [H]
kfi = 2.23; % [Vs^2]
J = 0.11;   % [Nm^2]
A = [-R/L, -kfi/L; kfi/J, 0];
B = [1/L; 0]; C = [0, 1]; D = 0;
disp('Badanie obserwowalnoœci')
O = obsv(A, C);
rank(O)

% Tutaj wyznacz wzmocnienia obserwatora Lo = acker..., by do schematu podac
% tylko symbole Lo(1), Lo(2).
% wo -> prêdkoœæ k¹towa
w0 = 60
Lo = acker(A', C', [-w0, -w0])

% Tutaj analogicznie wyznacz wzmocnienia sprzezenia Kx = place...

wc=30
ki=1
Kx = acker(A, B, [-wc, -wc])


