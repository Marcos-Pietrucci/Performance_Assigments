% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 6

%Example code
M_total = 1000;

%arrivalRnd = @() -log(rand()) * 10;
%serviceRnd = @() -log(rand()) * 8;

Ui = [];
d = 1.96;
k = 2;
alphaU = 1;
totalJobs = 0;
l1 = 0.02;
l2 = 0.2;
p1 = 0.1;
iterations = 1;

%First case
while alphaU > 0.04
    tA = 0;
    tC = 0;
    tA0 = tA;

    for it = 1:iterations
        Bi = 0;
        tA0 = tA;

        inter_arr = HyperExp_cdf(M_total, [l1, l2, p1]);
        serv_t = Erlang_generator(rand(M_total*10, 1) , [10, 1.5]);%gamrnd(10, 1/1.5, M_total, 1);%
            
       for j = 1: M_total
                tC = max(tA, tC) + serv_t(j);
                tA = tA + inter_arr(j);
                Bi = Bi + serv_t(j);
       end

        Ti = tC - tA0;
        Ui(it,1) = Bi / Ti;
    end
    
    %Calculations of Utilization
    Ubar = sum(Ui)/k;
    Us2 = sum((Ui-Ubar).^2)/ (k-1);
    Uci = [Ubar - d*sqrt(Us2/k), Ubar + d*sqrt(Us2/k)]
    alphaU = 2*(Uci(1,2) - Uci(1,1))/(Uci(1,2) + Uci(1,1))
    
    k = iterations + k;
    iterations = k;
end


function F = HyperExp_cdf(L, p)
    l1 = p(1);
	l2 = p(2);
	p1 = p(3);

    for i = 1:L
        x = rand();  % Generate a random value between 0 and 1
        if x <= p1
            F(i) = -log(rand()) / l1;
        else
            F(i) = -log(rand()) / l2;
        end
    end
end

function F = Erlang_generator(x, p)
    k_erl = p(1);
    lambda_erl = p(2);
    product = 1;
    counter = 0;
    aux = 1;

    for i = 1:length(x)
        %Computing the product
        product = product * x(i);
        counter = counter + 1;        

        %Each k elements we should stop to compute the product
        if counter == k_erl
            F(aux) = -log(product) / lambda_erl;
            aux = aux + 1;
            product = 1;
            counter = 0;
        end
    end
end
