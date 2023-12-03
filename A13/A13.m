% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 13

%%% First scenario - closed model

%Given service times in seconds
S=[10,20e-3,10e-3,3e-3];


%Rooting matrix
P = [0,1.0,0,0;
     0.1,0, 0.3,0.6;
     0,0.85,0,0.15;
     0,0.75,0.25,0];

    %Trick to make the matrix invertible
Pref= [zeros(4,1),P(:,2:4)];

%Terminals will be the reference station
l_ref = [1,0,0,0];
v_ref = l_ref * inv(eye(4)-Pref);
D = S.*v_ref;

fprintf("\n\nClosed system:");
fprintf("\nVisits to 4 stations: ");
disp(v_ref);
fprintf("Demand to 4 stations: ");
disp(D);

%%%%%%% Open system %%%%%%%
lambda_in = [0.3,0,0]; %Mapped the entry of jobs
lambda0 = sum(lambda_in);

%Given service times
S=[20e-3,10e-3,3e-3];

%Rooting matrix
P2=[0,0.3,0.6;
     0.8,0,0.15;
     0.75,0.25,0];

%Calculations
lambda = lambda_in / lambda0;
v2 = lambda * inv(eye(3) - P2);
X2 = lambda0 * v2;
D2 = S .* v2;

fprintf("\n\nOpen system:");
fprintf("\n Visits to 3 stations: ");
disp(v2);
fprintf("Demand to 3 stations: ");
disp(D2);
fprintf("Throughput of 3 stations: ");
disp(X2);
