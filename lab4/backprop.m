function [hidlw outlw terr] = backprop(tset, tslb, inihidlw, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN

% 1. Set output matrices to initial values
	hidlw = inihidlw;
	outlw = inioutlw;
	
% 2. Set total error to 0
	terr = 0;
	
% foreach sample in the training set
	for i=1:rows(tset)
		% 3. Set desired output of the ANN
		desiredOutput = zeros(1, 10);
		desiredOutput(tslb(i)) = 1;

		% 4. Propagate input forward through the ANN
		% remember to extend input [tset(i, :) 1]
		input = [tset(i, :) 1];
		midOutputNoActivation = input * inihidlw;
		midOutput = [actf(midOutputNoActivation) 1];
		output = midOutput * inioutlw;

		% 5. Adjust total error (just to know this value)
		
		% 6. Compute delta error of the output layer
		% how many delta errors should be computed here?
		outputDelta = (output - desiredOutput) .* (midOutput' .* inioutlw);
		
		% 7. Compute delta error of the hidden layer
		% how many delta errors should be computed here?
		% hiddenDelta = ((output - desiredOutput) * inioutlw) * actdf(midOutputNoActivation);
		
		% 8. Update output layer weights
		inioutlw = inioutlw - outputDelta .* lr;
		
		% 9. Update hidden layer weights
		% inihidlw = inihidlw - hiddenDelta * lr;

	end
