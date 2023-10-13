% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 4

%Reading the Traces
DataSet = csvread('Trace1.csv');
% DataSet = csvread('Trace2.csv');
% DataSet = csvread('Trace3.csv');

%Creating the DataSet
sDataSet = sort(DataSet);
N = length(sDataSet);

%Calculating the moments
Mean = sum(DataSet)/N;
Moment2 = sum(DataSet .^2)/N;
Moment3 = sum(DataSet .^3)/N;

%Fitting the Exponential
