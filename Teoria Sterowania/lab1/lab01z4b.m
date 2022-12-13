% Symulacja - obiekt niestacjonarny.
close all; clear all; clc;

% Definicja parametrow - struktura przekazana jako argument funkcji
params.m = 1;      % [kg]
params.g = 9.81;   % [m/s^2]
params.l = 1.5;    % [m]
params.B = 1.96;   % [1/s]
params.u = 1;     % wymuszenie

x0 = [0; 0];     % warunki poczatkowe
t = 0:0.01:20;     % wektor czasu

[t, x] = ode45(@odefun, t, x0, [], params);
plot(t, x(:,1)*180/pi); % modyfikacja - po³o¿enie w stopniach
xlabel('t [s]'); ylabel('y [deg]');

function dxdt = odefun(t, x, params)
    if t >= 10 % skokowa zmiana masy w polowie symulacji
        params.m = params.m / 4;
    end
    dxdt = [x(2); -params.g/params.l*sin(x(1))-params.B/(params.m*params.l^2)*x(2)+ ...
        1/(params.m*params.l^2)*params.u];
end