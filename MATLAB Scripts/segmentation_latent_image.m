function segmentation_latent_image(to_test, denomination_type)
if (denomination_type > 10)
    %Crops region of latent image accordingly
    if (denomination_type == 50)
        to_test_cropped = imcrop(to_test, [1974.5 1547.5 185 268]);
    elseif (denomination_type == 100)
        to_test_cropped = imcrop(to_test, [1845.5 1513.5 182 311]); 
    end
    
    %Applies operations to segment region properly
    to_test_cropped = imrotate(to_test_cropped, -91);
    to_test_cropped = rgb2gray(to_test_cropped);
    to_test_cropped = imadjust(to_test_cropped);
    sobel_h = fspecial('sobel');
    to_test_bw = imfilter(to_test_cropped, sobel_h);
    to_test_bw = to_test_bw == 255;
    str_el = strel('line',3,0);
    to_test_op = imopen(to_test_bw,str_el);
    to_test_re = imreconstruct(to_test_op,to_test_bw);
    to_test_inv = to_test_re == 0;
    final = imopen(to_test_inv, strel('disk',8));
    final = imclose(final, strel('disk',10));
    
    figure, imshow(final), title('Latent Image Segmentation Result');
end