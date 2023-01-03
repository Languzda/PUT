%% BADANIE WLASNOSCI FILTRU KALMANA
close all; clear all; clc;

%% Parametry z tej tylko sekcji nalezy zmieniac w ramach sprawozdania
P0 = 0; x0 = 0;     % wartosci poczatkowe kowariancji i stanu
Q = 1e-3;           % wariancja szumu procesu - nastawa KF
R = 0.02;           % wariancja szumu pomiarowego - nastawa KF
% -------------------------------------------------------------------------
Am = 0.9512;        % macierze stanu MODELU podawanego pozniej do KF
Bm = 0.04877;
Cm = 1;

%% Parametry obiektu 'rzeczywistego' i przygotowanie symulacji
A = 0.9512;
B = 0.04877;
C = 1;
% Ze wzgledu na wymiary obiektu (jedna zmienna stanu), wszystkie macierze
% staja sie skalarami.

% Czas ciagly i dyskretny
tp = 0.05;      % okres probkowania
T = 0:tp:20;    % wektor czasu
M = length(T);  % liczba probek

% Wektory szumow do symulacji
var_v = 1e-3;       % wariancja szumu wewnetrznego (blad modelowania)
var_n = 2e-2;       % wariancja szumu pomiarowego, parametry obiektu
v = randn(1, M) * sqrt(var_v);  % szum wewnetrzny (symulacja bledow modelowania)
n = randn(1, M) * sqrt(var_n);  % szum pomiarowy

u = ones(1, M); % wektor wejsc - skok jednostkowy
u(round(M/2):end) = 0.5; % zmiana amplitudy w polowie symulacji
% Uwaga: zmiane wymuszenia znamy, nie jest to wiec blad modelowania!

% Wektory do wypelnienia w petli
x = zeros(1, M);
y_real = zeros(1,M);
y = zeros(1,M);
x(1) = 0; % wartosc poczatkowa

% Petla czasowa - do wygenerowania danych WZOROWYCH (dzialanie obiektu)
for k = 1:M-1
    x(k+1) = A*x(k) + B*u(k) + v(k);    % rownanie stanu
    y_real(k) = C*x(k);                 % wyjscie 'idealne'
    y(k) = y_real(k) + n(k);            % pomiar - wyjscie zaszumione
    % W praktyce dostep mamy zwykle tylko do pomiaru!
end
% Ostatni obrot petli osobno
y_real(M) = C*x(M);
y(M) = y_real(M) + n(M);


%% Implementacja filtru Kalmana

% Wektory do wypelnienia w petli
x_hat = zeros(1, M);
P = zeros(1,M);

P(1) = P0;       % poczatkowa kowariancja
x_hat(1) = x0;   % wartosc poczatkowa

for k = 2:M
    
    % Etap predykcji
    x_p = Am*x_hat(k-1) + Bm*u(k-1);
    P_p = Am*P(k-1)*Am' + Q;
    
    % Etap filtracji
    K = P_p*Cm' * (Cm*P_p*Cm' + R)^-1;
    x_hat(k) = x_p + K * (y(k) - Cm*x_p);
    P(k) = (1 - K*Cm) * P_p;
    
end
y_hat = Cm*x_hat;    % wektor wyjsc z filtru

% Obliczenie bledow
blad_pomiaru = abs(y - y_real);
blad_estymacji = abs(y_hat - y_real);

% Wskaznik jakosci
RMSE = sqrt(1/M * sum((x_hat - x).^2));
J = sum(blad_estymacji) / sum(blad_pomiaru);

%% Wykresy - przedstawienie wynikow
figure('position',[100,100,1200,600]);
subplot(2, 1, 1);
h = plot(T, y_real, T, y, T, y_hat);
set(h(1), 'color', 'r', 'linewidth', 0.7);
set(h(2), 'color', 'g', 'linewidth', 0.7);
set(h(3), 'color', [0 0.4470 0.7410], 'linewidth', 0.7);
legend('y^{+}', 'y', 'y^{\^}');
title(['Wynik dzialania KF dla Q = ', num2str(Q), ', R = ', ...
    num2str(R), ', P^{(0)} = ', num2str(P(1)), ', x^{(0)} = ', num2str(x_hat(1))]);
yMax = get(gca, 'ylim');
text(4, 0.3*yMax(2)+yMax(1), ['RMSE = ', num2str(RMSE)]);
text(4, 0.17*yMax(2)+yMax(1), ['J = ', num2str(J)]);
subplot(2, 1, 2);
g = plot(T, blad_pomiaru, T, blad_estymacji);
qq = legend('blad pomiaru', 'blad estymacji');
xlabel('t');