close all; clear all; clc;

%% P-controller
subplot(2,1,1)
[t,x]=ode23(@ssmodel,[0,20],[0;0]);  % simulation with the model; declared:
                      % time of simulation [0,180] and initial state x=[0;0]
plot(t,x(:,1))  % output - plotting x1 (first column), because y=x1
xlabel('t'); ylabel('y(t)');


%% phase trajectory
subplot(2,1,2)
plot(x(:,1),x(:,2))  % x2=x1' as a function of x1  // phase trajectory of the output
xlabel('y'); ylabel('dy/dt');
e=x(end,1)-x(:,1);
figure;
subplot(2,1,1)
plot(t,e); xlabel('t'); ylabel('e(t)');
edot=-x(:,2);
subplot(2,1,2)
plot(e,edot) % e' as a function of e   // phase trajectory of the error
xlabel('e'); ylabel('de/dt');

function dx=ssmodel(t,x)
    w = 100;      % zadana
    e=w-x(1);   % error / uchyb
    % Regulator proporcjonalny
    kp=2; u=kp*e;
    % Obiekt regulacji G(s) = 4/(s(s+1))
    % Rownanie y'' + y' = 4u, zmienne stanu x1=y, x2=y'
    dx1 =  x(2);      	% first state equation
    dx2 = -x(2)+4*u;    % second state equation
    dx=[dx1;dx2];    	% vector x' (derivative)
end