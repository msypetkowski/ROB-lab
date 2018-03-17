load pdf_test.txt;
size(pdf_test)

load train.txt
load test.txt

for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end
labels = unique(train(:,1))

train = filter_outliers(train);
test = filter_outliers(test);




disp('5. Parzen window width-----------------')
parts = (1:5) / 5;
parts = [0.06 0.08 parts]';
stat_means = [];
for i=1:rows(parts)
    experiments_count = 2;
    base_ercf = zeros(experiments_count,4);
    for r=1:experiments_count
        reduced = reduce(train, repmat(parts(i), rows(labels), 1));

        para1 = para_parzen(reduced, 0.0001); 
        para2 = para_parzen(reduced, 0.0005); 
        para3 = para_parzen(reduced, 0.001); 
        para4 = para_parzen(reduced, 0.002); 

        base_ercf(r, 1) = mean(bayescls(test(:,2:end), @pdf_parzen, para1) != test(:,1));
        base_ercf(r, 2) = mean(bayescls(test(:,2:end), @pdf_parzen, para2) != test(:,1));
        base_ercf(r, 3) = mean(bayescls(test(:,2:end), @pdf_parzen, para3) != test(:,1));
        base_ercf(r, 4) = mean(bayescls(test(:,2:end), @pdf_parzen, para4) != test(:,1));
    end
    stat_means = cat(1, stat_means, mean(base_ercf, 1));
end

fontsize = 20
linewidth = 3
set(0, "defaultlinelinewidth", linewidth);
figure('Position',[0,0,1500,2000]);
for i=1:4
    hold on;
    plot(parts * rows(train), stat_means(:, i), '-o', 'linewidth', linewidth);
end
set(gca, "linewidth", linewidth, "fontsize", fontsize);
legend({'width=0.0001', 'width=0.0005', 'width=0.001', 'width=0.002'});
xlabel('Training samples count');
ylabel('Classification error rate');
hold off;
grid on;
pause;




disp('6. A priori significance -----------------')
apriori = [0.085 0.165 0.165 0.085 0.085 0.165 0.165 0.085];
reduce_parts = [0.5 1.0 1.0 0.5 0.5 1.0 1.0 0.5];
reduced_test = reduce(test, reduce_parts);
para = para_multi(train); 
[labels'; sum(test(:,1) == labels')]
[labels'; sum(reduced_test(:,1) == labels')]


function ret = run_on_testset(train, test, apriori)
    pdfindep_para = para_indep(train);
    pdfmulti_para = para_multi(train);
    pdfparzen_para = para_parzen(train, 0.001); 

    % apriori = repmat([0.125], 1, 8)
    base_ercf = zeros(1,3);
    base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para, apriori) != test(:,1));
    base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para, apriori) != test(:,1));
    base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != test(:,1));
    base_ercf
end

run_on_testset(train, test, apriori);
run_on_testset(train, reduced_test, repmat(0.125, 1, rows(labels)))


% parts = (1:5) / 5;
% parts = [0.06 0.08 parts]';
% stat_means = [];
% for i=1:rows(parts)
%     experiments_count = 2;
%     base_ercf = zeros(experiments_count,2);
%     for r=1:experiments_count
%         reduced = reduce(train, repmat(parts(i), rows(labels), 1));
% 
%         para = para_multi(reduced); 
% 
%         base_ercf(r, 1) = mean(bayescls(test(:,2:end), @pdf_multi, para) != test(:,1));
%         base_ercf(r, 2) = mean(bayescls(test(:,2:end), @pdf_multi, para, apriori) != test(:,1));
%         % base_ercf(r, 2) = mean(bayescls(reduced_test(:,2:end), @pdf_multi, para, apriori) != reduced_test(:,1));
%         % base_ercf(r, 3) = mean(bayescls(test(:,2:end), @pdf_multi, para, apriori) != test(:,1));
%         % base_ercf(r, 4) = mean(bayescls(reduced_test(:,2:end), @pdf_multi, para) != reduced_test(:,1));
%     end
%     stat_means = cat(1, stat_means, mean(base_ercf, 1));
% end
% 
% fontsize = 20
% linewidth = 3
% set(0, "defaultlinelinewidth", linewidth);
% figure('Position',[0,0,1500,2000]);
% for i=1:2
%     hold on;
%     plot(parts * rows(train), stat_means(:, i), '-o', 'linewidth', linewidth);
% end
% set(gca, "linewidth", linewidth, "fontsize", fontsize);
% legend({'a priori equal', 'a priori changed', '3', '4'});
% xlabel('Training samples count');
% ylabel('Classification error rate');
% hold off;
% grid on;
% pause;
