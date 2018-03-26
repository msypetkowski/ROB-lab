% skrypt g³ówny nie jest tym razem zbyt d³ugi

% liczbê sk³adowych g³ównych dobrze by³oby zmieniæ
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% przed redukcj¹ danych mo¿na spojrzeæ na cyfry
imshow(1-reshape(tvec(1,:), 28, 28)');

% oczywiœcie warto tak¿e sprawdziæ etykiety
[unique(tlab)'; unique(tstl)']

% tutaj mo¿ecie zadumaæ siê Pañstwo na moment, nad 
% wykrywaniem wartoœci odstaj¹cych kiedy macie 784 cechy

% policzenie i wykonanie redukcji wymiarów PCA
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% jak by³o widaæ, mamy etykietê 0, która jako indeks wypadnie s³abo
% w tym æwiczeniu brutalnie przesunê wszystkie etykiety tak, 
% ¿eby najmniejsza mia³a wartoœæ 1
tlab += 1;
tstl += 1;

% Do nastêpnego kroku koniecznie trzeba mieæ zaimplementowan¹ funkcjê perceptron
% Ja wyci¹gn¹³bym sobie po 10 próbek z zer i jedynek i tylko 
% dwie pierwsze sk³adowe PCA - powinno to umo¿liwiæ œledzenie postêpów
% uczenia w funkcji perceptron

% przygotowanie zestawu 45 klasyfikatorów cyfr
ovo = trainOVOensamble(tvec, tlab, @perceptron);

clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% poniewa¿ tych 45 klasyfikatorów ma byæ wykorzystanych w nastêpnym
% eksperymencie warto je zapisaæ
save("ovo_ref.txt", "ovo");

%%%% TU IDZIE PAÑSTWA KOD %%%%
% np.:
% podzielenie cyfr na grupy na podstawie analizy macierzy pomy³ek i/lub innych eksperymentów
% przygotowanie zestawu klasyfikatorów przydzielaj¹cych cyfry do grup
% klasyfikacja cyfr w grupach
% 
