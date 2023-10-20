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
i = 1;

%Applying the formulas from slides
exponential = zeros(1,N);
exponential = -log(random_nums)./lambda_exp;

pareto = zeros(1,N);
pareto = m_p ./ ((random_nums).^(1/alpha_p));

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
plot(sort(erlang), [1:2500]/2500, '.');
grid
