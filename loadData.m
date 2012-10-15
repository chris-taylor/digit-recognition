function [ytrain xtrain xtest] = loadData

    load('Data/data.mat','ytrain','xtrain','xtest');
    
    ytrain = double(ytrain); %#ok
    xtrain = double(xtrain); %#ok
    xtest = double(xtest);   %#ok

end