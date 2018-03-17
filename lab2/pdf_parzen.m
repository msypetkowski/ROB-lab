function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
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
