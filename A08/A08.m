% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 8

%Defining the exponential rates
lb1 = 0.33;
lb2 = 0.6;
lb3 = 0.4;
lb4 = 1.0;  
lb5 = 0.05;
lbd = 6.0;  %Related to Down states

%Defining the recovery probability from Down State
p1=0.6;
p2=0.3;
p3=0.1;

%Generating the states vectors
LOW = [-lb1-lb5,lb1, 0, lb5];
MED = [lb2, -lb2-lb3-lb5, lb3, lb5];
HIGH = [0, lb4,-lb4-lb5, lb5];

qdd=p1*lbd+p2*lbd+p3*lbd;
DOWN = [p1*lbd, p2*lbd, p3*lbd, -(qdd)];

%Creating the infentesimal generator
Q = [LOW;MED;HIGH;DOWN];

%Computing the solution
s=sum(Q');
%s(abs(s) < tolerance) = 0;
p_MED = [0, 1, 0, 0];
p_DWN = [0, 0, 0, 1];
T = [0 8];

% Display the infinitesimal generator
disp('Infinitesimal Generator:');
disp(Q);
[t, Sol] = ode45(@(t,x) Q'*x,T, p_MED');
figure;
plot(t, Sol, "-");
title("Starting point Medium")

[t, Sol] = ode45(@(t,x) Q'*x, T, p_DWN');
figure;
plot(t, Sol, "-");
title("Starting point DOWN")
