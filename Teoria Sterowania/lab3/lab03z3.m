% Zad. 3. Sterowanie ze sprzê¿eniem wyprzedzaj¹cym - obliczenia
close all; clear all; clc;

% Definicja obiektu
A = [0 1; 4 3];
B = [0; 2];
C = [1 0];
D = 0;
sys = ss(A,B,C,D);

% Czestotliwosc wymuszenia (sinus)
fw = 1/40;
% fw = 0.5;

% Dalsza czesc programu - sprzezenie od stanu (Kx podajemy do schematu)
s = [-2, -0.5];
K = -place(A, B, s);