%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               PixelRedux                 %
%                                          %
%      Digital Image Processing Part       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% Parameter selection

n = 3; % 6/64
img_path = 'Lisboa.jpeg';

%% Generation of the mask

mask = zeros(8, 8);
for i = 1:1:n
    for j = 1:n
        if (i+j) < (n+2)
            mask(i, j) = 1;
        end
    end
end

%% Mask verification

disp(mask)

%% Load the image

img = imread(img_path);
img = im2double(img);

%% If the image is RGB -> Grayscale

if size(img, 3) == 3
    img = rgb2gray(img);
end

%% View the original image

figure;
imshow(img);
title('Original');

%% 8x8 DCT

mask_size = [8 8];
dct = @(block_struct) dct2(block_struct.data);
img_dct = blockproc(img, mask_size, dct);

figure;
imshow(img_dct);
title('8x8 DCT');

%% Compression

comp = @(block_struct) mask .* block_struct.data;
img_comp = blockproc(img_dct, mask_size, comp);

% Save the compressed image
imwrite(img_comp, 'compressed_image.jpg');

% Display the size of the compressed image
compressed_info = dir('compressed_image.jpg');
compressed_size_kb = compressed_info.bytes / 1024;
disp(['Size of Compressed Image: ', num2str(compressed_size_kb), ' KB']);

figure;
imshow(img_comp);
title('Compression');

%% Decompression
inverse_dct = @(block_struct) idct2(block_struct.data);
img_des = blockproc(img_comp, mask_size, inverse_dct);

% Save the decompressed image
imwrite(img_des, 'decompressed_image.jpg');

% Display the size of the decompressed image
decompressed_info = dir('decompressed_image.jpg');
decompressed_size_kb = decompressed_info.bytes / 1024;
disp(['Size of Decompressed Image: ', num2str(decompressed_size_kb), ' KB']);

figure;
imshow(img_des);
title('Decompression');
%% Original Image
original_img = imread(img_path);
original_img = im2double(original_img);

% Display the size of the original image
original_size_kb = numel(original_img) / 1024;
disp(['Size of Original Image: ', num2str(original_size_kb), ' KB']);

%% PSNR and SSIM for Original Image
psnr_original = psnr(original_img, original_img);
ssim_original = ssim(original_img, original_img);
disp(['PSNR for Original Image: ', num2str(psnr_original)]);
disp(['SSIM for Original Image: ', num2str(ssim_original)]);

%% PSNR and SSIM for Compressed Image
psnr_compressed = psnr(img_comp, original_img);
ssim_compressed = ssim(img_comp, original_img);
disp(['PSNR for Compressed Image: ', num2str(psnr_compressed)]);
disp(['SSIM for Compressed Image: ', num2str(ssim_compressed)]);

%% PSNR and SSIM for Decompressed Image
psnr_decompressed = psnr(img_des, original_img);
ssim_decompressed = ssim(img_des, original_img);
disp(['PSNR for Decompressed Image: ', num2str(psnr_decompressed)]);
disp(['SSIM for Decompressed Image: ', num2str(ssim_decompressed)]);

%% Plotting
labels = {'Original', 'Compressed', 'Decompressed'};
psnr_values = [psnr_original, psnr_compressed, psnr_decompressed];
ssim_values = [ssim_original, ssim_compressed, ssim_decompressed];

figure;

subplot(2, 1, 1);
bar(psnr_values);
title('PSNR Comparison');
xlabel('Image Type');
ylabel('PSNR');
set(gca, 'XTickLabel', labels);

subplot(2, 1, 2);
bar(ssim_values);
title('SSIM Comparison');
xlabel('Image Type');
ylabel('SSIM');
set(gca, 'XTickLabel', labels);

sgtitle('Image Quality Metrics Comparison');