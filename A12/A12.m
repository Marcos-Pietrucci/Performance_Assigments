% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 12

%G/G/1 Queue given values
lambda = 10;
mu1 = 50;
mu2 = 5;
p1 = 0.8;
p2 = 1-p1;

%Average service time
D = p1/mu1 + p2/mu2;
moment2 = 2*(p1/mu1^2 + p2/mu2^2);
rho = lambda*D; %That is the utilization

%According to formulas
R = D + (lambda*moment2)/(2*(1-rho));
N = R*lambda;

fprintf("\n\n M/G/1");
fprintf("\nUtilization of system: %.4f", rho);
fprintf("\nAverage response time: %.4f", R);
fprintf("\nAverage number of jobs in system: %.4f", N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G/G/3 system

