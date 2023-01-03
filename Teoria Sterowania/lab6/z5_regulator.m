function uu = z5_regulator(we)

% Odczyt wejsc
r  = we(1); dr = 0; ddr = 0;
y  = we(2); e = r - y;
dy = we(3); de = dr - dy;

% Parametry obiektu
m = 1;      % [kg]
g = 9.81;   % [m/s^2]
l = 1.5;    % [m]
B = 1.96;   % [1/s]

a2 = m*l^2;
a1 = B * abs(dy);
a0 = m*g*l * sin(y);
b  = 1;

%Regulator
lambda = 0.5;
k = 1;


% Prawo sterowania
uu = r; % domyslnie uklad OTWARTY
uu = a2 * k/lambda*e + (a2 * (k+1/lambda) - a1) * de + a0 + a1*dr +a2*ddr;
