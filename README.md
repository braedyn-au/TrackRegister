# TrackRegister
Takes single particle tracks as either CSV from Mosaic Tracker or XML from TrackMate and registers and overlays them to your microscopy image.

Developed for https://www.biorxiv.org/content/10.1101/2020.03.30.016477v1

- [Requirements] (# Requirements)
- [Installation] (# Installation)
- [Demo] (# Demo)
- [Instructions] (# Instructions)
- [License] (# License)

# Requirements:

MATLAB 2015 with Image Processing Toolbox installed.
Tested on Windows, Linux, and MacOS.

# Installation

All scripts are contained in this repository, no installation necessary outside of MATLAB. Image registration is done by running *main.m*.

# Demo

Dummy data is provided in *exampletracks1.csv* which contains tracks from Mosaic Tracker in CSV format, *190627-Jia-MagBeads_mag_002_Tracks.xml* which contains tracks from TrackMate in XML format, and *tip00-1_SCALED.tif* which is a TIFF image file.
By running the script with one of the tracks and image file, the software will output the tracks registered and overlayed on the image which can be saved via MATLAB.

# Instructions

1. Open main.m in MATLAB and run the entire script.
2. On the prompt, select your the tracks file.
3. In the terminal prompt, input your track unit conversion factor to pixels, obtained from your microscope specifications or tracking software.
4. On the prompt, select your image file.
5. In the text prompt, choose your registration method by either inputting coordinates numerically (more accurate), or selecting them on a MATLAB GUI (less accurate).
6. View and save the resulting registered image.   

Expected runtime should be <10 minutes.

# License

This work is covered under the _MIT License_.
