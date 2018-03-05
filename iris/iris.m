% dqwe
qwe= 1

function retval = distances(v, m)
    repeated = repmat(v, size(m)(1), 1)
    retval = sqrt(sum((repeated .- m) .^ 2, 2))
endfunction

iris1 = load ('iris2.txt') % (:, 2:end)
iris2 = load ('iris3.txt') % (:, 2:end)


point = [5.0 3.0 3.0 1.5]


d1 = distances(point, iris1(:, 2:end))
d2 = distances(point, iris2(:, 2:end))
[min1, i1] = min(d1)
[min2, i2] = min(d2)
disp ('minimal distance:')
if min1 < min2
    disp (min1)
    disp (iris1(i1, :))
    disp ('class versicolor')
else
    disp (min2)
    disp (iris2(i2, :))
    disp ('class virginica')
endif



for outIndex = 1:10
    disp (outIndex)
endfor
