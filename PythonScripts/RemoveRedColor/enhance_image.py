import cv2
import numpy as np


def enhance_image(input_image):
    # Read input image file
    input_img = cv2.imread(input_image, cv2.IMREAD_COLOR)

    # Apply open morphology to fill white dots in black characters
    # https://docs.opencv.org/2.4/doc/tutorials/imgproc/opening_closing_hats/opening_closing_hats.html
    morphology_img = cv2.morphologyEx(
        input_img, cv2.MORPH_OPEN, np.ones((1, 1), np.uint8)
    )

    # Replace white color (255, 255, 255) with off-white color (241, 241, 249)
    # BGR value
    off_white_img = np.where(
        morphology_img[:, :] == [255, 255, 255],
        np.array([241, 241, 249], dtype=np.uint8),
        morphology_img,
    )
    off_white_img.dtype = np.uint8

    # Replace black color (0, 0, 0) with less-black color (16, 26, 17) BGR value
    less_black_img = np.where(
        off_white_img[:, :] == [0, 0, 0],
        np.array([16, 26, 17], dtype=np.uint8),
        off_white_img,
    )

    # Reduce brightness of image
    # hsv_img = cv2.cvtColor(morphology_img, cv2.COLOR_BGR2HSV)
    # hsv_img[..., 2] = hsv_img[..., 2] * 0.6
    # less_bright_img = cv2.cvtColor(hsv_img, cv2.COLOR_HSV2BGR)

    # Remove noise from image i.e. small black dots here and there in image
    denoised_img = cv2.fastNlMeansDenoising(less_black_img, 11, 31, 9)

    # Apply Gaussian blur to image to make text smooth
    blur_img = cv2.GaussianBlur(denoised_img,(3,3),0)

    # Save output file
    cv2.imwrite(input_image, blur_img)

    return input_image


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1:
        input_image = sys.argv[1]
    else:
        input_image = input("Enter image path: ")
    output_file = enhance_image(input_image)
    # print("Output file is saved as:", output_file)
