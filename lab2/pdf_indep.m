function pdf = pdf_indep(pts, para)
% Liczy funkcjê gêstoœci prawdopodobieñstwa przy za³o¿eniu, ¿e cechy s¹ niezale¿ne
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - odchylenia standardowe cech (wiersz na klasê)
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wiêc go alokujê
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
