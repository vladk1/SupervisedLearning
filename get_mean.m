function [ mse_train_avr, mse_valid_avr, mse_test_avr ] = get_mean( mse_train, mse_valid, mse_test )
    mse_train_avr = mean(mse_train);
    mse_valid_avr = mean(mse_valid);
    mse_test_avr = mean(mse_test);
end

