% skrypt g��wny nie jest tym razem zbyt d�ugi

% liczb� sk�adowych g��wnych dobrze by�oby zmieni�
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% przed redukcj� danych mo�na spojrze� na cyfry
imshow(1-reshape(tvec(1,:), 28, 28)');

% oczywi�cie warto tak�e sprawdzi� etykiety
[unique(tlab)'; unique(tstl)']

% tutaj mo�ecie zaduma� si� Pa�stwo na moment, nad 
% wykrywaniem warto�ci odstaj�cych kiedy macie 784 cechy

% policzenie i wykonanie redukcji wymiar�w PCA
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% jak by�o wida�, mamy etykiet� 0, kt�ra jako indeks wypadnie s�abo
% w tym �wiczeniu brutalnie przesun� wszystkie etykiety tak, 
% �eby najmniejsza mia�a warto�� 1
tlab += 1;
tstl += 1;

% Do nast�pnego kroku koniecznie trzeba mie� zaimplementowan� funkcj� perceptron
% Ja wyci�gn��bym sobie po 10 pr�bek z zer i jedynek i tylko 
% dwie pierwsze sk�adowe PCA - powinno to umo�liwi� �ledzenie post�p�w
% uczenia w funkcji perceptron

% przygotowanie zestawu 45 klasyfikator�w cyfr
ovo = trainOVOensamble(tvec, tlab, @perceptron);

clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% poniewa� tych 45 klasyfikator�w ma by� wykorzystanych w nast�pnym
% eksperymencie warto je zapisa�
save("ovo_ref.txt", "ovo");

%%%% TU IDZIE PA�STWA KOD %%%%
% np.:
% podzielenie cyfr na grupy na podstawie analizy macierzy pomy�ek i/lub innych eksperyment�w
% przygotowanie zestawu klasyfikator�w przydzielaj�cych cyfry do grup
% klasyfikacja cyfr w grupach
% 
