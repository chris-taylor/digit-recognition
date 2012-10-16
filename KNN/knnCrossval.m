function [kvals mcr] = knnCrossval(y,X,SILENT)
%KNNCROSSVAL Perform cross-validation to select a good value of K for
%the K nearest-neighbor algorithm.

%Author: Chris Taylor

    if nargin < 3
        SILENT = false;
    end

    kvals = 1:10;
    numk  = length(kvals);
    
    mcr = zeros(size(kvals));

    % Cross validation loop

    kfold   = 5;
    T       = size(X,1);
    sz      = fix(T/kfold);
    loss    = zeros(kfold,numk);
    indices = randperm(T);

    for i = 1:kfold
        
        if ~SILENT
            fprintf('kfold = %d\n',i);
        end
       
        test  = indices((i-1) * sz + (1:sz));
        train = setdiff(indices,test);
        
        Xtrain = X(train,:);
        Xtest  = X(test,:);
        Ytrain = y(train);
        Ytest  = y(test);

        Ypred  = knn(Ytrain,Xtrain,Xtest,kvals);

        for j = 1:length(kvals)
            loss(i,j) = mean(Ypred(:,j) ~= Ytest);
        end
        
    end

    mcr = mean(loss);

end