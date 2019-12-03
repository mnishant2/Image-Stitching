function images=loadImages(folder,format,resize,rotate)

format=join(['*',format],'');

f=dir(fullfile(folder,format));
files={f.name};
images={};
for i=1:numel(files)
    filename=fullfile(folder,files{i});
    images{i}=imread(filename);
    if resize==1
        images{i}=imresize(images{i},0.5);
    end
    if rotate==1
        images{i}=imrotate(images{i},270);
    end
end
end
