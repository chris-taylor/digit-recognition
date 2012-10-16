function randomForestMaster(dopca)

    if nargin < 1
        dopca = true;
    end

    [y train test] = loadData;
   
    if dopca
        [train coeff] = pcaReduce(train,0.9);
        test = test * coeff; %#ok
    end
    
    [ytrain xtrain ytest xtest] = trainTestSplit(y,train,0.9);
    
    % Test num of trees
    
    numTrees = [100 200 400 600 800 1000];
    depth    = repmat(5,1,length(numTrees));
    
    err = runTest(ytrain,xtrain,ytest,xtest,numTrees,depth);
    
    figure
    plot(numTrees,err)
    grid on
    xlabel('Number of trees')
    ylabel('Error rate')
    drawnow
    
    % Test depths
    
%     depth    = 1:10;
%     numTrees = repmat(100,1,length(depth));
%     
%     err = runTest(ytrain,xtrain,ytest,xtest,numTrees,depth);
%     
%     figure
%     plot(depth,err)
%     grid on
%     xlabel('Number of trees')
%     ylabel('Error rate')
%     drawnow
        
    
    
%     pred = randomForestPredFun(y,train,test);
%     
%     csvwrite('Output/randomforestpredict.csv',pred);
    
end

function err = runTest(ytrain,xtrain,ytest,xtest,numTrees,depth)
    assert(length(numTrees) == length(depth))
    err = zeros(length(numTrees),1);
    for i = 1:length(numTrees)
        pred = randomForestPredFun(ytrain,xtrain,xtest,numTrees(i),depth(i));
        err(i) = mean(pred ~= ytest);
        fprintf('ERROR RATE: %.2f%%\n',100*err(i))
    end
end