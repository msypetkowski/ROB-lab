% special case - OVO
% groups = {
%     [0;1;2;3;4;5;6;7;8;9]+1;
% };

% special case - also OVO
% groups = {
%     [0]+1;
%     [1]+1;
%     [2]+1;
%     [3]+1;
%     [4]+1;
%     [5]+1;
%     [6]+1;
%     [7]+1;
%     [8]+1;
%     [9]+1;
% };

groups = {
    [0;1;2;3;4;6;7;9]+1;
    [5;8]+1;
};

function newLbl = groupLabels(lbl, groups)
    newLbl = zeros(rows(lbl), 1);
    for i=1:rows(groups)
        group = groups{i};
        for j=1:rows(group)
            newLbl(lbl==group(j)) = i;
        endfor
    endfor
end

function [data lbl] = selectExamples(data, lbl, lblToSelect)
    mask = zeros(rows(lbl), 1);
    for i=1:rows(lblToSelect)
        mask = mask | (lbl==lblToSelect(i));
    endfor
    data = data(mask, :);
    lbl = lbl(mask);
end


load train.txt;
load trainl.txt;
load test.txt;
load testl.txt;
rand ("seed", 123)


% train set of classifiers for distinguishing group
if rows(groups) > 1
    newTrainl = groupLabels(trainl, groups);
    globalOvo = trainOVOensamble(train, newTrainl, @perceptron);

    assert(rows(globalOvo) == (rows(groups) * (rows(groups) -1)) / 2);
    assert(rows(unique(newTrainl)) == rows(groups));
else
    globalOvo = [];
endif


% list of in-group sets of classifiers
localOvos = {};
for i=1:rows(groups)
    group = groups{i};

    % select training examples with labels that group has
    [data lbl] = selectExamples(train, trainl, group);
    assert(rows(data) == rows(lbl));

    if rows(group) > 1
        localOvos{i, 1} = trainOVOensamble(data, lbl, @perceptron);
    else
        localOvos{i, 1} = []
    end
endfor
assert(rows(localOvos) == rows(groups));


clab = classifyWithGroups(test, groups, globalOvo, localOvos);
disp('----------------Confusion matrix')
cfmx = confMx(testl, clab)
disp('----------------Final results')
output_precision(3)
compErrors(cfmx)
