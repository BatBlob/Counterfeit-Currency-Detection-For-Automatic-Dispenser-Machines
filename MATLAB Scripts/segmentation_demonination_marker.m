function segmentation_demonination_marker(to_test, denomination_type)
if (denomination_type > 10)
    to_test = im2double(to_test);
    
    %Crops demonination marker region accordingly
    if (denomination_type == 50)
        to_test_cropped = imcrop(to_test, [971.5 1920.5 87 86]);
    elseif (denomination_type == 100)
        to_test_cropped = imcrop(to_test, [852.5 1867.5 73 109]);
    end
    %Applies sobel edge detection
    to_test_cropped = imadjust(rgb2gray(to_test_cropped));
    to_test_bw = edge(to_test_cropped, 'Sobel');
    
    %Applies morphological operations to polish result
    to_test_bw = imclose(to_test_bw, strel('square', 4));
    to_test_bw = bwareaopen(to_test_bw, 20);
    to_test_bw = bwmorph(to_test_bw, 'bridge');
    to_test_bw = imfill(to_test_bw, 'holes');
    
    figure, imshow(to_test_bw);
    
    %Finds area of denomination marker signs
    [labeledImage, numberOfObject] = bwlabel(to_test_bw);
    area = 0;
    for i = 1:numberOfObject
        region = labeledImage == i;
        region_props = regionprops(region, 'Area');
        area = area + region_props.Area;
    end
    
    %Decides if counterfeit or not
    if (denomination_type == 50)
        if (area > 845 && area < 945 && numberOfObject == 2)
            disp('Legit Bill 2');
        else
            disp('Counterfeit Bill');
        end
    elseif (denomination_type == 100)
        if (area > 1350 && area < 1450 && numberOfObject == 3)
            disp('Legit Bill 2');
        else
            disp('Counterfeit Bill');
        end
    end
    
end

end