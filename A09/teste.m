clc
clear

Q = [-1/18, 0, 0, 1/18;
    0, -1/3, 0, 1/3;
    0, 0, -1/8, 1/8;
    1/2/1/2, 1/2/1/3, 1/2/1/6,-0.5 ];

Qp=[ones(4,1),Q(:,2:4)];

pi=[1,0,0,0]*inv(Qp);
alp=[0.1,0.1,0.1,12];
avrg=pi*alp';


pi0u=[0,0,0,1];
T_reward = [0, 0, 0, 1;
            0, 0, 0, 1; 
            0, 0, 0, 1;
            0,0,0,0];

Utilization = pi * pi0u';

Throughput = sum(sum((T_reward .* Q)'.* pi)) * 24*60;

disp(avrg);
disp(Utilization);
disp(Throughput);


% ploting CTMC
Q1= [
    0, 0, 0, 1/18;
    0, 0, 0, 1/3;
    0, 0, 0, 1/8;
    1/2/1/2, 1/2/1/3, 1/2/1/6, 0
];

states = { 'SleepingNight','SleepingSolarDay','SleepingCloudyDay','Scanning'};
G = digraph(Q1, states);
nodeColor = 'r';
edgeColor = 'g';
figure;
plot(G, 'NodeColor', nodeColor, 'EdgeColor', edgeColor, 'EdgeLabel', cellstr(num2str(G.Edges.Weight, '%0.2f')));
title('CTMC graph');