function [mse_train, mse_test] = get_mean_square_error(Xtr, y_train, Xte, y_test, gamma)

    len_te = size(Xte, 1);
    len_tr = size(Xtr, 1);
    dim = size(Xtr, 2);
    wtr_est = ((Xtr' * Xtr) + (gamma*len_tr*eye(dim))) \ (Xtr'*y_train); 
    
    % Using equation (3) compute the mean squared error on both the training
    % and test sets.
    mse_train = get_mse(Xtr, y_train, wtr_est, len_tr);
    mse_test = get_mse(Xte, y_test, wtr_est, len_te);
end

function mse = get_mse(X, Y, w, len)
    mse = (1.0/len) * (w' * (X)' * X * w - 2 * Y' * X * w + Y' * Y);
end
