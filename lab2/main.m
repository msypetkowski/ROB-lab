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
disp('1. Data Previev-----------------')
size(train)
size(test)
labels = unique(train(:,1))
% unique(test(:,1))
[labels'; sum(train(:,1) == labels')]




disp('2. Filter outliers-----------------')
size(train)
% plot2features(train, 4, 6)
train = filter_outliers(train);
size(train)
% plot2features(train, 4, 6)
test = filter_outliers(test);




disp('3. Optimal bayes 2 features-----------------')
% show all feature pairs visualisations
% function show_all_pairs(data)
%     index = 0;
%     figure('Position',[0,0,2000,2000]);
%     for i = 2:8
%         for j = (i+1):8
%             index = index + 1;
%             subplot(5,5, index);
%             title (sprintf ('features %d %d', i, j));
%             features = [i j];
%             plot2features(data, i, j, 0)
%         end
%     end
%     pause
% end
% show_all_pairs(train)
% show_all_pairs(test)

function ret = run_on_features(train, test, features)
    train = train(:, [1 features]);
    test = test(:, [1 features]);
    % plot2features(train, 2, 3)
    % plot2features(test, 2, 3)
    pdfindep_para = para_indep(train);
    pdfmulti_para = para_multi(train);
    pdfparzen_para = para_parzen(train, 0.001); 

    % apriori = repmat([0.125], 1, 8)
    base_ercf = zeros(1,3);
    base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
    base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
    base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
    ret = base_ercf;
end

run_on_features(train, test, [6 8]) % visually bad
run_on_features(train, test, [4 8]) % visually better
run_on_features(train, test, [4 5]) % ...
run_on_features(train, test, [2 4]) % visually best
run_on_features(train, test, [2 3 4 5 6 7 8])



disp('4. Reduce-----------------')
function ret = reduce(dataset, part)
    ret = [];
    labels = unique(dataset(:,1));
    for c=1:rows(labels)
        % disp(labels(c))
        data = dataset(dataset(:, 1) == labels(c), :);
        count = ceil(rows(data) * part);
        rndIDX = randperm(rows(data));
        ret = cat(1, ret ,data(rndIDX(1:count), :));
    end

end

parts = (1:5) / 5;
parts = [0.04 0.06 0.08 parts]';
% parts = parts'
pl = [];
for i=1:rows(parts)
    base_ercf = zeros(1,3);
    experiments_count = 10;
    for r=1:experiments_count
        reduced = reduce(train, parts(i));

        pdfindep_para = para_indep(reduced);
        pdfmulti_para = para_multi(reduced);
        pdfparzen_para = para_parzen(reduced, 0.001); 

        base_ercf(1) += mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
        base_ercf(2) += mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
        base_ercf(3) += mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
    end
    base_ercf /= experiments_count
    pl = cat(1, pl, base_ercf);
end

figure('Position',[0,0,2000,2000]);
for i=1:3
    hold on;
    plot(parts * rows(train), pl(:, i), 'linewidth', 5);
end
set(gca, "linewidth", 4, "fontsize", 20)
legend({'indep', 'multi', 'parzen'});
xlabel('Training samples count')
ylabel('Classification error rate')
hold off;
grid on;
pause
