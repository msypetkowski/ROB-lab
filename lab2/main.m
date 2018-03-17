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
show_all_pairs(test)

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
parts = (1:5) / 5;
parts = [0.06 0.08 parts]';
% parts = parts'
stat_means = [];
stat_std = [];
stat_min = [];
stat_max = [];
for i=1:rows(parts)
    experiments_count = 2;
    base_ercf = zeros(experiments_count,3);
    for r=1:experiments_count
        reduced = reduce(train, repmat(parts(i), rows(labels), 1));

        pdfindep_para = para_indep(reduced);
        pdfmulti_para = para_multi(reduced);
        pdfparzen_para = para_parzen(reduced, 0.001); 

        base_ercf(r, 1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
        base_ercf(r, 2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
        base_ercf(r, 3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
    end
    stat_means = cat(1, stat_means, mean(base_ercf, 1));
    stat_std = cat(1, stat_std, std(base_ercf));
    stat_min = cat(1, stat_min, min(base_ercf));
    stat_max = cat(1, stat_max, max(base_ercf));
end

fontsize = 20
linewidth = 3
set(0, "defaultlinelinewidth", linewidth);
figure('Position',[0,0,1500,2000]);
for i=1:3
    hold on;
    % plot(parts * rows(train), stat_means(:, i), '-o', 'linewidth', linewidth);
    errorbar(parts * rows(train), stat_means(:, i), stat_std(:, i), stat_std(:, i));

    % annotations = cellstr(num2str(stat_std(:, i)));
    % text(parts * rows(train), stat_means(:, i), annotations, 'VerticalAlignment','bottom', ...
    %      'HorizontalAlignment','right', 'fontsize', fontsize);
end
set(gca, "linewidth", linewidth, "fontsize", fontsize)
legend({'indep', 'multi', 'parzen'});
xlabel('Training samples count')
ylabel('Classification error rate')
hold off;
grid on;
pause;

figure('Position',[0,0,1500,2000]);
for i=1:3
    hold on;
    plot(parts * rows(train), stat_min(:, i), '-o', 'linewidth', linewidth);
end
set(gca, "linewidth", linewidth, "fontsize", fontsize);
legend({'indep', 'multi', 'parzen'});
xlabel('Training samples count')
ylabel('Classification error rate')
hold off;
grid on;
pause;

figure('Position',[0,0,1500,2000]);
for i=1:3
    hold on;
    plot(parts * rows(train), stat_max(:, i), '-o', 'linewidth', linewidth);
end
set(gca, "linewidth", linewidth, "fontsize", fontsize);
legend({'indep', 'multi', 'parzen'});
xlabel('Training samples count')
ylabel('Classification error rate')
hold off;
grid on;
pause;
