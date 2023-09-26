% Marcos Vinicius Firmino Pietrucci
% Assigment 2


%Reading the Trace_value
fl1 = csvread('Trace1.csv');
inter_arr = fl1(:,1);
serv_t = fl1(:,2);

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

%%%%

% Utilization


