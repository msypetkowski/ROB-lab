function para = para_multi(ts)
% Liczy parametry dla funkcji pdf_multi
% ts zbiór ucz¹cy (próbka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawieraj¹ca parametry:
%	para.labels - etykiety klas
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - macierze kowariancji cech (warstwa na klasê)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(columns(ts)-1, columns(ts)-1, rows(labels));

    for i=1 : size(labels)
        para.mu(i,:) = mean(ts(ts == i, 2:end), 1);
    endfor

    for i=1:columns(ts)-1
        for j=1:(columns(ts)-1)
            for k=1:rows(labels)
                para.sig(i,j,k) = cov(
                    ts(ts == k, 2:end)(:, i),
                    ts(ts == k, 2:end)(:, j));
            endfor
        endfor
    endfor

end
