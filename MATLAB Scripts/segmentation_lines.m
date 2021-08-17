function segmentation_lines(to_test, denomination_type)
if (denomination_type > 10)
    to_test = im2double(to_test);
    %Crops lines region accordingly
    if (denomination_type == 50)
        to_test_cropped = imcrop(to_test, [686.5 1325.5 69 791]);
    elseif (denomination_type == 100)
        to_test_cropped = imcrop(to_test, [575.5 1307.5 45 785]);
    end
    %Applies sobel edge detection
    to_test_cropped = imadjust(rgb2gray(to_test_cropped));
    to_test_bw = edge(to_test_cropped, 'Sobel');
    
    %Applies morphological operations to polish result
    to_test_bw = imclose(to_test_bw, strel('square', 4));
    to_test_bw = bwmorph(to_test_bw, 'bridge');
    to_test_bw = imfill(to_test_bw, 'holes');
    to_test_bw = imdilate(to_test_bw, strel('square', 4));
    to_test_bw = imfill(to_test_bw, 'holes');
    
    %Finds number of lines
    [l, n] = bwlabel(to_test_bw);
    figure, imshow(to_test_bw);
    
    %Decides if counterfeit or not
    if (n == 34)
       disp('Legit currency bill 3');
    else
        disp('Counterfeit Bill');
    end
    
end

end