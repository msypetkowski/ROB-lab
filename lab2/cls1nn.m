function decv = cls1nn(pts, train)
    function retval = distances(v, m)
        % returns list of distances between v
        % and each vector in m
        repeated = repmat(v, size(m)(1), 1);
        retval = sqrt(sum((repeated .- m) .^ 2, 2));
    endfunction

    labels = unique(train(:,1));
    decv = zeros(rows(pts), 1);
    for s=1:rows(pts)
        [mval mindex] = min(distances(pts(s, :), train(:, 2:end)));
        decv(s) = train(mindex, 1);
    end
end
