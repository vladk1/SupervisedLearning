function [ mse ] = dualcost( K, y, dual_w )
    l = size(K,1);
    mse = (1/l) * (K*dual_w - y)' * (K*dual_w - y);
end

