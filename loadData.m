function [ytrain xtrain xtest] = loadData

    load('Data/data.mat','ytrain','xtrain','xtest');
    
    ytrain = single(ytrain); %#ok
    xtrain = single(xtrain); %#ok
    xtest = single(xtest);   %#ok

end