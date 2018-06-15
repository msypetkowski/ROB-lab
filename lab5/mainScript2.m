vnames = {
'valid_1.txt', 
'valid_2.txt',
'valid_3.txt', 
'valid_4.txt', 
'valid_5.txt', 
'valid_6.txt', 
'valid_7.txt'};

tnames = {
'test_1.txt', 
'test_2.txt', 
'test_3.txt', 
'test_4.txt', 
'test_5.txt', 
'test_6.txt', 
'test_7.txt'};
	
vtab = loadCNNOutputs(vnames, true);
load validlab.txt
validlab = validlab + 1;

ttab = loadCNNOutputs(tnames, true);
load testlab.txt
testlab = testlab + 1;


threshold = 0.79
% threshold = 0.95

disp('------------------- simply thresholding probabilities')
[ max_values answers ] = max(vtab, [], 2);
answers(max_values < threshold) = 11;
confmx = confMx(validlab, answers);
errcfs = compErrors(confmx);
output_precision(2)
resVald = [errcfs fobj(errcfs)] * 100

[ max_values answers ] = max(ttab, [], 2);
answers(max_values < threshold) = 11;
confmx = confMx(testlab, answers);
errcfs = compErrors(confmx);
output_precision(2)
resTest = [errcfs fobj(errcfs)] * 100
