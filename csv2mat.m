function [ytrain xtrain xtest] = csv2mat()

    px = 28; % Number of pixels per side

    % Read data from csv

    trainid = fopen('Data/train.csv');
    testid  = fopen('Data/test.csv');

    trainfmt = repmat('%d ',1,px*px+1);
    testfmt  = repmat('%d ',1,px*px);

    ctrain = textscan(trainid,trainfmt,'HeaderLines',1,'Delimiter',',');
    ctest  = textscan(testid,testfmt,'HeaderLines',1,'Delimiter',',');

    % Assign data to matlab array

    ntrainsamples = length(ctrain{1});
    ntestsamples = length(ctest{1});

    ytrain = single(zeros(ntrainsamples,1));
    xtrain = single(zeros(ntrainsamples,px*px));
    xtest  = single(zeros(ntestsamples,px*px));

    ytrain = ctrain{1};

    for j = 1:px*px
        xtrain(:,j) = ctrain{j+1};
        xtest(:,j)  = ctest{j};
    end

    % Data validation

    assert(all(ytrain > -1 & ytrain < 10))
    assert(all(all(xtrain > -1 & xtrain < 256)))
    assert(all(all(xtest > -1 & xtest < 256)))

    % Save

    save('Data/data.mat','ytrain','xtrain','xtest');

end