% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 15

%Given values
Ntot = 80;

% S(1) is think time
Z = 40;
S = [0, 50e-3, 2e-3, 80e-3, 80e-3, 120e-3]; %in seconds
    
    %1   2   3   4   5   6
P = [0  ,1  ,0  ,0  ,0  ,0  ;
     0.1,0  ,0.4,0.5,0  ,0  ;
     0  ,0  ,0  ,0  ,0.6,0.4;
     0  ,1  ,0  ,0  ,0  ,0  ;
     0  ,1  ,0  ,0  ,0  ,0  ;
     0  ,1  ,0  ,0  ,0  ,0  ];

%Calculate the Demands
    %Trick to make the matrix invertible
Pref= [zeros(6,1), P(:,2:6)];

%Terminals will be the reference station
l_ref = [1,0,0,0,0,0];
v_ref = l_ref * inv(eye(6)-Pref);
Dk = S .* v_ref;

%Calculate using the Mean Value Analysis
Nk = [0,0,0,0,0,0]; %Initially no jobs in the system
Rk = [Dk(1,1), Dk(1,2)*(Nk(1,2)+1), Dk(1,3)*(Nk(1,3)+1), Dk(1,4)*(Nk(1,4)+1),...
      Dk(1,5)*(Nk(1,5)+1), Dk(1,6)*(Nk(1,6)+1)];
R = sum(Rk);
X = 1 / (R+Z);

for ni = 2:Ntot
    Nk = X * Rk;
    Rk = [Dk(1,1), Dk(1,2)*(Nk(1,2)+1),Dk(1,3)*(Nk(1,3)+1),...
          Dk(1,4)*(Nk(1,4)+1),Dk(1,5)*(Nk(1,5)+1), Dk(1,6)*(Nk(1,6)+1)];
    R = sum(Rk);
    X = ni / (R+Z);
end

%At this point we have the response time and throughput
Uk = Dk * X; %Utilization at each station

%Displaying results
fprintf("\n\nThroughput of the system: %.4f", X);
fprintf("\nThe average system response time: %.4f", R);
fprintf("\nThe utilization of Application server: %.4f", Uk(2));
fprintf("\nThe utilization of DBMS: %.4f", Uk(4));
fprintf("\nThe utilization of Disk 1: %.4f", Uk(5));
fprintf("\nThe utilization of Disk 2: %.4f", Uk(6));
fprintf("\n\n");

