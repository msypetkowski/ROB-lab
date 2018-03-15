function ret = filter_outliers(data)
    orig_data = data;
    data = data(:, 2:end);
    ind_normalized = (data - mean(data, 1)) .- std(data, 0, 1);
    range = quantile(ind_normalized, 0.75) .- quantile(ind_normalized, 0.25);


    multiplier = 90.0;
    up_thr = quantile(ind_normalized, 0.75) .+ range * multiplier;
    down_thr = quantile(ind_normalized, 0.25) .- range * multiplier;

    mask = max(max(ind_normalized > up_thr, ind_normalized < down_thr), [], 2);
    ret = orig_data(~mask, :);
end
