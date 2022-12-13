% Zad. 2. Zbiorniki + sprzezenie od stanu
close all; clear all; clc;

% Parametry ukladu liniowego
c = 150;	% [cm^2]
a = 2.8; 	% [cm]
g = 981;  	% [cm/s^2]

% Aproksymacja liniowa obiektu (oryginalnie jest on nieliniowy)
A = [-a*g/(c*(10*g)^0.5), a*g/(c*(10*g)^0.5) ;
      a*g/(c*(10*g)^0.5), -2*a*g/(c*(10*g)^0.5)];
B = [1/c ; 0];
C = [0, 1];
D = [0];

% Definicja systemu
sys = ss(A,B,C,D);
% Ch-ki czestotliwosciowe - do identyfikacji
figure; bode(sys); grid on;

% Dalsza czesc programu - sprzezenie od stanu
% pisane przez nas 
wartWlasne = eig(A)
s = [-0.5, -1]
k = -place(A, B, s)

% to już nie nasze
ob = ss(A, B, C, D);
figure; step(ob);
A1 = A+B*k

x0 = [0; 0];     % warunki poczatkowe
t = 0:0.01:120;     % wektor czasu
[t, x] = ode45(@odefun, t, x0, [], A, B, k);

% Rysowanie wykresow
figure; plot(t, x(:,2));
xlabel('t [sek]'); ylabel('y(t) [cm]');

function dxdt = odefun(t, x, A, B, k)
    u = 10 +k*x;
    dxdt = A * x + B * u;
end