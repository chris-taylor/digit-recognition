function plotData(data)

    n  = 15;
    px = 28;

    img = zeros(px*n,px*n);

    T = size(data,1);
    ii = 0;

    for i = 1:n
        for j = 1:n
            ii = ii + 1;
            if ii > T
                img((i-1)*px + (1:px), (j-1)*px + (1:px)) = 0;
            else
                x = data((i-1)*n+j,:);
                img((i-1)*px + (1:px), (j-1)*px + (1:px)) = reshape(x,px,px)';
            end
        end
    end

    imagesc(img)
    colormap('gray')

end