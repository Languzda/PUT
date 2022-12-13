% Filtr Kalmana - dane wyjsciowe
close all; clear all; clc;

% Model ciagly i jego parametry
R = 3;      % [Om]
L = 0.05;   % [H]
kfi = 2.23; % [Vs^2]
J = 0.11;   % [Nm^2]
A = [-R/L, -kfi/L; kfi/J, 0];
B = [1/L; 0]; C = [1, 0]; D = 0;

% Napiecie zasilania (wymuszenie)
u = 300;

% Tutaj wyznacz na podstawie pliku csv okres probkowania i liczbe krokow.
% Od tąd my psialiśmy
dane = csvread('.\silnik.csv');
Tp = 0.001;
tt = dane(:, 1) %kolumna czasu
yy = dane(:, 2) %wektor pomiarowy
i_wzorowe = dane(:, 3); %nie ma dostępu
w_wzorowe = dane(:, 4);

% Macierze modelu dyskretnego
I = eye(2);
Ad = I+A*Tp
Bd = B*Tp
Cd = C;
Dd = D;

% zmieniac się ma warotść początkowa
% x_post = [0; 40]; %stan początkowy
x_post = [100; 40]; %stan początkowy

% manipulujemy tutaj wartością kowariancji dla *1000 wartość kowariancji
% jest bardzo wysoka, a w przypadku dzielenia przez 1000 bardzo niska
% P_post = I;
% P_post = I/1000;
P_post = I*1000;
% w celu dopasowania wykresów zmieniliśmy wartości Q i R
% Q = [0.01, 0; 0, 0.01];
Q = [0.4, 0; 0, 0.4];
% R = 10;
R = 2;
x_hat = zeros(2, 1000);

% Na podstawie instrukcji oraz danych pomiarowych zaimplementuj algorytm
% KF. Pamietaj na poczatku o podaniu jego nastaw.

for k = 1:1000
    % Etap predycji 
    x_d = Ad*x_post + Bd*u;
    P_d = Ad*P_post*Ad' + Q;
    % Etap fitracji
    K = P_d*Cd' * (Cd*P_d*Cd' + R)^-1;
    x_hat(:, k) = x_d + K*(yy(k) - Cd*x_d);
    P = (I - K*Cd)*P_d;
    
    % Przekazanie danych
    x_post = x_hat(:, k);
    P_post = P;
end

% Tutaj przedstaw wyniki (wykresy, wskaznik jakosci).
figure;
subplot(2, 1, 1)
plot(tt, yy, tt, i_wzorowe, tt, x_hat(1, :))
subplot(2,1,2)
plot(tt, w_wzorowe, tt, x_hat(2,:))