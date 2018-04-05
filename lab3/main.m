load train.txt;
load trainl.txt;
load test.txt;
load testl.txt;
% size(train)
% size(trainl)
% size(test)
% size(testl)

ovo = trainOVOensamble(train, trainl, @perceptron);

clab = unamvoting(test, ovo);
cfmx = confMx(testl, clab)
compErrors(cfmx)
