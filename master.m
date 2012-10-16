function master()
%MASTER Master function. Reads in data, processes it, runs learning algorithms to classify the test
%cases and outputs the result to a file.

    % Load the training/test data

    [y xtrain xtest] = loadData;

    % Plot sample to check

    plotData(xtrain);
    title('Training data (sample)')

    % Do PCA reduction

    [wtrain coeff] = pcaReduce(xtrain,0.9); % Keep 90% of the variance

    wtest = xtest * coeff;

    % KNN classifier

    k = 1;

    pred = knn(y,wtrain,wtest,k); % This takes about 10-15 minutes

    % Write output to disk

    if ~exist('Output','dir')
        mkdir('Output')
    end

    csvwrite('Output/predictions.csv',pred);

end