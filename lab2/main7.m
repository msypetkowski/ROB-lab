load pdf_test.txt;
size(pdf_test);

load train.txt;
load test.txt;

for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

train = filter_outliers(train);
test = filter_outliers(test);

disp('7. 1-NN vs Bayes -----------------')
% normalize data
for f=2:columns(train)
    train(:, f) = (train(:, f) - mean(train(:, f))) / std(train(:,f));
    test(:, f) = (test(:, f) - mean(test(:, f))) / std(test(:,f));
end

% train = train(: ,[1 2 4]);
% test = test(: ,[1 2 4]);

mean(cls1nn(test(:,2:end), train) != test(:,1))
