function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = ones(rows(pts), rows(para.mu));

    % for i=1 : size(pts)
    %     for j=1 : rows(para.mu) % for each class
    %         pdf(i, j) = 1;
    %         for k=1 : columns(para.mu) % for each feature
    %             pdf(i, j) = pdf(i, j) * normpdf(pts(i, k),
    %                         para.mu(j,k), para.sig(j,k));
    %         endfor
    %     endfor
    % endfor

    for j=1 : rows(para.mu) % for each class
        for k=1 : columns(para.mu) % for each feature
            pdf(:, j) = pdf(:, j) .* normpdf(pts(:, k),
                        para.mu(j,k), para.sig(j,k));
        endfor
    endfor

end
