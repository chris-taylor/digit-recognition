function pred = knn(y,train,test,k)
%KNN K nearest neighbors algorithm.
%
%Usage
%   predictions = knn(ytrain,xtrain,xtest,k);
%
%Inputs
%   y       training labels
%   train   training set
%   test    test set
%   k       the 'k' in k nearest-neighbor (can be a vector, in which case you get multiple predictions)

%Author: Chris Taylor

    % Input checking
    
    [ntrain mtrain] = size(train);
    [ntest mtest] = size(test);

    assert(mtrain == mtest);

    numk = length(k);

    % Compute distances and make predictions

    pred = zeros(ntest,numk);

    if numk == 1 && k == 1
        % Optimization for the case of k == 1
        for i = 1:ntest
            dist = sum(bsxfun(@minus,train,test(i,:)).^2,2);
            [junk idx] = min(dist);
            pred(i) = double(y(idx));
        end
    else
        for i = 1:ntest
            dist = sum(bsxfun(@minus,train,test(i,:)).^2,2);
            [junk idx] = sort(dist);
            % This loops speeds things up when we want to make predictions for multiple
            % different values of k (e.g. to do cross-validation to select the best value of k)
            for j = 1:numk
                pred(i,j) = mode(double(y(idx(1:k(j)))));
            end
        end
    end

    % Output formatting
    
    if isa(y,'nominal')
        pred = nominal(pred);
    end

end