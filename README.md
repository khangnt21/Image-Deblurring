Bài báo cáo trình bày cách tạo một ảnh nhoè từ một bức ảnh chất lượng và sử dụng ba phương pháp đề khử nhoè bức ảnh đó. 
Để đơn giản hoá bài toán, hướng tiếp cận của bài báo cáo là sử dụng ảnh đen-trắng (BW), tạo ảnh nhoè bằng một hàm nhoè `Gaussian` và hàm nhoè `motion`, thêm nhiễu Gaussian với hệ số PSNR xác định trước. 

Ba phương pháp sử dụng trong bài báo cáo là:

1. Sử dụng tích chập ngược của hàm nhoè.
2. Sử dụng phương pháp chuẩn hoá Tikhonov.
3. Sử dụng phương pháp lặp Landweber.
   
Sử dụng ba phương pháp trên đề khôi phục ảnh, đánh giá các phương pháp bằng sự sai khác với ảnh gốc với hàm MSE (Hàm sai số trung bình bình phương). 
Phương pháp tốt nhất sẽ có giá trị sai số MSE bé nhất, hoặc PSNR lớn nhất.

Để tiến hành tạo ảnh nhoè và khử nhoè, sử dụng MATLAB, xây dựng các phương pháp từ đầu và một số hàm đánh giá có sẵn trong thư viện của MATLAB.
