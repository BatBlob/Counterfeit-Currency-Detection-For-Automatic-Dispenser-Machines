function segmentation(to_test, sample, denomination_type)

global resize;
to_test = im2double(to_test);

%Crops watermark region accordingly
if (denomination_type == 10)
    test_c = imcrop(to_test, [258.5 65.5 327 277]);
    diff = imcrop(sample{1}, [258.5 65.5 327 277]);
elseif (denomination_type == 50)
    test_c = imcrop(to_test, [244.5 65.5 381 282]);
    diff = imcrop(sample{2}, [244.5 65.5 381 282]);
elseif (denomination_type == 100)
    test_c = imcrop(to_test, [242.5 48.5 330 306]);
    diff = imcrop(sample{3}, [242.5 48.5 330 306]);
end

figure, imshow(test_c);

difference = 0;

%Compares watermark difference with stored samples
for i = 1:3
    difference = difference + norm(diff(:,:,i) - test_c(:,:,i));
end

difference = difference / 3;

%Decides if similar enough
if (difference < 7)
    disp('Legit currency bill 1');
else
    disp('Counterfeit bill 1');
end

end