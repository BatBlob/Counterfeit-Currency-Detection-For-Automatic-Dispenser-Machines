function output = find_denomination(to_test, sample)
global resize;
to_test = im2double(to_test);

for sample_n = 1:size(sample,2)
    percentDiff = [0 0 0];
    for i = 1:3
        to_test_temp = imresize(to_test, resize{sample_n});
        percentDiff(i) = norm(sample{sample_n}(:,:,i) - to_test_temp(:,:,i)); %Calculates difference against stored samples
    end
    if (percentDiff(1) < 30 && percentDiff(2) < 30 && percentDiff(3) < 30) %Checks if difference is within threshold

        switch sample_n %Assigns denomination accordingly
            case 1
                output = 10;
            case 2
                output = 50;
            case 3
                output = 100;
        end
        break;
    end
end
fprintf('Currency denomination = %d\n',output);
end