function clab = classifyWithGroups(data, groups, globalOvo, localOvos)
    reject = 11;
    clab = ones(rows(data), 1) * reject;
    if rows(groups) > 1
        predictedGroups = unamvoting(data, globalOvo);
        assert(rows(predictedGroups) == rows(data));
    else
        predictedGroups = ones(rows(data), 1)
    endif
    % assert(rows(unique(predictedGroups)) == rows(groups) + 1); %  + 1 because some are rejected
    for i=1:rows(groups)
        group = groups{i};
        mask = predictedGroups==i;
        if rows(group) > 1
            predictedLabels = unamvoting(data(mask, :), localOvos{i});
        else
            predictedLabels = ones(rows(data(mask, :)), 1);
        endif
        predictedLabels(predictedLabels!=reject) = group(predictedLabels(predictedLabels!=reject));
        unique(predictedLabels)
        assert(rows(predictedLabels) == sum(mask));
        clab(mask) = predictedLabels;
    endfor
end
