function segmentation_signature(to_test, sample, denomination_type)

to_test = im2double(to_test);

%Crops governer signature region accordingly
if (denomination_type == 10)
    to_test_cropped = imcrop(to_test, [1262.5 1661.5 206 71]);
    sample = sample{1};
elseif (denomination_type == 50)
    to_test_cropped = imcrop(to_test, [1173.5 1677.5 213 53]);
    sample = sample{2};
elseif (denomination_type == 100)
    to_test_cropped = imcrop(to_test, [1055.5 1675.5 210 50]);
    sample = sample{3};
end

%Applies canny edge detection and morphological operations
sig = imadjust(rgb2gray(to_test_cropped));
sig = sig<=0.33;
to_test_bw = edge((sig), 'canny');
to_test_bw = bwmorph(to_test_bw, 'bridge');
to_test_bw = imfill(to_test_bw, 'holes');
img_test = bwareaopen(to_test_bw, 22);

figure, imshow(img_test);

%Extracts signature of segmented objects
bound = boundaries(img_test, 8);
d = cellfun('length', bound);
[M, N] = size(img_test);

final = [];
for i = 1:size(bound)
    b = bound{i};
    [st, angle] = signature(b);
    final = [final size(angle,1)];

end

%Finds difference of signature against stored sample
diff = 0;
for i=1:min(size(final, 2),size(sample, 2))
    diff = diff + abs(final(i) - sample(i));
end
diff = diff / min(size(final, 2),size(sample, 2));

%Decides if counterfeit or not
if ((min(size(final, 2),size(sample, 2)) == 9 || min(size(final, 2),size(sample, 2)) == 10) && diff < 50)
    disp('Legit Bill 4');
else
    disp('Counterfeit Bill 4');
end
end

