%Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 11

%Given values
lambda_1 = 150 / 60;
serv_time=350/1000;
k=32;

%Utilization
rho=lambda_1*serv_time;
U = (rho - rho^(k+1))/(1-rho^(k+1));

%Calculating requested values
loss_p = (rho^k - rho^(k+1))/(1-rho^(k+1));
avg_number_of_jobs = (rho/(1-rho)) - ((k+1) * rho^(k+1))/(1-rho^(k+1));
drop_rate = lambda_1 * (rho^k - rho^(k+1))/(1-rho^(k+1));
avg_resp_time = serv_time * (1-(k+1) * rho^k + k * rho^(k+1))/((1-rho)*(1-rho^k));
avg_time_in_queue= rho * avg_number_of_jobs / lambda_1;


%Presenting values for the  M/M/1/K
frprintf("\n\nM/M/1/K Values: ");
fprintf("\nUtilization: %.4f", U);
fprintf("\nLoss probability: %.4f", loss_p);
fprintf("\nAverage number of jobs in the system: %.4f", avg_number_of_jobs);
fprintf("\nDrop rate: %.4f", drop_rate);
fprintf("\nAverage response time: %.4f", avg_resp_time);
fprintf("\nAverage time spent in the queue: %.4f", avg_time_in_queue);

%%%%%%%%%%%% M/M/2/K %%%%%%%%%%%%




