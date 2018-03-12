function para = para_indep(ts)
% Liczy parametry dla funkcji pdf_indep
% ts zbiór ucz¹cy (próbka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawieraj¹ca parametry:
%	para.labels - etykiety klas
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - odchylenia standardowe cech (wiersz na klasê)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

	% tu trzeba wype³niæ wartoœci œrednie i odchylenie standardowe dla klas
    for i=1 : size(labels)
        para.mu(i,:) = mean(ts(ts == i, 2:end), 1);
        para.sig(i,:) = std(ts(ts == i, 2:end), 1);

        % TODO: check
        para.sig(i,:) = para.sig(i, :) .* sqrt(10/9);
    endfor

end
