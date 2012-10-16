function knnTest()

    [y x] = loadData;
    
    nTrain = [500 1000 2000 4000 8000 16000 32000];
    nTest  = 100;

    k = 5;

    testidx = 40001 : 40001 + nTest;

    ytest = y(testidx);
    xtest = x(testidx,:);

    time  = zeros(size(nTrain));
    mcr   = zeros(size(nTrain));

    for i = 1:length(nTrain)

        fprintf('nTrain = %d\n',nTrain(i))

        trainidx = 1:nTrain(i);

        ytrain = y(trainidx);
        xtrain = x(trainidx,:);

        tic
        pred = knn(ytrain,xtrain,xtest,k);
        time(i) = toc;
        mcr(i) = mean(pred ~= ytest);

    end

    figure
    plot(nTrain,time,'.-')
    grid on
    ylabel('Time (seconds)')
    xlabel('No of training examples')

    figure
    plot(nTrain,mcr,'.-')
    grid on
    ylabel('Misclassification rate')
    xlabel('No of training examples')

    % [k m] = knnCrossval(ytrain,xtrain);
    
    % plot(k,m)

end