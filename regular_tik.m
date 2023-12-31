%% regular_tik.m
function [mse,peaksnr, img] = regular_tik(noisy_image, original_image, PSF)
    [m,n] = size(original_image);
    % Bien doi Fourier cua cac ham can su dung
    noisy_fft = fft2(double(noisy_image));   
    PSF_fft = fft2(PSF, m, n);
    % Dieu chinh gia tri mu trong range trong doan [0,1] dong thoi tinh toan gia tri ham mat mat voi mu tuong ung.
    lossfn_mat = zeros(1,1000);
    mu_range = linspace(0,1,1000);
    for i = 1:1000
        mu = mu_range(i);
        K_fft = conj(PSF_fft) ./ (abs(PSF_fft).^2 + mu);
        tikhonov_fft = noisy_fft .* K_fft;
        tikhonov_image = ifft2(tikhonov_fft);
        err = immse(tikhonov_image, original_image) + mu*sum(tikhonov_image.^2,'all');
        lossfn_mat(i) = err;
    end
    
    % Chon mu gia tri lam ham mat mat nho nhat
    [min_mse, i] = min(lossfn_mat);
    mu = mu_range(i); % 0.0010
    
    % Quan sat su phu thuoc cua ham mat mat theo mu
    %plot(log(mu_range), lossfn_mat,'LineWidth',2)
    %hold on
    %plot(log(mu), min_mse,'o','LineWidth',2)
    %grid;
    %hold off
    
    % Xay dung bo loc khi da tim duoc mu toi uu
    Tik_filter = conj(PSF_fft) ./ (abs(PSF_fft).^2 + mu);
    
    % Nhan chap anh nhieu voi bo loc da thiet ke
    Tikhonov_fft = noisy_fft .* Tik_filter;
    Tikhonov_image = ifft2(Tikhonov_fft);
    
    % Loc nhieu nhe cho anh 
    Tikhonov_image = imgaussfilt(Tikhonov_image, 2);
    
    % Hien thi anh cung do sang, mau sac
    pix_ori = mean(original_image,'all');
    pix_res = mean(Tikhonov_image,'all');
    Tikhonov_image = Tikhonov_image*pix_ori/pix_res;

    % Hien thi anh phuc hoi va thong so MSE so voi anh goc
    figure;
    img = abs(Tikhonov_image);
    imshow(img);
    mse = immse(img, original_image)
    peaksnr = psnr(img,original_image)
end