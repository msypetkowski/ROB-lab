qwe='qwe'; % function in first line needs proper filename


function retval = distances(v, m)
    % returns list of distances between v
    % and each vector in m
    repeated = repmat(v, size(m)(1), 1);
    retval = sqrt(sum((repeated .- m) .^ 2, 2));
endfunction


function retval = predict(data1, data2, point)
    % returns 1 or 2 (predicted class of point)
    d1 = distances(point, data1);
    d2 = distances(point, data2);
    [min1, i1] = min(d1);
    [min2, i2] = min(d2);
    % disp ('minimal distance:');
    if min1 < min2
        retval = 1;
    else
        retval = 2;
    endif
endfunction


function retval = getCorrect(class1, class2)
    % returns count of correct predictions
    % removing single elements from class1
    total = 0;
    for i = 1:size(class1)(1)
        testSample = class1(i, :);
        trainData = class1(1:end != i, :);
        result = predict(trainData, class2, testSample);
        if result == 1
            total = total + 1;
        endif
    endfor
    retval = total;
endfunction


function retval = evalForFeatures(class1, class2, features)
    data1 = class1(: , features);
    data2 = class2(: , features);
    retval = getCorrect(data1, data2) + getCorrect(data2, data1);
endfunction

iris1 = load ('iris2.txt') (:, 2:end);
iris2 = load ('iris3.txt') (:, 2:end);

features = [1, 2, 3, 4];
disp('all fetures:')
disp(evalForFeatures(iris1, iris2, 1:4))

disp('---------3 fetures:')
for i = 1:4
    features = (1:4) (1:end != i);
	disp(features);
    disp(evalForFeatures(iris1, iris2, features));
endfor

disp('---------2 fetures:')
for i = 1:4
    for j = (i+1):4
        features = (1:4) (1:end != i) (1:end != j-1);
		disp(features);
        disp(evalForFeatures(iris1, iris2, features));
    endfor
endfor

disp('---------1 feature:')
for i = 1:4
    features = [i]
    disp(evalForFeatures(iris1, iris2, features));
endfor
