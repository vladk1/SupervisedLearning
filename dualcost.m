function [ mse ] = dualcost( K, Y, w )
    len = size(K,1);
    mse = (1/len) * (K*w - Y)' * (K*w - Y);
%     mse = (1.0/len) * (w' * (K)' * K * w - 2 * Y' * K * w + Y' * Y);
end

