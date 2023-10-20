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