function [ mse ] = dualcost( K, Y, w )
    len = size(K,1);
    mse = (1.0/len) * (K * w - Y)' * (K * w - Y);
end

