import sys
import glob
import os
from PIL import Image

#######################################
# IF you have an handout, which has multiple slides per page, then to extract
# slides, use this script. It assumes that per page there
# are N (rows) x M (col), and all pages are consistant in layout.
#######################################

# Parameters to be defined
M = 2  # Number of columns
N = 3  # Number of rows
W = 480  # Sub-image width in pixels
H = 360   # Sub-image height in pixels
HS = 93  # Horizontal spacing between sub-images
VS = 119  # Vertical spacing between sub-images
TM = 165  # Top margin from the top edge of the main image
LM = 110  # Left margin from the left edge of the main image
starting_number = 1001  # Starting number for file names
output_directory = "Slides"  # Directory to save extracted images

# Create output directory if it doesn't exist
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# Function to extract sub-images
def extract_sub_images(image_path):
    global starting_number
    
    # Open the main image
    with Image.open(image_path) as img:
        # Iterate over rows and columns
        for row in range(N):
            for col in range(M):
                # Calculate the top-left corner coordinates of the sub-image
                left = LM + col * (W + HS)
                top = TM + row * (H + VS)
                right = left + W
                bottom = top + H
                
                # Crop the sub-image
                sub_image = img.crop((left, top, right, bottom))
                
                # Save the sub-image with the specified name
                output_path = os.path.join(output_directory, f"a{starting_number:04d}.png")
                sub_image.save(output_path)
                
                # Increment the starting number
                starting_number += 1

# Main script execution
if __name__ == "__main__":
    # Check if image file paths are provided
    if len(sys.argv) < 2:
        print("Usage: python3 slides.py <image1> <image2> ... <imageN>")
        sys.exit(1)
    
    # Process each image file path
    for pattern in sys.argv[1:]:
        # Use glob to handle wildcard patterns
        for image_file in glob.glob(pattern):
            print(f"Processing {image_file} ...")
            extract_sub_images(image_file)
    
    print(f"Extraction complete! Sub-images saved in '{output_directory}' directory.")
