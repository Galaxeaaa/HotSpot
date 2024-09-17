# Find all file in /pv/DiGS/sanitychecks/heat/grid_sampling_256/L/my_experiment/vis with name like 'sdf_xxxxxx.png', and concatenate them into a video.

import os
import glob
import cv2
import numpy as np

for shape_name in ["snowflake", "L", "circle"]:
    # Define the directory path
    dir_name = '/pv/StEik/sanitychecks/combined_sampling_256/' + shape_name + '/my_experiment/vis'
    output_name = shape_name + '_StEik_combined.mp4'

    # Find all matching files
    file_pattern = os.path.join(dir_name, 'sdf_*.png')
    files = sorted(glob.glob(file_pattern))

    if not files:
        print("No matching files found.")
        exit()

    # Read the first image to get dimensions
    first_image = cv2.imread(files[0])
    height, width, layers = first_image.shape

    # Define the output video file
    video = cv2.VideoWriter(output_name, cv2.VideoWriter_fourcc(*'mp4v'), 6, (width, height))

    # Process each image
    for file in files:
        image = cv2.imread(file)
        video.write(image)

    # Release the video writer
    video.release()

    print(f"Video created: {output_name}")