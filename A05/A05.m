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
i = 1;

%Applying the formulas from slides
exponential = zeros(1,N);
exponential = -log(random_nums)./lambda_exp;
plot(sort(exponential), range, '.');

pareto = zeros(1,N);
pareto = m_p ./ ((random_nums).^(1/alpha_p));
plot(sort(pareto), range, '.');

