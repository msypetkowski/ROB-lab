function precision = measureIndividual(classifier, examples, labels)
    label1 = classifier(1, 1);
    label2 = classifier(1, 2);

    % select only examples with label1 and label2
    select = ((labels == label1) | (labels == label2));
    examples = examples(select, :);
    labels = labels(select, :);

	aone = ones(size(examples,1), 1);
	
    res = [aone examples] * classifier(1,3:end)';
    prediction = ((res >= 0) * label1) + ((res < 0) * label2);
    assert(rows(prediction) == rows(labels));
    precision = sum(prediction == labels) / rows(prediction);
