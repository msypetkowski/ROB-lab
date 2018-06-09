[tvec tlab tstv tstl] = readSets(); 
tlab += 1;
tstl += 1;

% tvec = tvec(1:100, :);
% tlab = tlab(1:100, :);

% remove columns with zero std 
toRemain = std(tvec) != 0;
tvec = tvec(:, toRemain);
tstv = tstv(:, toRemain);

% store data for normalization
mu = mean(tvec);
sig = std(tvec);

noHiddenNeurons = 400;
noEpochs = 10;
learningRate = 0.020;

rand ("seed", 123)

% no normalization
[hlnn olnn] = crann(columns(tvec), noHiddenNeurons, 10);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
% trReport = [];
labels = unique(tstl);
for epoch=1:noEpochs
	tic();
    disp('------------------Next epoch')
    learningRate
	[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate);
    learningRate = learningRate * 0.75;
	clsRes = anncls(tvec, hlnn, olnn);
	cfmx = confMx(tlab, clsRes);
	errcf = compErrors(cfmx);
	trainError(epoch) = errcf(2);

	clsRes = anncls(tstv, hlnn, olnn);
	cfmx = confMx(tstl, clsRes);
	errcf2 = compErrors(cfmx);
	testError(epoch) = errcf2(2);
	epochTime = toc();
	[epoch epochTime trainError(epoch) testError(epoch)]
	% trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	[errcf errcf2]
	fflush(stdout);
end

disp('-----------------Test set results')
[(1:columns(testError))', testError']
clsRes = anncls(tstv, hlnn, olnn);
cfmx = confMx(tstl, clsRes);
[1:11 ; cfmx]
compErrors(cfmx)

disp('-----------------Training set results')
clsRes = anncls(tvec, hlnn, olnn);
cfmx = confMx(tlab, clsRes);
[1:11 ; cfmx]
compErrors(cfmx)
