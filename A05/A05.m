% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 5

%%% Generate 10000 random numbers using Lin. Cong. Gen.
N = 10000;
m = 2^32; %Given values
a = 1664525;
c = 1013904223;
seed = 521191478;
random_nums = zeros(1, 10000);

%First random value
x = mod(a*seed + c, m);
random_nums(1) = x;
i = 2;
while i <= N
    random_nums(i) = mod(a*random_nums(i-1) + c, m);
    i = i + 1;
end
random_nums = random_nums/m;

%%% Generating distributions with random values %%%%%
range = [1:N]/N;
lambda_exp = 0.1;
alpha_p = 1.5;
m_p = 5;
k_erl = 4;
lambda_erl = 0.4;
hypo_l1 = 0.5;
hypo_l2 = 0.125;
hyper_l1 = 0.5;
hyper_l2 = 0.05;
hyper_p = 0.55;

%Exponential
exponential = zeros(1,N);
t = [1:2000] / 20;
exponential = -log(random_nums)./lambda_exp;
figure(1)
plot(sort(exponential),[1:10000]/10000, ".", t, Exp_cdf(t, [lambda_exp]),"-")
title("Exponential");
grid

%Pareto
pareto = zeros(1,N);
pareto = m_p ./ ((random_nums).^(1/alpha_p));

%Erlang
erlang = zeros(1,N/k_erl);
aux = zeros(1,N/k_erl);
value = 1;
i = 1;
while i <= N/k_erl
    aux(1:4,i) = random_nums(((i-1)*4+1):((i-1)*4+1) + 3);
    i = i+1;
end
erlang = -log(prod(aux)) ./ lambda_erl;
figure(3);
plot(sort(erlang), [1:2500]/2500, '.', t, gamcdf(t, k_erl, 1/lambda_erl), '-');
title("Erlang");
grid

%HypoExponential
hypoExp = zeros(1, N/2);
exponential_aux = -log(random_nums);
i = 1;
index_aux = 1;
while i <= N
    hypoExp (index_aux) = exponential_aux(i)/hypo_l1 + exponential_aux(i+1)/hypo_l2;
    i = i + 2;
    index_aux = index_aux + 1;
end
figure(4);
plot(sort(hypoExp), [1:5000]/5000, '.', ...
    t, HypoExp_cdf(t, [hypo_l1, hypo_l2]), '-');
title("HypoExp");
grid

%HyperExponential
hyperExp = zeros(1, N/2);
prob = hyper_p;
lambda = [hyper_l1,hyper_l2, hyper_p];

for i=1:(N/2)
    if random_nums(i) <= prob
        hyperExp(i) = - log(random_nums(5000+i))/lambda(1);
    else
        hyperExp(i) = - log(random_nums(5000+i))/lambda(2);
    end
end

figure(5);
plot(sort(hyperExp), [1:5000]/5000, '.', ...
    t, HyperExp_cdf(t, [lambda]), '-');
title("HyperExp");
grid


