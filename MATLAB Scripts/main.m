function main()
global resize;
[sample sample2] = initialize();
backlit_test_image = imread('50_backlit_1.jpg');
frontlit_test_image = imread('50_frontlit_1.jpg');
denomination_type = find_denomination(backlit_test_image, sample);
segmentation_watermark(backlit_test_image, sample, denomination_type);
segmentation_demonination_marker(frontlit_test_image, denomination_type);
segmentation_lines(frontlit_test_image, denomination_type);
segmentation_signature(frontlit_test_image, sample2, denomination_type);
%segmentation_latent_image(frontlit_test_image, denomination_type);

end

    