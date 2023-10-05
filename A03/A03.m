% Marcos Vinicius Firmino Pietrucci
% Assigment 3

%Reading the Traces
DataSet = csvread('Trace3.csv');
%DataSet = csvread('Trace2.csv');
%DataSet = csvread('Trace3.csv');

%Creating the DataSet
DataSet = sort(DataSet);
N = length(DataSet);

%Calculating the moments
Mean = sum(DataSet)/N;
Moment2 = sum(DataSet .^2)/N;
Moment3 = sum(DataSet .^3)/N;
Moment4 = sum(DataSet .^4)/N;

%Calculating the centralized moments
Var = sum((DataSet-Mean) .^2) / N;
CentMomt3 = sum((DataSet-Mean) .^3) / N;
CentMomt4 = sum((DataSet-Mean) .^4) / N;

Standard_Dev = sqrt(Var);

%Skewness is the third standardized moment
Skew = sum(((DataSet-Mean)./Standard_Dev).^3)/N;
SMom4 = sum(((DataSet-Mean)./Standard_Dev).^4)/N;

Coef_Var = Standard_Dev/Mean;

Exc_Kurt = SMom4 - 3;


