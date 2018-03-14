function para = para_parzen(ts, width = 0.0001)
% Liczy parametry dla funkcji pdf_parzen
% ts zbiór ucz¹cy (próbka = wiersz; w pierwszej kolumnie etykiety)
% width - szerokoœæ okna Parzena 
% para - struktura zawieraj¹ca parametry:
%	para.labels - etykiety klas
%	para.samples - tablica komórek zawieraj¹ca próbki z poszczególnych klas
%	para.parzenw - szerokoœæ okna Parzena

	labels = unique(ts(:,1));
	para.labels = labels;
	para.samples = cell(rows(labels),1);
	para.parzenw = width;

	for i=1:rows(labels)
		para.samples{i} = ts(ts(:,1) == labels(i), 2:end);
	end
end
