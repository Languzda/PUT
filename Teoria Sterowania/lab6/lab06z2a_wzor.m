% Zad. 2a. Portret fazowy dla ukladu regulacji
clc; clear all; close all;

% Symulujemy rozne warunki poczatkowe na y1, y2 (dobierz samodzielnie) 
for y1_p=-1:0.5:1
    for y2_p=-1:0.5:1
        y0 = [y1_p; y2_p];
        hold on
        [~,y] = ode45(@odefun,[0 40],y0);
        plot(y(:,1),y(:,2), 'b')
    end
end
% I tutaj juz bedzie caly portret :)
title('Portret fazowy', 'FontSize',14);
xlabel('y', 'FontSize',14); ylabel('dy/dt', 'FontSize',14);
grid minor

% Tutaj mozna wykreslic przykladowy przebieg czasowy
[t,y] = ode45(@odefun,[0 40],[0, 0.5]);
figure; plot(t,y)
title('Przebieg czasowy', 'FontSize',14);
xlabel('t', 'FontSize',14); ylabel('x(t)', 'FontSize',14);
legend('x_1(t)', 'x_2(t)');

function dydt = odefun(~,y)
% Rownania podajemy juz dla ukladu ZAMKNIETEGO.
dydt = [y(2); 0.5*y(1)^2 - y(1) - 0.5*y(2)];
end