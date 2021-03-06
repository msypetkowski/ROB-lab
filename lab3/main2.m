% special case - just OVO
% groups = {
%     [0;1;2;3;4;5;6;7;8;9]+1;
% };

% groups = {
%     [0]+1;
%     [1]+1;
%     [6]+1;
%     [2;3;4;5;7;8;9]+1;
% };

% groups = {
%     [0]+1;
%     [1]+1;
%     [2]+1;
%     [6]+1;
%     [3;4;5;7;8;9]+1;
% };

% groups = {
%     [0]+1;
%     [1]+1;
%     [2]+1;
%     [6]+1;
%     [3;5;8]+1;
%     [4;7;9]+1;
% };

% groups = {
%     [0]+1;
%     [1;2;3;4;5;6;7;8;9]+1;
% };

groups = {
    [0;1;2;6]+1;
    [3;5;8]+1;
    [4;7;9]+1;
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

% make experiments repeatable
rand ("seed", 123)

canonicalOvo = trainOVOensamble(train, trainl, @perceptron);

% train set of classifiers for distinguishing group
if rows(groups) > 1
    newTrainl = groupLabels(trainl, groups);
    globalOvo = trainOVOensamble(train, newTrainl, @perceptron);
    assert(rows(globalOvo) == (rows(groups) * (rows(groups) -1)) / 2);
    assert(rows(unique(newTrainl)) == rows(groups));
else
    globalOvo = [];
endif

% measure group classifier
if rows(groups) > 1
    disp('----------------Group classifier confusion matrix')
    cfmx = confMx(groupLabels(testl, groups),
                unamvoting(test, globalOvo))
    disp('----------------Group classifier precision')
    output_precision(3)
    compErrors(cfmx)
endif

% list of in-group sets of classifiers - use classifiers from "canonical" solution
localOvos = {};
for i=1:rows(groups)
    group = groups{i};
    if rows(group) > 1
        classifiers = [];
        for j=1:rows(group)
            for k=j+1:rows(group)
                classifier = canonicalOvo(canonicalOvo(:,1)==group(j) & canonicalOvo(:,2)==group(k), :);
                assert(rows(classifier) == 1);
                classifiers = [classifiers ; classifier];
            endfor
        endfor
        localOvos{i, 1} = classifiers;
    else
        localOvos{i, 1} = [];
    end
endfor


% list of in-group sets of classifiers
% localOvos = {};
% for i=1:rows(groups)
%     group = groups{i};
% 
%     % select training examples with labels that group has
%     [data lbl] = selectExamples(train, trainl, group);
%     assert(rows(data) == rows(lbl));
% 
%     if rows(group) > 1
%         localOvos{i, 1} = trainOVOensamble(data, lbl, @perceptron);
%     else
%         localOvos{i, 1} = []
%     end
% endfor
% assert(rows(localOvos) == rows(groups));


clab = classifyWithGroups(test, groups, globalOvo, localOvos);
disp('----------------Final confusion matrix')
cfmx = confMx(testl, clab)
disp('----------------Final results')
output_precision(3)
compErrors(cfmx)
