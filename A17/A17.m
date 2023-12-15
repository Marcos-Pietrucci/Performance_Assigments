% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assignment 17

%Given values
lambdaA = 2/60;
lambdaB = 3/60;
lambdaC = 2.5/60;

   % S1a S1b S1c
S1 = [10, 4, 6];
   % S2a S2b S2c
S2 = [12, 3, 6];

%Utilization of Production
U1a = lambdaA * S1(1);
U1b = lambdaB * S1(2);
U1c = lambdaC * S1(3);
U1 = U1a + U1b + U1c;

%Utilization of packaging
U2a = lambdaA * S2(1);
U2b = lambdaB * S2(2);
U2c = lambdaC * S2(3);
U2 = U2a+U2b+U2c;

%Calculating number of jobs for each class

%class a
D1a = U1a/lambdaA;
R1a = D1a/(1-U1);
N1a = lambdaA*R1a;

D2a = U2a/lambdaA;
R2a = D2a/(1-U2);
N2a = lambdaA*R2a;

 %summing two stations
Na = N1a + N2a;

%Class b
D1b = U1b/lambdaB;
R1b = D1b/(1-U1);
N1b = lambdaB*R1b;

D2b = U2b/lambdaB;
R2b = D2b/(1-U2);
N2b = lambdaB*R2b;

%Summing up two stations
Nb = N1b + N2b;

%Class c
D1c = U1c/lambdaC;
R1c = D1c/(1-U1);
N1c = lambdaC*R1c;

D2c = U2c/lambdaC;
R2c = D2c/(1-U2);
N2c = lambdaC*R2c;

Nc = N1c+ N2c; %Summing up

%Response time per type of product
Xa = lambdaA;
Xb = lambdaB;
Xc = lambdaC;

%Calculating
Ra = Na/Xa;
Rb = Nb/Xb;
Rc = Nc/Xc;

%System response time
    %total throughput
X = lambdaA + lambdaB + lambdaC;

    %For each station
R1 = Xa/X*R1a + Xb/X*R1b + Xc/X*R1c;
R2 = Xa/X*R2a + Xb/X*R2b + Xc/X*R2c;
R = R1 + R2;

%Printing results:
fprintf("\n");
fprintf("\nUtilization of production station: %.4f", U1);
fprintf("\nUtilization of packaging station: %.4f", U2);
fprintf("\nAverage number of jobs per product: ");
fprintf("\nClass A: %.4f", Na);
fprintf("\nClass B: %.4f", Nb);
fprintf("\nClass C: %.4f", Nc);
fprintf("\nAverage system response time per product: ");
fprintf("\nClass A: %.4f", Ra);
fprintf("\nClass B: %.4f", Rb);
fprintf("\nClass C: %.4f", Rc);
fprintf("\nClass-independant average system response time: %.4f", R);
fprintf("\n");
