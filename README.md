# PixelRedux - Digital Image Processing

## Overview
```markdown
PixelRedux is a MATLAB-based digital image processing project that implements an 8x8 Discrete Cosine Transform (DCT) for image compression and decompression. The project evaluates the quality of compression using PSNR (Peak Signal-to-Noise Ratio) and SSIM (Structural Similarity Index Measure).
```

## Features
```markdown
- Converts an image to grayscale (if RGB)
- Applies an 8x8 DCT transformation
- Compresses the image using a mask
- Decompresses the image using an inverse DCT
- Compares original, compressed, and decompressed images
- Computes and visualizes PSNR and SSIM values
```

## Prerequisites
```markdown
- MATLAB installed on your system
- An image file (default: `Lisboa.jpeg`)
```

## Usage
```markdown
1. Place your image in the project directory.
2. Update the `img_path` variable with your image filename if needed.
3. Run the script in MATLAB.
4. View the results, including compressed and decompressed images.
```

## Files
```markdown
- `PixelRedux.m`: Main MATLAB script for processing images
- `compressed_image.jpg`: The compressed image output
- `decompressed_image.jpg`: The decompressed image output
- `Lisboa.jpeg`: Sample input image (not included)
```

## Outputs
```markdown
- **Compressed Image Size:** Displayed in KB
- **Decompressed Image Size:** Displayed in KB
- **PSNR & SSIM Values:** Compared for original, compressed, and decompressed images
- **Graphical Comparison:** PSNR and SSIM values plotted for easy visualization
```

## Example Mask
```matlab
mask = zeros(8, 8);
for i = 1:n
    for j = 1:n
        if (i+j) < (n+2)
            mask(i, j) = 1;
        end
    end
end
```

## Quality Metrics
```markdown
- **PSNR (Peak Signal-to-Noise Ratio)**: Measures image quality degradation
- **SSIM (Structural Similarity Index Measure)**: Evaluates structural similarity between images
```

## Acknowledgments
```markdown
Developed as part of a Digital Image Processing study to explore lossy image compression techniques by Bhavay and Adarsh.
```

