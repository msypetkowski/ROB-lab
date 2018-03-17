function ret = reduce(dataset, part)
    ret = [];
    labels = unique(dataset(:,1));
    for c=1:rows(labels)
        data = dataset(dataset(:, 1) == labels(c), :);
        count = ceil(rows(data) * part);
        rndIDX = randperm(rows(data));
        ret = cat(1, ret ,data(rndIDX(1:count), :));
    end
end

% function rds = reduce(ds, parts)
% % Funkcja redukcji liczby pr�bek poszczeg�lnych klas w zbiorze ds
% % ds - zbi�r danych do redukcji; pierwsza kolumna zawiera etykiet�
% % parts - wierszowy wektor wsp�czynnik�w redukcji dla poszczeg�lnych klas
% 
% 	labels = unique(ds(:,1));
% 	if rows(labels) ~= columns(parts)
% 		error("Liczba klas nie zgadza sie z liczba wsp. redukcji.");
% 	end
% 
% 	if max(parts) > 1 || min(parts) < 0
% 		error("Niewlasciwe wspolczynniki redukcji.");
% 	end
% 		
% 	% zdecydowanie wypadaloby uzyc randperm do mieszania probek w klasach
% 	% ta implementacja jest daleka od doskonalosci
% 	rds = ds;
