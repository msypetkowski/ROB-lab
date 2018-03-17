function pdf = pdf_parzen(pts, para)
% Aproksymuje wartoœæ gêstoœci prawdopodobieñstwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.samples - tablica komórek zawieraj¹ca próbki z poszczególnych klas
%	para.parzenw - szerokoœæ okna Parzena
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));

    for c=1:rows(para.labels) % for each class
        samples = para.samples{c,1};
        n = rows(samples);
        hn = para.parzenw / sqrt(n);

        shares_sum = zeros(rows(pts), 1);
        for p=1:n % for each training sample
            est_pdf = normpdf((pts - samples(p,:)) / hn) / hn;
            shares_sum = shares_sum + prod(est_pdf, 2);
        end

        pdf(:, c) = shares_sum / n;
    end
	
end
