function clab = unamvoting(tset, clsmx)
% Simple unanimity voting function 
%	tset - matrix containing test data; one row represents one sample
%	clsmx - voting committee matrix
% Output:
%	clab - classification result 

	% class processing
	labels = unique(clsmx(:, [1 2]))
	if rows(clsmx) == 1
		labels = labels';
	endif
	maxvotes = rows(labels) - 1; % unanimity voting in one vs. one scheme
	% reject = max(labels) + 1;
	reject = 11;
	
	% cast votes of classifiers
	votes = voting(tset, clsmx);
	
	[mv clab] = max(votes, [], 2);
	clab(mv ~= maxvotes) = reject;
