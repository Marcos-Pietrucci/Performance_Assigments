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
random_nums = random_nums / m;







