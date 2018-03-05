qwe='qwe' % function in first line needs proper filename

function retval = distances(v, m)
    repeated = repmat(v, size(m)(1), 1)
    retval = sqrt(sum((repeated .- m) .^ 2, 2))
endfunction


function retval = main(iris1, iris2, point)
    d1 = distances(point, iris1(:, 2:end))
    d2 = distances(point, iris2(:, 2:end))
    [min1, i1] = min(d1)
    [min2, i2] = min(d2)
    disp ('minimal distance:')
    if min1 < min2
        disp (min1)
        disp (iris1(i1, :))
        disp ('class versicolor')
        retval = 1
    else
        disp (min2)
        disp (iris2(i2, :))
        disp ('class virginica')
        retval = 2
    endif
endfunction



iris1 = load ('iris2.txt') % (:, 2:end)
iris2 = load ('iris3.txt') % (:, 2:end)

% disp (main(iris1, iris2, point))

totalCorrect = 0

%for i = 1:size(iris1)(1)
for i = 1:1
    testSample = iris1(i, :)
    trainData = iris1(1:end != i, :)
    disp(size(trainData))
    result = main(trainData, iris2, testSample)
    if results == 1
        totalCorrect = totalCorrect + 1
    endif
    disp (outIndex)
endfor

disp(totalCorrect ./ (size(iris1) + size(iris2)))

