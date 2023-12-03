% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 10

%%%%%% M/M/1 system %%%%%
%Given values
lambda = 40; 
%Average service time
D = 16e-3;
U = lambda *D;

%%% M/M/1 %%%
%Service rate
mu = 1/D;
rho = lambda/mu;

R = D/(1-rho); %Average response time

prob_1_job = (1-rho)*rho^1;

%Sum up all probabilities from 0 to 9
prob_less_10_job = sum((1-rho) .* (rho .^[0:9]));

%Average queue time
queue_len = rho^2 /(1-rho);

%Probability response time is less than 0.5s
prob_resp_less_05 = exp(-0.5/R);

%90 percentile
percentile_90 = -log(1- 0.9) * R;

fprintf("\nM/M/1 System:");
fprintf("\nUtilization: %.4f", U);
fprintf("\nProbability of having exactly 1 job: %.4f", prob_1_job);
fprintf("\nProbability of having less then 10 jobs: %.4f", prob_less_10_job);
fprintf("\nAverage queue length: %.4f", queue_len);
fprintf("\nAverage Response time: %.4f", R);
fprintf("\nProbability response time is grater then 0.5s: %e", prob_resp_less_05);
fprintf("\n90 percentile of the response time distribution: %.4f", percentile_90);

%%%%%% M/M/2 system %%%%%
lambda = 90; 
D = 16e-3; %Average service time
c = 2; %Number of servers
mu = 1/D; %Service rate
rho = lambda/mu;

%Utilizations
U = lambda*D;
avg_U = U/2;
rho = avg_U;

R = D/(1-rho^2);

%Probabilities of having X jobs
prob_0_job = (1-rho)/(1+rho);
prob_1_job = 2*prob_0_job*rho^1;

%Sum up all probabilities from 0 to 9
prob_less_10_job = prob_0_job + sum(2*prob_0_job*rho.^[1:9]);

queue_len = lambda * (R-D);

fprintf("\n\nM/M/2 System:");
fprintf("\nTotal utilization: %.4f", U);
fprintf("\nAverage utilization: %.4f", avg_U);
fprintf("\nProbability of having exactly 1 job: %.4f", prob_1_job);
fprintf("\nProbability of having less then 10 jobs: %.4f", prob_less_10_job);
fprintf("\nAverage queue length: %.4f", queue_len);
fprintf("\nAverage Response time: %.4f\n\n", R);