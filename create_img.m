function [original_image, blurred_image , noisy_image_1, noisy_image_2, noisy_image_3, PSF] = create_img(file_name, type)
    % Doc anh chat luong ca0
    original_image_rgb = imread(file_name);
    original_image = im2double(rgb2gray(original_image_rgb));
    if type == 0
        PSF = fspecial('motion', 60, 20);
    % Ham nhoe Gaussian PSF co size [5,5], voi do nhoe sigma = 2
    else 
        PSF = fspecial('gaussian', [5, 5], 2);
    end
    % Ap dung anh nhoe voi ham nhoe PSF
    blurred_image = imfilter(original_image, PSF, 'conv', 'circular');
    
    % Them nhieu vao anh thay doi gia tri phuong sai nhieu de cai dat anh co PSNR mong muon
    n_var = [0.0001 0.0009 0.17];
    noisy_image_1 = imnoise(blurred_image, 'gaussian', 0, n_var(1));
    noisy_image_2 = imnoise(blurred_image, 'gaussian', 0, n_var(2));
    noisy_image_3 = imnoise(blurred_image, 'gaussian', 0, n_var(3));
end