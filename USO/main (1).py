import numpy as np
import matplotlib .pyplot as plt
import scipy.integrate
import scipy.optimize as optimize
from scipy.optimize import minimize


def zadanie2_1():
    a = np.array([2, -1, -4])
    b = np.array([-4, 3, -2])
    y1 = []
    y2 = []
    y3 = []
    x = np.arange(-5, 5)

    for i in x:
        y1.append(a[0]*i +b[0])
        y2.append(a[1]*i +b[1])
        y3.append(a[2]*i +b[2])

    plt.plot(x,y1)
    plt.plot(x,y2)
    plt.plot(x,y3)
    plt.show()


def funkcja(x):
    f = x ** 2 - 2 * x
    return f


def zadanie3():
    x = np.arange(0,100)
    y = x**4 -4*x**3 -2*x**2 +12*x +9
    min = y[0]
    max = y[0]
    i=0
    for iterator in y:
        if min >= y[i]:
            min = y[i]
        if max <= y[i]:
            max = y[i]

        i+=1

    plt.plot(x, y)
    plt.show()
    return min, max


def zadanie3_1(x):
    y = x**4 -4*x**3 -2*x**2 +12*x +9
    return y


# def model(y, t, a):
#     x, xprim = y
#     x = a[0] + a[1]*t + a[2]*t**2 + a[3]*t**3
#     return x


def model(y, t, a):
    x, xprim = y
    dydt =[xprim, a[0] + a[1]*t + a[2]*t**2 + a[3]*t**3]
    return dydt


def test(y,t):
    x, xprim = y
    dydt = [xprim, x *12 -2]
    return dydt


def modelPrim(x, t, a):
    xPrim = a[1] + 2 * a[2] * t + 3 * a[3] * t ** 2
    return xPrim


def pend(y, t, b, c):
    theta, omega = y
    dydt = [omega, -b*omega - c*np.sin(theta)]
    return dydt


def problem(a):
    t=0
    y0 =0
    y = scipy.integrate.odeint(model,y0,t,a)
#obiekt(model)
#return


if __name__ == '__main__':
    zadanie2_1()
    print(zadanie3())
    rozw = minimize(funkcja,1)
    rozw2 = minimize(zadanie3_1, 4, bounds=[(0, np.inf)])
    func = lambda x: x**4 -4*x**3 -2*x**2 +12*x +9
    ret = optimize.dual_annealing(func, bounds=[(0, 100)])
    print(f'zad 3:\noptimize.minimize result {rozw2.x} \noptimize.dual_annealing result {ret.x}')

    # y0 = [0 , 3]
    # t = np.linspace(0, 10, 100)
    # sol =scipy.integrate.odeint(test, y0, t)
    # plt.plot(t, sol[:, 0], 'b', label='x')
    # plt.plot(t, sol[:, 1], 'g', label='xprim')
    # plt.legend(loc='best')
    # plt.xlabel('t')
    # plt.grid()
    # plt.show()