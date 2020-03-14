import cv2
import numpy as np


def remove_red_color(input_image):
    # Read input image file
    input_img = cv2.imread(input_image, cv2.IMREAD_COLOR)

    # converting from BGR to HSV color space
    hsv_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2HSV)

    # Range for lower red
    lower_red = np.array([0, 20, 70])
    upper_red = np.array([10, 150, 255])
    mask1 = cv2.inRange(hsv_img, lower_red, upper_red)

    # Range for upper red
    lower_red = np.array([160, 10, 70])
    upper_red = np.array([180, 150, 255])
    mask2 = cv2.inRange(hsv_img, lower_red, upper_red)

    # Add both masks for combined effect
    mask = mask1 + mask2

    # Cover small area around masked red area
    mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, np.ones((3, 3), np.uint8))
    mask = cv2.morphologyEx(mask, cv2.MORPH_DILATE, np.ones((3, 3), np.uint8))

    # To be used as replacement of red color
    white_image = np.zeros(input_img.shape, np.uint8)
    white_image[:] = (193, 189, 188)

    # Remove part of white image corresponding to which there is no red color in
    # input image
    res1 = cv2.bitwise_and(white_image, white_image, mask=mask)

    # Remove part of input image containing red color
    mask = cv2.bitwise_not(mask)
    res2 = cv2.bitwise_or(input_img, input_img, mask=mask)

    # Add result1 and result2
    res = cv2.bitwise_or(res1, res2)

    # Save output file
    output_file = input_image.split("/")[-1].split(".")[0] + "_output.png"
    cv2.imwrite(output_file, res)

    return output_file


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1:
        input_image = sys.argv[1]
    else:
        input_image = input("Enter image path: ")
    output_file = remove_red_color(input_image)
    print("Output file is saved as:", output_file)
