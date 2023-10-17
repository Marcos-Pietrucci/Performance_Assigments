function F = Erlang_cdf(x, p)
	lambda = p(1);
	k = p(2);
	
	F = max(0, min(1, (lambda^k * x^(k-1) * exp(-lambda*x)) / factorial(k-1)));
end