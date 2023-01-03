import numpy as np 
import scipy 
from matplotlib import pyplot as plt
import signal 

def zad1():
    
    def model(x,t):
        u = 1
        dx1 = x[0] *np.log(x[1])
        dx2 = -x[1] * np.log(x[0]) + x[1] * u
        return [dx1, dx2]
    
    x0 = [1, 1]
    t = np.linspace(0, 50,num=500)
    y = scipy.integrate.odeint(model,x0, t)
    
    plt.figure()
    plt.plot(t,y)
    plt.title('1')
    
    
    def model_2(x,t):
        u =1 
        dx1 = 1/x[0] * x[0] * np.log(x[1])
        dx2 = -np.log(x[0]) + 1
        return [dx1,dx2]
    
    y = scipy.integrate.odeint(model,[1,1], t)
    
    plt.figure()
    plt.plot(t,y)
    plt.title('2')
    
    # odpowiedzi obu układów, nie róźnią się od siebie
    
    # 2.4, 2.5, 2.3
    
    
def zad5():
    J = 1
    g = 10
    d = 0.5
    m = 9
    R = 1
    
    def model(x,t,u):
        
        dx1= x[1]
        dx2 = 1/J * u - d/J * x[1] - (m*g)/J * R * np.sin(x[0])
        return [dx1, dx2]
    
    def model_liniowy(x,t,u):
        A = np.ndarray([[0,1][-(m*g*R)/J, -d/J]])
        B = np.ndarray([[0],[1/J]])
        dx = A * x + B * u
        return dx
    
    t = np.linspace(0,20,500)
    plt.figure()
    y = scipy.integrate.odeint(model,[0,0],t,args=(5,))
    plt.plot(t,y[:,1], label='U =0')
    y = scipy.integrate.odeint(model_liniowy,[0,0],t,args=(2,))
    plt.plot(t,y[:,1], label='U =0')
    
    # y = scipy.integrate.odeint(model,[0,0],t,args=(5,))
    # plt.plot(t,y[:,1], label='U =5')
    
    # y = scipy.integrate.odeint(model,[0,0],t,args=(20,))
    # plt.plot(t,y[:,1], label='U =20')
    
    # y = scipy.integrate.odeint(model,[0,0],t,args=(45*np.sqrt(2),))
    # plt.plot(t,y[:,1], label='U =45')
    
    # y = scipy.integrate.odeint(model,[0,0],t,args=(70,))
    # plt.plot(t,y[:,1], label='U =70')
    
    plt.legend()
    
    def linearyzacja(x,t):
        pass
        
zad5()












































