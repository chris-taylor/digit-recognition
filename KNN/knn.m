function pred = knn(y,train,test,k)
%KNN K nearest neighbors algorithm.
%
%Usage
%   predictions = knn(ytrain,xtrain,xtest,k);
%

%Author: Chris Taylor

    % Input checking
    
    [ntrain mtrain] = size(train);
    [ntest mtest] = size(test);

    assert(mtrain == mtest);

    % Compute distances and make predictions

    pred = zeros(ntest,1);

    for i = 1:ntest
        dist = sum((repmat(test(i,:),ntrain,1) - train).^2,2);
        [vec idx] = sort(dist);
        pred(i) = mode(double(y(idx(1:k))));
    end

    % Output formatting
    
    if isa(y,'nominal')
        pred = nominal(pred);
    end

end