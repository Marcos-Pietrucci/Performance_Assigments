function F = Erlang_test_pdf(x, p)
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
            F(aux) = -log(prod(product)) ./ lambda_erl;
            aux = aux + 1;
            product = 1;
            counter = 0;
        end
    end
end
