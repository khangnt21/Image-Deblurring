%% inverse_conv.m
function [mse,peaksnr, img] = inverse_conv(noi_img, ori_img, PSF)
    
    % m, n la kich thuoc anh goc
    [m,n] = size(ori_img);
    
    % Bien doi Fourier cua cac ham can su dung
    noi_fft = fft2(double(noi_img));  
    PSF_fft = fft2(PSF, m, n);
    
    % Uoc luong anh bang theo cong thuc (13)
    res_img_fft = noi_fft ./ PSF_fft;
    res_img = ifft2(res_img_fft);
    
    % Hien thi anh cung do sang, mau sac
    res_img = recolored(ori_img, res_img);
    % Hien thi anh uoc luong va danh gia ham MSE so voi anh go
    img = abs(res_img);
    imshow(img);
    mse = immse(img, ori_img); % = 0.5250
    peaksnr = psnr(img,ori_img);
end