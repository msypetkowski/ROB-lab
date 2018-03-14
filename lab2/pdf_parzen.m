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
