function y = shuffle(x)
%SHUFFLE Random shuffle vectors
    y = x(randperm(length(x)));
end