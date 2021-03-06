function clab = unamvoting(tset, clsmx, reject=-1)
% Simple unanimity voting function 
%	tset - matrix containing test data; one row represents one sample
%	clsmx - voting committee matrix
% Output:
%	clab - classification result 

	% class processing
	labels = unique(clsmx(:, [1 2]));
	if rows(clsmx) == 1
		labels = labels';
	endif
	maxvotes = rows(labels) - 1; % unanimity voting in one vs. one scheme
	if reject == -1
		reject = max(labels) + 1;
	endif
	
	% cast votes of classifiers
	votes = voting(tset, clsmx);
	
	[mv clab] = max(votes, [], 2);
	clab(mv ~= maxvotes) = reject;
