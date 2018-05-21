function res = actf(tact)
% sigmoid activation function
% tact - total activation 

    res = (tact > 0) .* tact;
