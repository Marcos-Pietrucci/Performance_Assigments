% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 9

%Defining the exponential rates in minutes
tscan = 2;
tnigh = 18;  
tsun = 3;
tcloudy = 8;  %Related to Down states

%Defining the weather probability
prob_night = 0.5;
prob_sun = 0.3333;
prob_cloud = 0.1637;

%Generating the states vectors
%The order: SCAN-NIGHT-SUNNY-CLOUDY
SCAN = [0, tscan*prob_night, tscan*prob_sun, tscan*prob_cloud];
q1 = -sum(SCAN(2:4));
SCAN(1) = q1;

NIGHT = [tnigh, -tnigh, 0, 0];
SUNNY = [tsun, 0,-tsun, 0];
CLOUD = [tcloudy, 0, 0, -tcloudy];


%Creating the infentesimal generator
Q = [SCAN;NIGHT;SUNNY;CLOUD];
