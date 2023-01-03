% Zad. 2b. Symulacja sterowania
clc; clear all; close all;

[~,y] = ode45(@odefun,[0 40],[0, 0]);
figure; plot(t,y(:,1))
title('Odpowiedz ukladu regulacji', 'FontSize',14);
xlabel('t', 'FontSize',14); ylabel('y(t)', 'FontSize',14);

function dydt = odefun(~,y)
% Uzupelnij ponizsze podpunkty:
% 1) Oblicz uchyb.
% 2) Oblicz rownanie sterowania.

% Sterowanie wyznaczylismy recznie, wiec podajemy sam obiekt, ktorym chcemy
% sterowac (jego rownania stanu).
% 3) Rownania stanu obiektu regulacji:
% dydt = [y1'; y2'];
end