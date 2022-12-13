%% Zad. 1. Modelowanie uk³adu mechanicznego
close all; clear all; clc;

% Parametry silnika
R = 3;      % [Om]
L = 0.05;   % [H]
kfi = 2.23; % [Vs^2]
J = 0.11;   % [Nm^2]

% Macierze ciagle
A = [-R/L, -kfi/L; kfi/J, 0];
B = [1/L; 0];
C = [1, 0];
D = 0;
sys = ss(A, B, C, D);

% OdpowiedŸ skokowa
figure; step(sys);

% poni¿szy kod pisaliœmy sami

%% 1) Dyskretyzacja metod¹ SI
sys_d = c2d(sys, 0.001, 'zoh');
figure; step(sys_d);

%% 2) Dyskretyzacja metod¹ dp
Tp = 0.001; I = eye(2);


%% 3) Regulator proporcjonalny
Tp=0.001;
Ad=eye(2)+ A*Tp;
Bd=B*Tp;
Cd=C;
Dd=D;
M=0.4/Tp %liczba kroków

u=300;
x=zeros(2, M);
y=zeros(1, M);
for k = 2:M
    x(:, k) = Ad*x(:, k-1) + Bd*u;
    y(k) = Cd*x(:, k); %D jest zerowe
end

% t=k*Tp;%??????? what for
figure(); stairs(y);

x=zeros(2, M);
y=zeros(1, M);
C = [0, 1];
Cd=C;
for k = 2:M
    e=100-y(k-1);
    u=50*e;
    x(:, k) = Ad*x(:, k-1) + Bd*u;
    y(k) = Cd*x(:, k); %D jest zerowe
end
figure();plot(y);

