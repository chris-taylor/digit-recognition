function nnMaster(dopca)

    retainedVar       = 0.9;

    if nargin < 1
        dopca = 1;
    end

    [y train test] = loadData;
    
    if dopca
        [train coeff] = pcaReduce(train,retainedVar);
        test = test * coeff;
    end
    
    pred = nnPredFun(y,train,test);
    
    csvwrite('Output/neuralnetpredictions.csv',pred)

end