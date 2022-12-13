% Zad. 2. Modelowanie uk³adu elektromechanicznego
close all; clear all; clc;

% Parametry obiektu
R = 0.2; % [Omega]
L = 0.1; % [H]
kfi = 0.15; % [Nm/A]
m = 2; % [kg]
r = 0.2; % [m]
b = 0.4; % [Nm/s]
g = 9.81; % [m/s^2]
% Wymuszenie
U = 8; % [V]

% Definicja uk³adu
A = [-R/L, 0, -kfi/(L*r); 0, 0, 1; kfi/(m*r), 0, -b/(m*r^2)];
B = [1/L, 0; 0, 0; 0, -g];
C = [0, 1, 0];
D = [0, 0];
sys = ss(A, B, C, D);
[y, t, x] = step(sys, 4);

% Ch-ki czêstotliwoœciowe i czasowe
figure('Position', [250 150 960 520]); 
subplot(2,2,1); plot(t, x(:,1,1)*U+x(:,1,2));
xlabel('t [s]'); ylabel('x_1(t) = i(t)'); title('Step response');

subplot(2,2,2); plot(t, x(:,2,1)*U+x(:,2,2));
xlabel('t [s]'); ylabel('x_2(t) = x(t)'); title('Step response');

subplot(2,2,3); plot(t, x(:,3,1)*U+x(:,3,2));
xlabel('t [s]'); ylabel('x_3(t) = v(t)'); title('Step response');
% -> Suma odpowiedzi ze wzgledu na dwa wymuszenia!
% -> Skalowanie zmiennej *U - zasada superpozycji.

subplot(2,2,4); bode(sys); grid on;

% Transmitancja
tf(sys)