% Marcos Vinicius Firmino Pietrucci
% Assigment 2


%Reading the Trace_value
    %The code is the same for each scenario, we just have to select which file
fl = csvread('Trace1.csv');
%fl = csvread('Trace2.csv');
%fl = csvread('Trace3.csv');

inter_arr = fl(:,1);
serv_t = fl(:,2);

%%% Average response time %%%
    %Arrival time
i = 2;
A_t = zeros(1,2);
while i ~= (length(inter_arr) + 1)
    A_t(i) = A_t(i-1) + inter_arr(i-1);
    i = i + 1;
end

    %Completition time
i = 2;
res_t = zeros(1,2);
C_t = zeros(1,2);
while i ~= (length(A_t) + 1)
    C_t(i) = max(A_t(i), C_t(i-1)) + serv_t(i);

    %Response time at every instant
    res_t(i) = C_t(i) - A_t(i);

    i = i + 1;
end

    %Calculating:
avg_resp_time = mean(res_t);

%%%% Utilization %%%%
len = length(A_t);

M = [transpose(A_t), ones(len, 1); transpose(C_t), -ones(len,1)];
M = sortrows(M, 1);
M(:,3) = cumsum(M(:,2));

%Get the time slices
deltaT = M(2:end, 1) - M(1:end-1, 1);

%Sum all the times whenever there was at least 1 job at the system;
B = sum((M(1:end-1, 3) ~= 0) .* deltaT);
T = sum(inter_arr);
U = B/T; 

%%%% The frequency at which the system returns idle%%%%
    % Number of times system returns idle / Total time

% Get the number of times system was idle:
num_idle = sum(M(:,3) == 0);
freq_idle = num_idle/T;

%%%% Average idle time %%%%
    % Total idle time (T-B) / num_idle
avg_idle_time = (T-B)/num_idle;


%%%%%% PRESENTING RESULTS %%%%%%