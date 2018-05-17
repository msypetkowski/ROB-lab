[tvec tlab tstv tstl] = readSets(); 
tlab += 1;
tstl += 1;

% remove columns with zero std 
toRemain = std(tvec) != 0;
tvec = tvec(:, toRemain);
tstv = tstv(:, toRemain);

% store data for normalization
mu = mean(tvec);
sig = std(tvec);

noHiddenNeurons = 200;
noEpochs = 5;
learningRate = 0.005;

rand()
rstate = rand("state");
save rnd_state.txt rstate
%load rndstate.txt 
%rand("state", rndstate);

% no normalization
[hlnn olnn] = crann(columns(tvec), noHiddenNeurons, 10);
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
trReport = [];
for epoch=1:noEpochs
	tic();
	[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, learningRate);
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
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	[errcf errcf2]
	fflush(stdout);
end
