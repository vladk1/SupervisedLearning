function [ K ] = get_kernel( x, sigma )

for i = 1:numel(X)    
    for j = 1:numel(X) 
        K(i, j) = exp(-norm(X(i,:)-X(j,:))^2 / (2*sigma) );
    end 
end

end

