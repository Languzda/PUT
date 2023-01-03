function ddy = z5_obiekt_nieliniowy(we)

% Odczyt wejsc
u  = we(1);
y  = we(2);
dy = we(3);

% Parametry obiektu
m = 1;      % [kg]
g = 9.81;   % [m/s^2]
l = 1.5;    % [m]
B = 1.96;   % [1/s]

a2 = m*l^2;
a1 = B * abs(dy);
a0 = m*g*l * sin(y);
b  = 1;

% Rownanie ruchu
ddy = (- a0 - a1*dy + b*u)/a2;