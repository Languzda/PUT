function ster = regStan(u)

% Odczyt wejsc
r=u(1)
uI=u(2)
x=[u(3); u(4)]
K=[u(5), u(6)]
kfi=2.23

% Prawo sterowania
ster = -K*x+r*(K(2)+kfi)+uI;

end