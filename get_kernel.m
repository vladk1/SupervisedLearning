function [ K ] = get_kernel( X, sigma )
    for i = 1:size(X,1)    
        for j = 1:size(X,1) 
            K(i, j) = exp(-norm(X(i,:)-X(j,:))^2 / (2*sigma) );
        end 
    end
end

