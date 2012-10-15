function [kvals mcr] = knnCrossval(y,X,SILENT)
%KNNCROSSVAL Perform cross-validation to select a good value of K for
%the K nearest-neighbor algorithm.

%Author: Chris Taylor

    if nargin < 3
        SILENT = false;
    end

    kvals = 10:10:100;
    
    mcr = zeros(size(kvals));
    
    for i = 1:length(kvals)
       
        k = kvals(i);
        
        if ~SILENT
            fprintf('k = %d\n',k);
        end
        
        predfun = @(xtrain,ytrain,xtest) knn(ytrain,xtrain,xtest,k);
        
        mcr(i) = crossval('mcr',X,y,'Predfun',predfun);
        
    end

end