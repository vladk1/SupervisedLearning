function [ X, y ] = generate_data( size, d )
    X = randn(size, d); 
    n = randn(size, 1);
    w = randn(d,1);
    y = X * w + n;
end

