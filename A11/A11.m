%Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 11

%Given values
lambda_1 = 150 / 60;
serv_time = 350/1000;
k=32;

%Utilization
rho=lambda_1*serv_time;
U = (rho - rho^(k+1))/(1-rho^(k+1));

%Calculating requested values
loss_p = (rho^k - rho^(k+1))/(1-rho^(k+1));
avg_number_of_jobs = (rho/(1-rho)) - ((k+1) * rho^(k+1))/(1-rho^(k+1));
drop_rate = lambda_1 * (rho^k - rho^(k+1))/(1-rho^(k+1));
avg_resp_time = serv_time * (1-(k+1) * rho^k + k * rho^(k+1))/((1-rho)*(1-rho^k));
avg_time_in_queue = rho * (avg_number_of_jobs/lambda_1);

%Presenting values for the  M/M/1/K
fprintf("\n\nM/M/1/K Values: ");
fprintf("\nUtilization: %.4f", U);
fprintf("\nLoss probability: %.4f", loss_p);
fprintf("\nAverage number of jobs in the system: %.4f", avg_number_of_jobs);
fprintf("\nDrop rate: %.4f", drop_rate);
fprintf("\nAverage response time: %.4f", avg_resp_time);
fprintf("\nAverage time spent in the queue: %.4f", avg_time_in_queue);

%%%%%%%%%%%% M/M/2/K %%%%%%%%%%%%

%Given values
lambda_2 = 250/60;
c = 2;

%Utilizations
rho = lambda_2 * serv_time/c;
U_tot = rho;
avg_U = U_tot/2;

%Calculation the probability of 0 jobs in the system
p0 = 1/((((2*rho)^2)/factorial(2))*((1-(rho^(k-1)))/(1-rho))+1+2*rho);
pk = p0*((c^c)/factorial(c)) * (rho^k);
pn = [p0,(p0*rho*2),((p0*2*rho .^ (2:k)))];
avg_number_of_jobs = sum(pn .* [0:k]); %Then the average

drop_rate = lambda_2 * pk;
avg_resp_time = avg_number_of_jobs / (lambda_2*(1-pk));
avg_time_in_queue = avg_resp_time - serv_time;

fprintf("\n\nM/M/2/K Values: ");
fprintf("\nTotal Utilization: %.4f", U_tot);
fprintf("\nAverage Utilization: %.4f", avg_U);
fprintf("\nLoss probability: %e", pk);
fprintf("\nAverage number of jobs in the system: %.4f", avg_number_of_jobs);
fprintf("\nDrop rate: %e", drop_rate);
fprintf("\nAverage response time: %.4f", avg_resp_time);
fprintf("\nAverage time spent in the queue: %.4f", avg_time_in_queue);
fprintf("\n\n");
