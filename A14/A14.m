% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 14

%Throughput
lambdaIn = [3,2,0,0];
X = sum(lambdaIn);

%Given service times
S = [2,3e-2,1e-1,8e-2];

%Rooting matrix
P = [0,0.8,0,0; 
     0,0,0.3,0.5;
     0,1,0,0;
     0,1,0,0];

%Calculations with server 2 as reference
l2 = lambdaIn / X;
v2 = l2 * inv(eye(4) - P);
D_arr = S .* v2; %Calculate the demands for each server

U2 = X*D_arr(2);
U3 = X*D_arr(3);
U4 = X*D_arr(4);
R1 = D_arr(1); %In server 2 R = D
R2 = D_arr(2)/(1-U2);
R3 = D_arr(3)/(1-U3);
R4 = D_arr(4)/(1-U4);

%As given in slides, the sum of response times
R = R1 + R2 + R3 + R4;
N = X * R;

%Displaying results
fprintf("\nThe throughput of the system: %.4f", X);
fprintf("\nThe average number of jobs in the system: %.4f", N);
fprintf("\nThe average system response time: %.4f\n\n", R);
