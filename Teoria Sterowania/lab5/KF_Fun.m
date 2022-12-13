function x = KF_Fun(we)
%% Odczyt wejsc
global P
y = we(1);  % aktualny pomiar
u = we(2);  % aktualne wymuszenie
x1 = we(3:4);   % poprzedni wektor stanu

% Dane obiektu
R = 3; % [Om]
L = 0.05; % [H]
kfi = 2.23; % [Vs^2]
J= 0.11; % [Nm^2]

% Macierze ciagle
A = [-R/L, -kfi/L; kfi/J, 0];
B = [1/L; 0];
C = [1 0];

Tp = 0.001; % okres próbkowania
I = eye(2); % macierz jednostkowa

% Macierze dyskretne
Ad = I+A*Tp;
Bd = B*Tp;
Cd = C;

%% Nastawy filtru
% var_n = % wariancja szumu pomiarowego
% var_v = % wariancje szumow wewnetrznych

% Q = diag(var_v);    % macierz kowariancji szumow wewnetrznych
% R = diag(var_n);  	% macierz kowariancji szumow pomiarowych


%% Algorytm filtru Kalmana
% Etap predykcji

% Etap filtracji
