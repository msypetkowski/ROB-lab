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

    for i=1:rows(pts) % for each sample
        for c=1:rows(para.labels) % for each class
            samples = para.samples{c,1};
            n = rows(samples);
            % disp('---------')
            % disp(samples);
            % disp('---------')
            % disp(size(samples));
            shares_sum = 0;
            hn = para.parzenw / sqrt(n);
            for p=1:n % for each training sample
                est_pdf = normpdf((pts(i,:) - samples(p,:)) / hn) / hn;
                shares_sum = shares_sum + prod(est_pdf);
            end

            pdf(i, c) = shares_sum / n;
    end
	
end
