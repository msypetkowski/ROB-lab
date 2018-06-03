[tvec tlab tstv tstl] = readSets(); 
tlab += 1;
tstl += 1;

% tvec = tvec(1:300, :);
% tlab = tlab(1:300, :);

% remove columns with zero std 
toRemain = std(tvec) != 0;
tvec = tvec(:, toRemain);
tstv = tstv(:, toRemain);

% store data for normalization
mu = mean(tvec);
sig = std(tvec);

noHiddenNeurons = 200;
noEpochs = 8;
learningRate = 0.005;

rand ("seed", 123)

% no normalization
[hlnn olnn] = crann(columns(tvec), noHiddenNeurons, 10);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
trReport = [];
labels = unique(tstl)
sumcfmx = cfmx = zeros(rows(labels), rows(labels) +1);
for epoch=1:noEpochs
	tic();
	[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate);
    learningRate = learningRate * 0.5
	clsRes = anncls(tvec, hlnn, olnn);
	cfmx = confMx(tlab, clsRes);
	errcf = compErrors(cfmx);
	trainError(epoch) = errcf(2);

	clsRes = anncls(tstv, hlnn, olnn);
	cfmx = confMx(tstl, clsRes);
    sumcfmx = sumcfmx + cfmx;
	errcf2 = compErrors(cfmx);
	testError(epoch) = errcf2(2);
	epochTime = toc();
	[epoch epochTime trainError(epoch) testError(epoch)]
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	[errcf errcf2]
	fflush(stdout);
end

[(1:columns(testError))', testError']
output_precision(0)
[1:11 ; [sumcfmx / noEpochs]]
assert(sum(sum(sumcfmx)) / noEpochs == rows(tstl))
