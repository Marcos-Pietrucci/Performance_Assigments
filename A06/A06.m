% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 6

clear all;

%Parameters
K0 = 100;
maxK = 20000;
M = 1000;
DK = 100;
MaxRelErr = 0.04;

% Given parameters to generate the distributions
l1 = 0.02;
l2 = 0.2;
p1 = 0.1;
k_erl = 10;
lamb_erl = 1.5;
lamb_exp = 0.1;
a_unif = 5;
b_unif = 10;

gam = 0.95;
d_gamma = norminv((1+gam)/2);

K = K0;
tA = 0;
tC = 0;

U = 0;
U2 = 0;
R = 0;
R2 = 0;
X = 0;
X2 = 0;
N = 0;
N2 = 0;
variance_R = zeros(M,1);
varR = 0;
varR2 = 0;

newIters = K;

while K < maxK
	for i = 1:newIters
		Bi = 0;
		Wi = 0;
        tA0 = tA;
	    
        %%% CASE ONE RANDOM NUMBERS %%%
        arrivals = HyperExp_rand_generator(M, [l1, l2, p1]);
        services = Erlang_rand_generator(M, [k_erl, lamb_erl]);
        
        %%% CASE TWO RANDOM NUMBERS %%%
        %arrivals = -log(rand(M,1))./lamb_exp;
        %services = Uniform_rand_generator(M, [a_unif, b_unif]);

		for j = 1:M
		    a_ji = arrivals(j);
            s_ji = services(j);
			tC = max(tA, tC) + s_ji;
			ri = tC - tA;

            %Storing all the response times
            variance_R(j) = ri;

			tA = tA + a_ji;
			Bi = Bi + s_ji;
			Wi = Wi + ri;
		end
		
        %Response time calculation
		Ri = Wi / M;
		R = R + Ri;
		R2 = R2 + Ri^2;

        %Varianace of the response rate
        varRi = var(variance_R);
		varR = varR + varRi;
        varR2 = varR2 + varRi^2;

        %Utilization calculation
		Ti = tC - tA0;
		Ui = Bi / Ti;
		U = U + Ui;
		U2 = U2 + Ui^2;
        
        %Throughput calculation
        Xi = M/Ti;
        X = X + Xi;
        X2 = X2 + Xi^2;

        %Number of jobs calculation
        Ni = Wi/Ti;
        N = N + Ni;
        N2 = N2 + Ni^2;
	end
	
	Rm = R / K;
	Rs = sqrt((R2 - R^2/K)/(K-1));
	CiR = [Rm - d_gamma * Rs / sqrt(K), Rm + d_gamma * Rs / sqrt(K)];
	errR = 2 * d_gamma * Rs / sqrt(K) / Rm;
	
	Um = U / K;
	Us = sqrt((U2 - U^2/K)/(K-1));
	CiU = [Um - d_gamma * Us / sqrt(K), Um + d_gamma * Us / sqrt(K)];
	errU = 2 * d_gamma * Us / sqrt(K) / Um;
	
    Xm = X / K;
    Xs = sqrt((X2 - X^2/K)/(K-1));
    CiX = [Xm - d_gamma * Xs / sqrt(K), Xm + d_gamma * Xs / sqrt(K)];
    errX = 2 * d_gamma * Xs / sqrt(K) / Xm;
    
    Nm = N / K;
    Ns = sqrt((N2 - N^2/K)/(K-1));
    CiN = [Nm - d_gamma * Ns / sqrt(K), Nm + d_gamma * Ns / sqrt(K)];
    errN = 2 * d_gamma * Ns / sqrt(K) / Nm;

    varRm = varR / K;
    varRs = sqrt((varR2 - varR^2/K)/(K-1));
    CivarR = [varRm - d_gamma * varRs / sqrt(K), varRm + d_gamma * varRs / sqrt(K)];
    errvarR = 2 * d_gamma * varRs / sqrt(K) / varRm;

	if (errR < MaxRelErr ...
        && errU < MaxRelErr ...
        && errX < MaxRelErr ...
        && errN < MaxRelErr ...
        && errvarR < MaxRelErr)
		break;
	else
		K = K + DK;
		newIters = DK;
	end
end

if (errR < MaxRelErr ...
        && errU < MaxRelErr ...
        && errX < MaxRelErr ...
        && errN < MaxRelErr)
	fprintf(1, "Maximum Relative Error reached in %d Iterations\n", K);
else
	fprintf(1, "Maximum Relative Error NOT REACHED in %d Iterations\n", K);
end	

fprintf(1, "Utilization in [%g, %g], with %g confidence. Relative Error: %g\n", CiU(1,1), CiU(1,2), gam, errU);
fprintf(1, "Throughtput [%g, %g], with %g confidence. Relative Error: %g\n", CiX(1,1), CiX(1,2), gam, errR);
fprintf(1, "Average Number of jobs in the system [%g, %g], with %g confidence. Relative Error: %g\n", CiN(1,1), CiN(1,2), gam, errN);
fprintf(1, "Resp. Time in [%g, %g], with %g confidence. Relative Error: %g\n", CiR(1,1), CiR(1,2), gam, errR);
fprintf(1, "Variance of the response time in [%g, %g], with %g confidence. Relative Error: %g\n", CivarR(1,1), CivarR(1,2), gam, errvarR);


function F = Uniform_rand_generator(S, p)
    a = p(1);
    b = p(2);

    for i = 1:S
        F(i) = a + (b-a)*rand();
    end
end

function F = HyperExp_rand_generator(S, p)
    l1 = p(1);
	l2 = p(2);
	p1 = p(3);

    for i = 1:S
        x = rand();  % Generate a random value between 0 and 1
        if x <= p1
            F(i) = -log(rand()) / l1;
        else
            F(i) = -log(rand()) / l2;
        end
    end
end

function F = Erlang_rand_generator(S, p)
    k_erl = p(1);
    lambda_erl = p(2);
    x = rand(k_erl*S, 1);

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

