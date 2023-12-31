% Dia chi cua anh tien hanh thi nghiem
file_name = 'hot-air-balloons.jpg';

% Chon loai nhoe cho anh
type = input('Chon loai nhoe mong muon \n(type = 1 - Gaussian Blur, type = 0 - Motion Blur): \ntype = ');

% Tao anh nhoe-nhieu tu anh goc
[original_image, blurred_image, noisy_image_1, noisy_image_2, noisy_image_3, PSF] = create_img(file_name, type);

% Hien thi anh goc va 3 anh nhieu
display = input('Hien thi anh nhieu da tao? \n(dispaly = 1 - co, dispaly = 0 - khong): \ndisplay = ');
if display == 1
    montage({original_image, noisy_image_1, noisy_image_2, noisy_image_3});
end
% Hien thi anh goc va 3 anh nhieu
noisy = input('Chon anh de khu nhieu? \n(noisy = 0 - anh khong nhieu, noisy = 1 - anh 10DB, noisy = 2 - anh 20DB, noisy = 3 - anh 28DB): \nnoisy = ');
if noisy == 0
    noisy_img = blurred_image;
elseif noisy == 1
    noisy_img = noisy_image_1;
elseif noisy == 2
    noisy_img = noisy_image_2;
else 
    noisy_img = noisy_image_3;
end
% Tien hanh khu nhieu, chon 1 trong 3 phuong phap
method = input('Chon phuong phap de khu nhieu? \n(method = 1 - InvConv, method = 2 - Tikhonov, method = 3 - Landweber): \nmethod = ');
if method == 1
    [mse,peaksnr, img] = inverse_conv(noisy_img, original_image, PSF);
elseif method == 2
    [mse,peaksnr, img] = regular_tik(noisy_img, original_image, PSF);
elseif method == 3
    [mse,peaksnr, img] = iteration_land(noisy_img, original_image, PSF);
end
