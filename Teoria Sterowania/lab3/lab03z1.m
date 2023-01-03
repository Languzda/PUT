% % Zad. 1. Test obiektu.
close all; clear all; clc;

% Definicja obiektu
A = [0 1; 4 3];
B = [0; 2];
C = [1 0];
D = 0;

% Sprawdzenie stabilnosci
eig(A)
% Zad1.1 moj koment: nie jest stabilny(zmiana znaku -1 -> 4 na podstawie Rootha)

% Zad1.2 moj koment: policzyć te k co na początku instrukcji są i sprawdzić czy jest taka możliwość 

% Sprzezenie od stanu
s = [-2-i, -2+i]
k = -place(A, B, s)


ob = ss(A, B, C, D);
figure; step(ob);

% tworzenie macierzy sprzeżenia od stanu
A1 = A+B*k

% wartości własne nowej macierzy sprzężenia od stanu
xxxx = eig(A1)
figure; step(ss(A1, B, C, D));
% moj koment: udało się ustabilizować(widoczne na wykresie 2). Poprzednio
% na wykresie pierwszym to jest układ przed stabilizacją