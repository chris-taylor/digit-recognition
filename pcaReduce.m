function [W coeff] = pcaReduce(X,thresh)
%PCAREDUCE Given a design matrix, reduce its dimensionality using principal components.
%
%Usage
%   [W coeff] = pcaReduce(X,thresh)
%
%This gives you a reduced data set W, and a set of transformation coefficients coeff. You go back
%and forth between the reduced and raw representations with
%
%   >> W = X * coeff;
%   >> X = W * coeff';
%
%Inputs
%   X       Design matrix
%   thresh  Amount of variance to keep (between 0 and 1)

%Author: Chris Taylor

    C = cov(X);

    [coeff latent explained] = pcacov(C);

    % Select the significant components

    idx = cumsum(explained) < 100 * thresh;
    coeff = coeff(:,idx);

    % Get reduced data set

    W = X * coeff;

end