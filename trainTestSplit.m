function [ytrain xtrain ytest xtest] = trainTestSplit(y,x,proportion)
%TRAINTESTSPLIT Split some labelled data into a training/test set.
%
%Usage
%   [ytrain xtrain ytest xtest] = trainTestSplit(y,x,proportion)
%
%Inputs
%   y           response variable
%   x           design matrix
%   proportion  Proportion of the data to put into the training set (defaults to 0.5)
%

%Author: Chris Taylor

    if nargin < 3
        proportion = 0.5;
    end

    T   = size(x,1);
    idx = randperm(T);

    trainidx = idx(1 : round(proportion*T));
    testidx  = idx(round(proportion*T)+1 : end);

    ytrain = y(trainidx);
    xtrain = x(trainidx,:);

    ytest = y(testidx);
    xtest = x(testidx,:);

end