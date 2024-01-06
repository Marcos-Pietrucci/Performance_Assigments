% Marcos Vinicius Firmino Pietrucci
% 10914211

%Reading the trace
DataSet = csvread('./Traces/TraceB-HE.txt');

%Creating the DataSet
sDataSet = sort(DataSet);
N = length(sDataSet);
t = [0:10]; %for intervals

%Calculating the moments
Mean = sum(sDataSet)/N;
Moment2 = sum(sDataSet .^2)/N;
Moment3 = sum(sDataSet .^3)/N;
coef_var = std(sDataSet)/Mean;

%Fitting the uniform using direct expressions
left_boundary = Mean - sqrt(12*(Moment2 - Mean^2))/2;
right_boundary = Mean + sqrt(12*(Moment2 - Mean^2))/2;

%Fitting the Exponential using direct expressions
exp_lambda = 1/Mean;

%Fitting the Erlang distribution
k_erlang = round(1/coef_var^2);
lambda_erlang = k_erlang/Mean;

%%%%% Applying method of moments %%%%%

%Weibull
weibull_equations = @(x) [x(1)*gamma(1 + 1/x(2))-Mean,x(1)^2 * gamma(1+2/x(2))-Moment2]; 
results = fsolve(weibull_equations, [1,1], options);
weib_scale = results(1);
weib_shape = results(2);

%Pareto
syms alpha m
eq3 = Mean == (alpha * m) / (alpha - 1); %Equations from slides
eq4 = Moment2 == (alpha * m^2)/(alpha-2);
pareto_params = solve([eq3, eq4], [alpha, m]);
alpha_pareto = double(pareto_params.alpha(1));
m_pareto = double(pareto_params.m(1));

%Hypo-Exponential using MLE method
lambda1_hypo = 1/(0.3*Mean);
lambda2_hypo = 1/(0.7*Mean);
hypo_parameters = mle(sDataSet, 'pdf', @(DataSet, lambda1_hypo, lambda2_hypo) ...
    HypoExp_pdf(DataSet,[lambda1_hypo, lambda2_hypo]), ...
  'Start', [lambda1_hypo,lambda2_hypo]);

%Hyper_Exponential using MLE method
p1 = 0.4;
lambda1_hyper = 0.8/Mean;
lambda2_hyper = 1.2/Mean;
hyper_parameters = mle(sDataSet, 'pdf', @(DataSet, lambda1_hyper, lambda2_hyper, p1) ...
    HyperExp_pdf(DataSet,[lambda1_hyper, lambda2_hyper, p1]), ...
    'Start', [lambda1_hyper,lambda2_hyper, p1]);

%%%%%%%%%%%%%%% PLOTING RESULTS %%%%%%%%%%%%%%%

%Checking fro the existance of hypo exponential
if coef_var < 1 %Only available if the Cv is less than 1
    figure(1)
    plot(sDataSet, [1:N]/N, ".", t, Unif_cdf(t, [left_boundary, right_boundary]), ...
        t, Exp_cdf(t, [exp_lambda]), ...
        t, gamcdf(t, k_erlang, 1/lambda_erlang), ...
        t, Weibull_cdf(t, [weib_scale, weib_shape]), ...
        t, HypoExp_cdf(t, [hypo_parameters]), ...
        t, Pareto_cdf(t, [alpha_pareto, m_pareto]))
    legend({'DataSet','Uniform', 'Exponential','Erlang', 'Weibull', 'HypoExponential', 'Pareto'},'Location','southeast')
    title('Fitting LE execution times');
    grid
end

%Checking for existance of HyperExponential
if coef_var > 1 %Only available if the Cv is less than 1
    figure(1)
    %ERLANG NOT AVAILABLE since lambda is 0
    plot(sDataSet, [1:N]/N, ".", t, Unif_cdf(t, [left_boundary, right_boundary]), ...
        t, Exp_cdf(t, [exp_lambda]), ...
        t, Weibull_cdf(t, [weib_scale, weib_shape]), ...
        t, HyperExp_cdf(t, [hyper_parameters]), ...
        t, Pareto_cdf(t, [alpha_pareto, m_pareto]))
        
    legend({'DataSet','Uniform', 'Exponential','Weibull', 'HyperExponential', 'Pareto'},'Location','southeast')
    title('Fitting LE execution times');
    grid
end

fprintf("\n Results:");
fprintf("\nMean: %.5f", Mean);
fprintf("\nMoment2: %.5f", Moment2);
fprintf("\nMoment3: %.5f", Moment3);
fprintf("\nLeft-bound(a): %.5f", left_boundary);
fprintf("\nRight-bound(a): %.5f", right_boundary);
fprintf("\nExponential rate (lambda): %.5f", exp_lambda);
fprintf("\nErlang k: %.5f", k_erlang);
fprintf("\nErlang lambda: %.5f", lambda_erlang);
fprintf("\nWeibull shape k: %.5f", weib_shape);
fprintf("\nWeibull scale lambda: %.5f", weib_scale);
fprintf("\nPareto shape alpha: %.5f", alpha_pareto);
fprintf("\nPareto scale m: %.5f", m_pareto);
fprintf("\nHyper-Exponential parameters: %.5f %.5f %.5f", hyper_parameters(1), hyper_parameters(2), hyper_parameters(3));
fprintf("\nHypo-Exponential parameters: %.5f %.5f", hypo_parameters(1), hypo_parameters(2));
fprintf("\n");

function F = Weibull_cdf(x, p)
    lambda  = p(1);
	k = p(2);
	i = 1;

    while i ~= length(x)  + 1
	    F(i) = 1 - exp(-x(1)/lambda)^k;
        i = i+1;
    end
end

function F = Pareto_cdf(x, p)
	alpha = p(1); %alpha value (shape)
	m = p(2); %m value (scale)
    
    i = 1;
    while i ~= length(x)  + 1
        if(x(i) >= m)
	        F(i) = 1 - (m/x(i))^alpha;
        else
            F(i) = 0;
        end
        i = i+1;
    end
end
