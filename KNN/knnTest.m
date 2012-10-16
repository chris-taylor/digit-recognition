function [k m] = knnTest

    [ytrain xtrain] = loadData;
    
    [k m] = knnCrossval(ytrain,xtrain);
    
    plot(k,m)

end