import numpy as np
import scipy
from matplotlib import pyplot as plt

# Paramatry
l = 1
m = 9
J = 1
g = 9.81
d = 0.5

#A = np.matrix([[0,1],[m* g*l* np.sin(x[0]) /x[0] , -d/J ]])
#B = np.matrix ([[0] ,[1/ J ]]) #return np.matrix ([[1 ,0] ,[0 ,1]])
    return np.matrix ([[ x [0]**2 ,0] ,[0 , x [1]**2]])

#R = np.matrix([1])

def A(x) :
    return np.matrix ([[0 , 1] , [m* g*l* np.sin(x[0]) /x[0] , -d/J ]])

def B(x) :
    return np.matrix ([[0] ,[1/ J ]])

def Q(x) :
    #return np.matrix ([[1 ,0] ,[0 ,1]])
    return np.matrix ([[ x [0]**2 ,0] ,[0 , x [1]**2]])

def R(x) :
    return np.matrix ([[1]])

t = np.arange (0 , 10 ,0.01)
# LQR calculations

def LQR (t , x ):
    P = scipy.linalg.solve_continuous_are (A (x) ,B(x) ,Q(x ) ,R( x))
    K = R( x).I @ B(x) .T @ P
    u = - K @ np.matrix ([ x ]) . T
    return u
# define dynamic system

def model (t , x):
    u = control (t , x)
    #u = 0
    dx = x. copy ()
    dx [0] = x [1]
    dx [1] = 1/ J*u - d/J* x [1] + m*g* l* np . sin (x [0])
    return dx
# simulate the dynamic system
res = scipy.integrate.odeint( model , [2* np.pi ,0] , t, tfirst = True , rtol =1e-10)
# plot results
plt.plot (t , res [: ,0])
plt.plot (t , res [: ,1])
plt.grid () ;
plt.legend (['theta','dot theta'])

# 2.2 Stabilizacja jest prawidłowa, ponieważ przebiegi zbiegają sie do zera

