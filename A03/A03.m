% Marcos Vinicius Firmino Pietrucci
% Assigment 3

%Reading the Traces
DataSet = csvread('Trace1.csv');
% DataSet = csvread('Trace2.csv');
% DataSet = csvread('Trace3.csv');

%Creating the DataSet
sDataSet = sort(DataSet);
N = length(sDataSet);

%Calculating the moments
Mean = sum(sDataSet)/N;
Moment2 = sum(sDataSet .^2)/N;
Moment3 = sum(sDataSet .^3)/N;
Moment4 = sum(sDataSet .^4)/N;

%Calculating the centralized moments
Var = sum((sDataSet-Mean) .^2) / N;
CentMomt3 = sum((sDataSet-Mean) .^3) / N;
CentMomt4 = sum((sDataSet-Mean) .^4) / N;

%Standard Deviation
Standard_Dev = sqrt(Var);

%Skewness is the third standardized moment
Skew = sum(((sDataSet-Mean)./Standard_Dev).^3)/N;
SMom4 = sum(((sDataSet-Mean)./Standard_Dev).^4)/N;

%Coefficient of Variation
Coef_Var = Standard_Dev/Mean;

%Excess Kurtosis
Exc_Kurt = SMom4 - 3;

%The median, first and third quartile
h25 = (N-1)*0.25 + 1;
ih25 = floor(h25);
first_quartile = sDataSet(ih25) + (sDataSet(ih25+1) - sDataSet(ih25))*(h25-ih25);

h50 = (N-1)*0.5 + 1;
ih50 = floor(h50);
median = sDataSet(ih50) + (sDataSet(ih50+1) - sDataSet(ih50))*(h50-ih50);

h75 = (N-1)*0.75 + 1;
ih75 = floor(h75);
third_quartile = sDataSet(ih75) + (sDataSet(ih75+1) - sDataSet(ih75))*(h75-ih75);

%Plotting Pearson Correlation Coefficient
m_inf = 1;
m_sup = 100;
m = m_inf;

while m ~= m_sup +1
    pearson_coef(m) = (sum((DataSet(1:end-m) - Mean) .* (DataSet(1+m:end)-Mean)) / (N-m)) / Var;
    m = m + 1;
end

figure(1)
plot([m_inf:m_sup], [pearson_coef],['-','r'])
title('Pearson Correlation coefficient of Trace1');
xlabel('Lag');
ylabel('Pearson C. C.');
grid

%Plotting the CDF
figure(2)
plot(sDataSet, [1:N]/N, ['-','r']);
title('Pearson Correlation coefficient of Trace1');
xlabel('Values');
ylabel('Probability');

grid

%%%%%%%%%%%% Presenting %%%%%%%%%%%%
fprintf("\n----Trace 1 ----\n");
fprintf("\nMean: %.3f", Mean);
fprintf("\nSecond Moment: %.3f", Moment2);
fprintf("\nThird Moment: %.3f", Moment3);
fprintf("\nFourth Moment: %.3f", Moment4);
fprintf("\nVariance: %.3f", Var);
fprintf("\nThird Centered moment: %.3f", CentMomt3);
fprintf("\nFourth Centered moment: %.3f", CentMomt4);
fprintf("\nSkewness: %.3f",Skew);
fprintf("\nFourth Standardized Moment: %.3f",SMom4);
fprintf("\nStandard Deviation: %.3f",Standard_Dev);
fprintf("\nCoefficient of Variation: %.3f",Coef_Var);
fprintf("\nExcess of Kurtosis: %.3f",Exc_Kurt);
fprintf("\nMedian: %.3f",median);
fprintf("\nFirst Quartile: %.3f",first_quartile);
fprintf("\nThird Quartile: %.3f",third_quartile);
fprintf("\n");
