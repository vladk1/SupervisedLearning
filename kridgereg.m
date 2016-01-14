function [ dual_w ] = kridgereg( K, y, gamma )
% The function returns vector alpha of the dual weights
%  Takes in kernel matrix, y and gamma.
dim = size(K,2);
len = size(K,1);
dual_w = (K + gamma * size(K,1) * eye(size(K,1))) \ y;
end

