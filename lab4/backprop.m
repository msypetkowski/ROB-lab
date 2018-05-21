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
		midOutputNoActivation = input * hidlw;
		midOutput = [actf(midOutputNoActivation) 1];
		output = midOutput * outlw;

		% 5. Adjust total error (just to know this value)
		
		% 6. Compute delta error of the output layer
		% how many delta errors should be computed here?
		outputDelta = (output - desiredOutput) .* (midOutput');
		
		% 7. Compute delta error of the hidden layer
		% how many delta errors should be computed here?
		% hiddenDelta = ((output - desiredOutput) * outlw) * actdf(midOutputNoActivation);
		hiddenDelta = zeros(rows(hidlw), columns(hidlw));
		% non-vectorized version:
		% for x=1:rows(hidlw)
		%	  for i=1:columns(hidlw)
		%		  hiddenDelta(x, i) = sum((output - desiredOutput) .* outlw(i, :)) .* actdf(midOutput(1, i)) .* input(1, x);
		%	  endfor
		% endfor
		for i=1:columns(hidlw)
			someScalar = sum((output - desiredOutput) .* outlw(i, :)) .* actdf(midOutput(1, i));
			hiddenDelta(:, i) = someScalar .* input(1, :);
		endfor
		
		% 8. Update output layer weights
		outlw = outlw - outputDelta * lr;
		
		% 9. Update hidden layer weights
		hidlw = hidlw - hiddenDelta * lr;

	end
