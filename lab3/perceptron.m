function [sepplane fp fn] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% fp - false positive count (i.e. number of misclassified samples of pclass)
% fn - false negative count (i.e. number of misclassified samples of nclass)

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  tset = [ ones(rows(pclass), 1) pclass; -ones(rows(nclass), 1) -nclass];
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples

  i = 1;

  % for stop criterion
  bestResult = sum((tset * (sepplane')) < 0);
  notImprovedIterationCounter = 0;

  do 
    %% 1. Check which samples are misclassified (boolean column vector)
    bad = (tset * (sepplane')) < 0;

    %% 2. Compute separating plane correction 
    %%      This is sum of misclassfied samples coordinate times learning rate 
    correction = sum(tset(bad, :)) * 0.001;

    %% 3. Modify solution (i.e. sepplane)
    sepplane = sepplane .+ correction;

    %% 4. Optionally you can include additional conditions to the stop criterion
    %%      200 iterations can take a while and probably in most cases is unnecessary
    newResult = sum(bad);
    if newResult >= bestResult
      notImprovedIterationCounter = notImprovedIterationCounter + 1;
    else
      notImprovedIterationCounter = 0;
      bestResult = newResult;
    endif

    if notImprovedIterationCounter > 15;
      break
    endif


    ++i;
  until i > 1000;

  % compute the numbers of false positives and false negatives
  bad = (tset * (sepplane')) < 0;
  sum(bad);
  fp = sum(tset(bad, 1) == -1) / rows(tset);
  fn = sum(tset(bad, 1) == 1) / rows(tset);
