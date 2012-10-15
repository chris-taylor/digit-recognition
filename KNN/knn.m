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

    % Compute distances

    dist = zeros(ntest,ntrain);

    for i = 1:ntest
        dist(i,:) = sum((repmat(test(i,:),ntrain,1) - train).^2,2);
    end

    % Make predictions

    pred = zeros(size(test,1),1);

    for i = 1:ntest
        [vec idx] = sort(dist(i,:));
        pred(i) = mode(double(y(idx(1:k))));
    end

    if isa(y,'nominal')
        pred = nominal(pred);
    end

end