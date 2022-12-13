% Silnik DC - dane wzorowe, przygotowanie
close all; clear all; clc;

% Wariancje szumow wewnetrznych i pomiarowych
var_v = 0.01;
var_n = 10;

% Parametry silnika
R = 3;      % [Om]
L = 0.05;   % [H]
kfi = 2.23; % [Vs^2]
J = 0.11;   % [Nm^2]
Tp = 0.001; % [s]
Tsim = 1;   % [s]
% Parametry symulacji
uz = 300; % [V]
mop = 0;  % 

% Wektory do zapisu
i = zeros(1, 1000); % prad
w = zeros(1, 1000); % predkosc katowa

% Macierze ciagle
A = [-R/L, -kfi/L; kfi/J, 0];
B = [1/L, 0; 0, -1/J];
C = [1, 0];
D = [0, 0];

% Wartosci poczatkowe i wektory do zapisow
x0 = [0; 40];
x = zeros(2, 1000);
y = zeros(1,1000);
x(:,1)=x0;

% Macierze dyskretne
I = eye(2);
Ad = I + A*Tp;
Bd = B*Tp;
Cd = C; Dd = D;

% Petla czasowa
for k = 2:1000
    
    % W polowie symulacji dodatkowe obciazenie - moment oporowy
    if k >=500
        % kfi*i_zad = 2.23*20
        mop = 44.6;
    end
    
    % Zaszumione rownania stanu
    x(:,k) = Ad*x(:,k-1) + Bd*[uz,mop]' + randn(2,1)*sqrt(var_v);
    y(k) = Cd*x(:,k)+randn()*sqrt(var_n);
    
end

% Wykresy
tt = Tp:Tp:Tsim;
plot(tt, y, 'g'); hold on;
plot(tt, x(1,:));
plot(tt, x(2,:), 'r');
xlabel('t [s]'); ylabel('x_i(t)');
legend('Pomiar pradu', 'Prad - wzor', 'Predkosc - wzor');
set(legend, 'Location', 'best'); % dopasowanie pozycji legendy
% Uwaga - logistycznie lepiej naniesc najpierw bardziej zaszumiony przebieg
% (tutaj y), bo inaczej moglby on zakryc wykres pradu 'prawdziwego'.

% Zapis danych do pliku csv
m = [tt', y', x(1,:)', x(2,:)'];
% csvwrite('silnik.csv', m)