% Marcos Vinicius Firmino Pietrucci
% 10914211
% Assigment 6


%Example code
M = 1000;

arrivalRnd = @() -log(rand()) * 10;
serviceRnd = @() -log(rand()) * 8;

Ui = [];
d = 1.96;
k = 1;
alphaU = 1;

while alphaU > 0.04
    k = k + 1;
    t0a = tA;
    Bi = 0;
    for j= 1:M
        a_ji = arrivalRnd();
        s_ji = serviceRnd();
    
        tA = tA + a_ji;
        tC = max(tA, tC) + s_ji;
        Bi = Bi + s_ji;
    end
    Ti = tC - t0a;
    Ui(k, 1) = Bi/Ti;

    Ubar = sum(Ui)/k;
    Us2 = sum((Ui-Ubar).^2)/ (k-1);
    
    Uci =[Ubar - d*sqrt(Us2/k), Ubar + d*sqrt(Us2/k)]
    alphaU = 2*(Uci(1,2) - Uci(1,1))/(Uci(1,2) + Uci(1,1))
end
