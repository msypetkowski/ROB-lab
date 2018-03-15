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
% plot2features(train, 4, 6)
train = filter_outliers(train);
size(train)
% plot2features(train, 4, 6)
test = filter_outliers(test);



% show all combinations
function show_all_pairs(data)
    index = 0;
    figure('Position',[0,0,2000,2000]);
    for i = 2:8
        for j = (i+1):8
            index = index + 1;
            subplot(5,5, index);
            title (sprintf ('features %d %d', i, j));
            features = [i j];
            plot2features(data, i, j, 0)
        end
    end
    pause
end
show_all_pairs(train)
% show_all_pairs(test)


disp('optimal bayes 2 features-----------------')
function ret = run_on_features(train, test, features)
    train = train(:, [1 features]);
    test = test(:, [1 features]);
    % plot2features(train, 2, 3)
    % plot2features(test, 2, 3)
    pdfindep_para = para_indep(train);
    pdfmulti_para = para_multi(train);
    pdfparzen_para = para_parzen(train, 0.001); 

    base_ercf = zeros(1,3);
    base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
    base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
    % base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1))
    ret = base_ercf;
end

run_on_features(train, test, [6 8]) % visually bad
run_on_features(train, test, [4 8]) % visually better
run_on_features(train, test, [4 5]) % ...
run_on_features(train, test, [2 4]) % visually best

run_on_features(train, test, [2 3 4 5 6 7 8])
