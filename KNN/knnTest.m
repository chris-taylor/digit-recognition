function mcr = knnTest

    [ytrain xtrain] = loadData;
    
    trainidx = randi(42000,1000,1);
    testidx = randi(42000,1000,1);
    
    x1 = xtrain(trainidx,:);
    x2 = xtrain(testidx,:);
    
    y1 = ytrain(trainidx,:);
    y2 = ytrain(testidx,:);
    
    k = 10;
    
    pred = knn(y1,x1,x2,k);
    
    keyboard
    
    mcr = mean(pred ~= y2);
    
    [k m] = knnCrossval(y1,x1);
    
    plot(k,m)

end