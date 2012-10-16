function pred = nnPredFun(y,train,test)
    
    filename = 'Output/neuralnet.mat';
    
    try
        load(filename,'net')
    catch e %#ok
        opts.batchsize = 100;
        opts.numepochs = 500;

        K = size(train,2);
        L = 10;
        H = 100;

        y1 = zeros(length(y),L);
        for i = 1:L
            idx = y == i - 1;
            y1(idx,i) = 1;
        end

        net = nnsetup([K H L]);
        net = nntrain(net,train,y1,opts);

        save('Output/neuralnet.mat','net');
    end
    
    pred = nnpredict(net,test) - 1;
    
end