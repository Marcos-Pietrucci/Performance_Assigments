% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 6

%Example code
M_total = 1000;

%arrivalRnd = @() -log(rand()) * 10;
%serviceRnd = @() -log(rand()) * 8;

Ui = [];
d = 1.96;
k = 1;
alphaU = 1;

%First case
while alphaU > 0.04
    k = k + 1;
    
    inter_arr = HyperExp_cdf(rand(M_total*2, 1) , [0.02, 0.2, 1]);
    serv_t = Erlang_generator(rand(M_total*10, 1) , [10, 1.5]);

    %%% Average response time %%%
        %Arrival time
    i = 2;
    A_t = zeros(1,2);
    while i ~= (length(inter_arr) + 1)
        A_t(i) = A_t(i-1) + inter_arr(i-1);
        i = i + 1;
    end
    
        %Completition time
    i = 2;
    C_t = zeros(1,2);
    C_t(1) = serv_t(1);
    while i ~= (length(A_t) + 1)
        C_t(i) = max(A_t(i), C_t(i-1)) + serv_t(i);
        i = i + 1;
    end

    %%%% Utilization %%%%
    len = length(A_t);
    
    super_M = [transpose(A_t), ones(len, 1); transpose(C_t), -ones(len,1)];
    super_M = sortrows(super_M, 1);
    super_M(:,3) = cumsum(super_M(:,2));
    
        %Get the time slices
    deltaT = super_M(2:end, 1) - super_M(1:end-1, 1);
    
        %Sum all the times whenever there was at least 1 job at the system;
    Bi = sum((super_M(1:end-1, 3) ~= 0) .* deltaT);
    Ti = C_t(end) - A_t(1);
    Ui(k, 1) = Bi/Ti; 

    Ubar = sum(Ui)/k;
    Us2 = sum((Ui-Ubar).^2)/ (k-1);
    
    Uci = [Ubar - d*sqrt(Us2/k), Ubar + d*sqrt(Us2/k)]
    alphaU = 2*(Uci(1,2) - Uci(1,1))/(Uci(1,2) + Uci(1,1))
end

function F = HyperExp_cdf(x, p)
	l1 = p(1);
	l2 = p(2);
	p1 = p(3);
    

    %HyperExponential
    N = length(x);
    lambda = [l1,l2];
    
    for i=1:(N/2)
        if x(i) <= p1
            F(i) = - log(x((N/2)+i))/lambda(1);
        else
            F(i) = - log(x((N/2)+i))/lambda(2);
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
            F(aux) = -log(product) ./ lambda_erl;
            aux = aux + 1;
            product = 1;
            counter = 0;
        end
    end
end
