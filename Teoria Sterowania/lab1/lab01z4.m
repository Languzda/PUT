% Odpowiedzi czasowe dla wahadla matematycznego - u¿ycie solvera
% https://www.mathworks.com/help/matlab/ref/ode45.html
% https://www.mathworks.com/help/matlab/ref/ode45.html#bu00_4l_sep_shared-odefun
close all; clear all; clc;

x0 = [pi; 0];     	% warunki poczatkowe
t = 0:0.01:14;      % wektor czasu

[t, x] = ode45(@odefun, t, x0);
plot(t, x(:,1)*180/pi);% przeskalowanie deg do radianów to to *180/pi[DODANE]
xlabel('t [s]'); ylabel('y [deg]');

function dxdt = odefun(t, x)
    m = 1;       % [kg]
	g = 9.81;    % [m/s^2]
	l = 1.5;     % [m]
	B = 1.96;    % [1/s]
	u = 1;       % wymuszenie
    dx1 = x(2);
    dx2 = -g/l*(x(1))-B/(m*l^2)*x(2)+1/(m*l^2)*u;
    dxdt = [dx1; dx2];
end

% przeanalizowaæ 7 punkt z instrukcji
% 3 sposoby czego???
% -schemat blokowy
% -solver
% -gotowa funkcja 