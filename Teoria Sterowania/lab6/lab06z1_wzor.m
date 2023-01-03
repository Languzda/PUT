% Zad. 1. Stabilnosc w obiekcie
clc; clear all; close all;

[t,y] = ode45(@odefun,[0 80],[0, 0]);
figure; plot(t,y(:,1))
title('Odpowiedz obiektu na wymuszenie', 'FontSize',14);
xlabel('t', 'FontSize',14); ylabel('y(t)', 'FontSize',14);

function dydt = odefun(~,y)
% Parametry obiektu
m = 1;      % [kg]
c = 3.7;    % [Ns/m]
% Wartosc powyzszego parametru sprobuj zmienic, badajac wplyw na stabilnosc
k = 2;      % [N/m]
% Wymuszenie - skok jednostkowy
u = 1;

% Rownania stanu nieliniowe
dydt = [y(2); -k/m*y(1)^3-c/m*y(2)*abs(y(2)) + 1/m*u];
end