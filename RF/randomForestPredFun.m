function pred = randomForestPredFun(y,train,test,numTrees,depth)

    opts.numTrees = numTrees;
    opts.verbose  = true;
    opts.depth    = depth;
    
    rf = forestTrain(train,y,opts);
    
    pred = forestTest(rf,test,opts);
    
    save('Output/randomforest.mat','rf')

end