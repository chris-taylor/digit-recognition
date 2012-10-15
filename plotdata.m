function plotData(data)

    n  = 15;
    px = 28;

    img = zeros(px*n,px*n);

    for i = 1:n
        for j = 1:n
            x = data((i-1)*n+j,:);
            img((i-1)*px + (1:px), (j-1)*px + (1:px)) = reshape(x,px,px)';
        end
    end

    imagesc(img)
    colormap('gray')

end