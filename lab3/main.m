load train.txt;
load trainl.txt;
load test.txt;
load testl.txt;

rand ("seed", 123)

ovo = trainOVOensamble(train, trainl, @perceptron);
labels = unique(trainl)


disp('----------------Individual classifiers precision')
results_train = zeros(rows(labels), rows(labels));
results_test = zeros(rows(labels), rows(labels));
for i=1:rows(labels)
    for j=i + 1:rows(labels)
        assert(i == labels(i))
        assert(j == labels(j))
        classifier = ovo;
        classifier = classifier((classifier(:, 1) == i), :);
        classifier = classifier((classifier(:, 2) == j), :);
        assert(rows(classifier) == 1);
        classifier = classifier(1, :);

        results_train(i,j) = measureIndividual(classifier, train, trainl);
        results_test(i,j) = measureIndividual(classifier, test, testl);
    endfor
endfor

output_precision(3)
results_train
results_test


disp('----------------Confusion matrix')
clab = unamvoting(test, ovo);
cfmx = confMx(testl, clab)

disp('----------------Final OVO results')
output_precision(3)
compErrors(cfmx)

disp('----------------Confusion matrix - training set')
clab = unamvoting(train, ovo);
cfmx = confMx(trainl, clab)

disp('----------------Final OVO results - training set')
output_precision(3)
compErrors(cfmx)
