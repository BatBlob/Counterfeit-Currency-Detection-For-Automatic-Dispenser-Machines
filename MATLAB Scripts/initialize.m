function [output1 output2] = initialize()
global resize;

resize_10 = [size(imread('10_backlit_1.jpg'),1) size(imread('10_backlit_1.jpg'),2)];
resize_50 = [size(imread('50_backlit_1.jpg'),1) size(imread('50_backlit_1.jpg'),2)];
resize_100 = [size(imread('100_backlit_1.jpg'),1) size(imread('100_backlit_1.jpg'),2)];
resize = {resize_10 resize_50 resize_100};

%Construst sample of backlit notes
samples = 2;
ten = imresize(double([0]), resize{1});
fifty = imresize(double([0]), resize{2});
hundred = imresize(double([0]), resize{3});

for i=1:samples
    current = im2double(imread(sprintf('10_backlit_%d.jpg',i)));
    current = imresize(current, resize{1});
    ten = ten + current;
    
    current = im2double(imread(sprintf('50_backlit_%d.jpg', i)));
    current = imresize(current, resize{2});
    fifty = fifty + current;
    
    current = im2double(imread(sprintf('100_backlit_%d.jpg',i)));
    current = imresize(current, resize{3});
    hundred = hundred + current;
end

output1 = {ten/samples fifty/samples hundred/samples};

%Constructs sample of frontlit notes and their signature
sample2 = {[1262.5 1661.5 206 71] [1173.5 1677.5 213 53] [1055.5 1675.5 210 50]};
to_read = {'10_frontlit_1.jpg' '50_frontlit_1.jpg' '100_frontlit_1.jpg'};
output2 = {[] [] []};
for i=1:3
    sample_test = imcrop(im2double(imread(to_read{i})), sample2{i});
    sample_test = imadjust(rgb2gray(sample_test));
    sample_test = sample_test<=0.33;
    sample_test = edge((sample_test), 'canny');
    sample_test = bwmorph(sample_test, 'bridge');
    sample_test = imfill(sample_test, 'holes');
    sample_test = bwareaopen(sample_test, 22);
    bound = boundaries(sample_test, 8);
    d = cellfun('length', bound);
    final = [];
    for j = 1:size(bound)
        b = bound{j};
        [st, angle] = signature(b);
        final = [final size(angle,1)];
    end
    output2{i} = final;
end

end