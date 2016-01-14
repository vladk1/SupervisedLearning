function [ mse ] = MSEfunction(sizeOfData,X,wtr_est,y  )
%Summary
%   Takes in size of the data: sizeOfData
%   x values, y values and estimated weight vector
mse=1/sizeOfData*((X*wtr_est-y)'*(X*wtr_est-y));

end

