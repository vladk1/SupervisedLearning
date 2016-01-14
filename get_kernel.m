function [ K ] = get_kernel( X, sigma )
   nsq=sum(X.^2,2);
   K=bsxfun(@minus,nsq,(2*X)*X.');
   K=bsxfun(@plus,nsq.',K);
   K=exp(-K / (2*(sigma^2)));
end

% function K = gauss_kernel(X, sigma)
%    nsq=sum(X.^2,2);
%    K=bsxfun(@minus,nsq,(2*X)*X.');
%    K=bsxfun(@plus,nsq.',K);
%    K=exp(-K / (2*(sigma^2)));
% end
