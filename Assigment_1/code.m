% Assigment 1

%Reading values
raw_file = importdata('barrier.log');
dim = length(raw_file);

index_A = 1;
index_C = 1;
current_line = 1;

    %Initializing
A = datetime(0,0,0);
C = datetime(0,0,0);
while current_line ~= dim+1
    
    %Extract date_time information from raw file
    date_extract = sscanf(string(raw_file(current_line)),'[%4d:%3d:%2d:%2d:%2d:%1d]\n');
    date_extract = transpose(date_extract);
    date_extract = datetime(strjoin(string(date_extract)), 'InputFormat', 'uuuu DDD HH mm ss S');
    
    %Determine if it is an Output of Input
    in_out = sscanf(string(raw_file(current_line)),'[%d:%d:%d:%d:%d:%d][%4s]\n');
    in_out = in_out(8);
    
    %Do the test, if IN or OUT
    if in_out == 73 %ASCII for I --> Means input
        A(index_A) = date_extract;
        index_A = index_A + 1;
    else            %If not --> Means output
        C(index_C) = date_extract;
        index_C = index_C + 1;
    end

    current_line = current_line + 1;
end
nA = length(A);
nC = length(C);

% Arrival rate and throughput
    %Both should be equal as number of arrivals == number of completitions
T = seconds(C(end) - A(1));
lambda = nA/T;
throughput = lambda;

% Average inter-arrival time
a_i = 1/lambda;

% Utilization
    %I am going to transform everything in seconds
i = 1;
seconds_A = zeros(1, nA);
seconds_C = zeros(1, nC);
while i ~= length(A) + 1
    %Getting absolute second difference instead of timestamp
    seconds_A(i) = seconds(A(i) - A(1));
    seconds_C(i) = seconds(C(i) - A(1));
    i = i +1;
end
seconds_A = transpose(seconds_A);
seconds_C = transpose(seconds_C);

    %Creating the "trick" matrix
M = [seconds_A, ones(nA, 1); seconds_C, -ones(nC,1)];
M = sortrows(M, 1);
M(:,3) = cumsum(M(:,2));

%Get the time slices
deltaT = M(2:end, 1) - M(1:end-1, 1);

%Sum all the times whenever there was at least 1 job at the system;
B = sum((M(1:end-1, 3) ~= 0) .* deltaT);
U = B/T; %Find the utilization

% Average Service Time
S = B/nC;

% Average Response Time
res = seconds_C - seconds_A;
avg_res = mean(res);

% Average Number of Jobs
W = sum(res);
N = W/T;

% Probability of having m parts in the machine (with m = 0, 1, 2)
    %m = 0
time_0_parts = sum((M(1:end-1, 3) == 0) .* deltaT);
prob_0_parts = time_0_parts/T;

    %m = 1
time_1_parts = sum((M(1:end-1, 3)  == 1) .* deltaT);
prob_1_parts = time_1_parts/T;

    %m = 2
time_2_parts = sum((M(1:end-1, 3)  == 2) .* deltaT);
prob_2_parts = time_2_parts/T;

% Probability of having a response time less than r, (with r = 30 sec, 3 min)
    %r < 30s
prob_res_under_30 = sum(res<30)/length(res);

    %r < 3 min
prob_res_under_180 = sum(res<180)/length(res);

% Probability of having an inter-arrival time shorter than r, (with r = 1 min)
i = 1;
while i ~= nA
    inter_arrival(i) = seconds_A(i+1) - seconds_A(i);
    i = i + 1;
end

prob_inter_under_60 = sum(inter_arrival < 60)/length(inter_arrival);

% Probability of having a service time longer than r, (with r = 1 min)
i = 2;
while i ~= nC + 1
    %Slide's formula
    Service(i) = seconds_C(i) - max(seconds_A(i), seconds_C(i-1));
    i = i + 1;
end

prob_serv_over_60 = sum(Service > 60)/length(Service);

%%%%%%%%%%%%%%%%% Presenting values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("\n")
fprintf("Arrival rate: %.5f job/s\nThroughput: %.5f job/s", lambda, throughput);
fprintf("\nAverage inter-arrival time: %.5f", a_i);
fprintf("\nUtilization: %.5f", U);
fprintf("\nAverage service time: %.5f", S);
fprintf("\nAverage number of jobs: %.5f", N);
fprintf("\nAverage response time: %.5f", mean(res));
fprintf("\nProbability of having 0 parts in the machine: %.5f", prob_0_parts);
fprintf("\nProbability of having 1 parts in the machine: %.5f", prob_1_parts);
fprintf("\nProbability of having 2 parts in the machine: %.5f", prob_2_parts);
fprintf("\nProbability of having a response time less than 30s: %.5f", prob_res_under_30);
fprintf("\nProbability of having a response time less than 3min: %.5f", prob_res_under_180);
fprintf("\nProbability of having an inter-arrival time shorter than 1min: %.5f", prob_inter_under_60);
fprintf("\nProbability of having a service time longer than 1min: %.5f", prob_serv_over_60);
fprintf("\n");