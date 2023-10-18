function F = Weibull_moments(p)
	% p(1) -> lambda (scale)
	% p(2) -> k (shape)
	% p(3) -> p_1
	l = p(1);
	k = p(2);
	
	F = [];
	F(1) = 1 - exp(-);
	F(2) = 2*(p1 / l1^2 + (1-p1) / k^2);
	F(3) = 6*(p1 / l1^3 + (1-p1) / k^3);
end