load pdf_test.txt;
size(pdf_test)

% wreszcie mo¿na zaj¹æ siê kartami!
load train.txt
load test.txt

% poniewa¿ dane s¹ w istocie z dwóch populacji zmieniamy
% etykiety "klienta" na etykiety pasuj¹ce do klasyfikacji
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

% pierwszy rzut oka na dane
disp('Data Previev-----------------')
size(train)
size(test)
labels = unique(train(:,1))
% unique(test(:,1))
[labels'; sum(train(:,1) == labels')]


disp('filter outliers-----------------')
size(train)
plot2features(train, 4, 6)
train = filter_outliers(train);
size(train)
plot2features(train, 4, 6)
