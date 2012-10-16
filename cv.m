function loss = cv(lossmeasure,y,X,predfun)
%CV Perform k-fold cross validation.
%
%Usage
%   loss = cv('mse',y,X,predfun)
%   loss = cv('mcr',y,X,predfun)
%
%Here predfun returns a vector of predictions for the test set
%
%   predfun(ytrain,xtrain,xtest)
%

%Author: Chris Taylor

    kfold = 10;
    
    T = size(X,1);
    
    sz = fix(T/kfold);
    
    loss = zeros(kfold,1);
    
    indices = randperm(T);
    
    for i = 1:kfold
       
        test  = indices((i-1) * sz + (1:sz));
        train = setdiff(indices,test);
        
        Xtrain = X(train,:);
        Xtest  = X(test,:);
        Ytrain = y(train);
        Ytest  = y(test);
        
        Ypred = predfun(Ytrain,Xtrain,Xtest);
        
        switch lossmeasure
            case 'mcr'
                loss(i) = mean(Ypred ~= Ytest);
            case 'mse'
                loss(i) = norm(Ypred - Ytest);
        end
        
    end
    
    loss = mean(loss);

end