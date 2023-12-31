function [mse,peaksnr, img] = iteration_land(noisy_image, original_image, PSF)
    % Thiet lap so lan lap va he so learning rate tau

    num_iterations = linspace(1,1000,1000);
    tau = 0.1;
    
    % Bat dau voi anh nhieu nhoe, sau tung buoc cai thien anh va giam sai so
    land_image = noisy_image; 
    for i = num_iterations
        % Tinh dao ham cua ham mat mat, gradient = (A^*g-A^*A\tilde{f}_{k})
        gradient = imfilter(original_image, conj(PSF) , 'conv', 'circular') - imfilter(imfilter(land_image, PSF, 'conv', 'circular'), conj(PSF), 'conv', 'circular') ;
        % Cap nhat buc anh moi theo cong thuc uoc luong (16)
        land_image = land_image + tau * gradient;
    end
    
    % Loc nhoe nhe cho anh, hien thi anh khoi phuc va tham so MSE so voi anh goc
    land_image = imgaussfilt(land_image, 5);
    img = abs(land_image);
    figure;
    imshow(img);
    mse = immse(img, original_image)
    peaksnr = psnr(img,original_image)
end