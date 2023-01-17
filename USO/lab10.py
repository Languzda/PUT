import numpy as np
import scipy
from matplotlib import pyplot as plt
from scipy import interpolate

# Paramatry
l = 1
m = 9
J = 1
g = 9.81
d = 0.5

def model (t, x):
    u = 0
    u = sterowanie(t, x)
    t_f = 1
    u= skonczony_u(t, x, t_f)
    dx = x.copy()
    dx[0] = x[1]
    dx[1] = 1/ J*u[3] - d/J* x[1] + m*g* l* np.sin(x[0])
    print(dx)
    return dx

def sterowanie (t , x ):
    P = scipy.linalg.solve_continuous_are (A(x) ,B() ,Q(x) ,R())
    K = R().I @ B().T @ P
    u = - K @ np.matrix([x]).T
    return u

def skonczony_u(t,x,t_f):
    time = np.linspace(t_f, t,500)
    A_ = A(x)
    Q_ = Q(x)
    Pdot =scipy.integrate.odeint(Ricca,[1,0,0,1],time,args=(A_,Q_))
    P_f = Pdot[499]
    return P_f

def Ricca(x,t,A,Q):
    P = np.reshape(x,(2,2))
    Pdot = P*A - P*B()* B().T * P + A.T * P + Q
    return np.array([Pdot[0,0], Pdot[0,1], Pdot[1,0], Pdot[1,1]])

def A(x):
    return np.matrix ([[0 , 1] , [m* g*l* np.sin(x[0]) /x[0] , -d/J ]])

def B():
    return np.matrix ([[0] ,[1/ J ]])

def Q(x):
    #return np.matrix ([[1 ,0] ,[0 ,1]])
    return np.matrix ([[x[0]**2 ,0] ,[0 , x [1]**2]])

def R():
    return np.matrix ([[1]])

t = np.linspace(0, 2.5, 500)
x0 = [np.pi*2,0]

y = scipy.integrate.odeint( model , x0 , t, tfirst = True , rtol =1e-10)
plt.figure()
plt.plot(t,y)