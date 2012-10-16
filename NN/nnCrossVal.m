function [best_net numepochs] = nnCrossVal(ytrain,xtrain,ytest,xtest)

    opts.batchsize = 100;
    opts.numepochs = 10;

    maxepochs = 500;

    K = size(xtrain,2);
    L = 10;  % Number of classes
    H = 100; % Number of hidden units

    % Set up response variable
    ztrain = zeros(length(ytrain),L);
    for i = 1:L
        loc = ytrain == i - 1;
        ztrain(loc,i) = 1;
    end

    ztest = zeros(length(ytest),L);
    for i = 1:L
        loc = ytest == i - 1;
        ztest(loc,i) = 1;
    end

    % Set up neural network
    net = nnsetup([K H L]);

    % Neural net training loop
    er = Inf;

    ii = 0;
    numepochs = 0;

    train_er = [];
    test_er  = [];

    while true

        % Train the network for one more epoch
        net = nntrain(net,xtrain,ztrain,opts);
        new_er = nntest(net,xtest,ztest);

        % Record errors
        ii = ii + 1;
        numepochs = numepochs + opts.numepochs;
        train_er(end+1) = net.rL(end);
        test_er(end+1)  = new_er;

        fprintf('No. epochs: %d, error rate: %.2f%%\n',numepochs,100*new_er)

        if isnan(net.rL(end)) || isnan(new_er)
            error('Measured error is NaN')
        elseif new_er > 1.2 * er
            disp('Training set error is increasing')
            break
        elseif numepochs > maxepochs
            disp('Max epochs reached')
            break
        elseif new_er < er
            er       = new_er;
            best_net = net;
        end

    end

    plot(opts.numepochs * (1:ii), [train_er; test_er]')
    xlabel('Number of epochs')
    ylabel('Misclassification rate')
    legend({'Training Set','Test Set'})
    grid on

end