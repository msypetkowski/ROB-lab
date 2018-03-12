function pdf = pdf_multi(pts, para)
% Liczy funkcjê gêstoœci prawdopodobieñstwa wielowymiarowego r. normalnego
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - macierze kowariancji cech (warstwa na klasê)
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.mu));
	
end
