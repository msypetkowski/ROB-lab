% skrypt g³ówny nie jest tym razem zbyt d³ugi

% liczbê sk³adowych g³ównych dobrze by³oby zmieniæ
comp_count = 80; 

[tvec tlab tstv tstl] = readSets(); 

% przed redukcj¹ danych mo¿na spojrzeæ na cyfry
% imshow(1-reshape(tvec(1,:), 28, 28)');

% oczywicie warto tak¿e sprawdziæ etykiety
[unique(tlab)'; unique(tstl)']

% tutaj mo¿ecie zadumaæ siê Pañstwo na moment, nad 
% wykrywaniem wartoci odstaj¹cych kiedy macie 784 cechy

% policzenie i wykonanie redukcji wymiarów PCA
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% jak by³o widaæ, mamy etykietê 0, która jako indeks wypadnie s³abo
% w tym æwiczeniu brutalnie przesunê wszystkie etykiety tak, 
% ¿eby najmniejsza mia³a wartoæ 1
tlab += 1;
tstl += 1;

train = tvec;
trainl = tlab;
test = tstv;
testl = tstl;

save train.txt train;
save trainl.txt trainl;
save test.txt test;
save testl.txt testl;
