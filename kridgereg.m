function [ dual_w ] = kridgereg( K, y, gamma )
% The function returns vector alpha of the dual weights
%  Takes in kernel matrix, y and gamma.
dim = size(K,2);
dual_w = (K+gamma*eye(dim)) \ y;
end

