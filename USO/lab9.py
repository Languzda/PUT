import numpy as np
import scipy 
from scipy import linalg, interpolate
from matplotlib import pyplot as plt

l = 1
m = 9
J = 1
d = 0.5
g = 9.81
Tau = 1

A = np.array([[0, 1], [-(m*g*l/J)*np.cos(np.pi/2), -d / J]])
B = np.array([[0], [1 / J]])
C = np.array([1, 0])
D = 0 

Q = np.array([[1, 0], [0, 1]])
R = 1

P = linalg.solve_continuous_are(A, B, Q, R)
K = R ** (1) * (B.T) @ P

def model(x,t):
    u = 1
    dx1 = x[1]
    dx2 = u*Tau/J -d/J*x[1] -m*g*l*np.sin(x[0])
    return [dx1, dx2]

def model_lin(x,t):
    u = -K@(x-[np.pi,0]) + 0
    dx2 = A@x +B@u
    return dx2

t = np.linspace(0, 10, num=1000)
x = [np.pi/4,0]
x2 = [0,0]

res = scipy.integrate.odeint(model, x, t)
res2 = scipy.integrate.odeint(model_lin, x2, t)

plt.figure()
plt.plot(t,res)

plt.figure()
plt.plot(t,res2[:,0], label='Położenie')
plt.plot(t,res2[:,1], label='Prędkosc')
plt.legend()

# 2.5 Zadanie stabilizacji ukłądu liniowego jest realizowane poprawnie, układ się stabilizuje w położeniu pi

# 2.6 Układ jest stabilny dla każdej wartosci początkowej 

# Zaleznoc ta raczej nie będzie obowiązywać dla dowolnego układu nieliniowego, zależne to będzie od pkt równowagi układu

p0 = np.array([[1, 1],[1,1]])

def ricca(p, t):
    p = np.reshape(p,(2,2))
    pdot = -(p@A + A.T@p -p@B*(1/R)@B.T@p +Q)
    return pdot.flatten()

def modelLQR(x,t,x1,x2,x3,x4):
    p = np.array([[x1(t), x2(t)], [x3(t), x4(t)]])
    K = R**(1) * (B.T) @ p
    u = -K @ (x-[np.pi, 0])
    dx = A@x + B@u
    return dx.flatten()

t = np.linspace(5, 0, num=1000)
riccati = scipy.integrate.odeint(ricca, p0.flatten(), t)

x1 = interpolate.interp1d(t, riccati[:, 0], fill_value="extrapolate")
x2 = interpolate.interp1d(t, riccati[:, 1], fill_value="extrapolate")
x3 = interpolate.interp1d(t, riccati[:, 2], fill_value="extrapolate")
x4 = interpolate.interp1d(t, riccati[:, 3], fill_value="extrapolate")
    
t = np.linspace(0, 10,num=1000)
res3 = scipy.integrate.odeint(modelLQR, [0,0], t,args=(x1,x2,x3,x4))

plt.figure()
plt.plot(t, res3[:,0], label="Polozenie")
plt.plot(t, res3[:,1], label="Predkosc")
plt.legend()


