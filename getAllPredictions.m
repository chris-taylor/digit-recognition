function y = getAllPredictions(dirname)

    if nargin < 1
        dirname = 'Output';
    end

    contents  = dir(dirname);
    filenames = {contents.name};
    c         = regexp(filenames,'.csv');
    idx       = ~cellfun(@isempty,c);
    filenames = filenames(idx);
    
    for i = 1:length(filenames)
       
        y(:,i) = csvread(fullfile(dirname,filenames{i})); %#ok
        
    end

end