// "BatchProcessFolders/Subfolders”
//
// It measures a number of statistics of every image in a
// directory: brightness median and stdev, hue median and stdev, saturation hue and stdev 
// including image path (also the script skip non images without stoping the process)
// This macro processes all the files in a folder and any subfolders. 
// Modified by @NUNEZ.VIZ 2024
 
// Clear existing results and print a clear command
run("Clear Results");
print("\\Clear");

// Prompt the user to select the folder containing the images
dir = getDirectory("Choose images folder to be measured");

// Extract the name of the root folder
rootFolderName = File.getName(dir);

// Specify the filename for saving measurements using the root folder name
filename = dir + rootFolderName + "_measurements.txt";

// Open the file for writing
f = File.open(filename);

// Write the header to the file
print(f, "filename" + "\t" + "imageID" + "\t" + "brightness_median" + "\t" + "brightness_stdev" + "\t" + "saturation_median" + "\t" + "saturation_stdev" + "\t" + "hue_median" + "\t" + "hue_stdev" + "\t" + "year" + "\t" + "path" + "\n");

// Set batch mode to true for improved performance
setBatchMode(true);

// Set measurements options
run("Set Measurements...", "standard median display redirect=None decimal=2");

// Process the files in the selected folder and its subfolders
processFiles(dir);

// Function to process files recursively
function processFiles(dir) {
    list = getFileList(dir);
    var startTime = getTime(); // Record the start time
    print("---> Directory contains " + list.length + " files at " + dir);
    for (i = 0; i < list.length; i++) {
        if (endsWith(list[i], "/")) {
            // Process subdirectory recursively
            subDir = dir + list[i];
            processFiles(subDir);
        } else {
            // Process file
            path = dir + list[i];
            //print("Processing file: " + list.length + path); // print to Log the processing one by one
            processFile(path);
        }
    }
    var endTime = getTime(); // Record the end time
    var totalTimeInSeconds = (endTime - startTime) / 1000; // Calculate the time taken in seconds
    var hours = Math.floor(totalTimeInSeconds / 3600); // Calculate hours
    var minutes = Math.floor((totalTimeInSeconds % 3600) / 60); // Calculate minutes
    var seconds = Math.floor(totalTimeInSeconds % 60); // Calculate remaining seconds
    // Print a message when processing finishes for the current directory along with the time taken
    print("          Finished processing directory on: " + hours + " hrs, " + minutes + " min, " + seconds + " sec");
}

// Function to process individual file
function processFile(path) {
    // Check if the file is an image (TIFF and JPEG)
    if (endsWith(path, ".tif") || endsWith(path, ".tiff") || endsWith(path, ".TIF") || endsWith(path, ".jpg") || endsWith(path, ".JPG") || endsWith(path, ".JPEG") || endsWith(path, ".jpeg")) {
        // Open the image
        open(path);
        id = getImageID();
        image_ID = i + 1;
        print("\\Update:Processing image: " + image_ID + "/" + list.length + "\t" + path);

        // Measure image if it's 24-bit RGB
        if (bitDepth == 24) {
            // Check if the image is already in RGB color space
            if (getMetadata("Info") == "8-bit RGB") {
                // Measure directly without converting
                run("Select All");
                run("Measure");
                brightness_median = getResult("Median");
                brightness_stdev = getResult("StdDev");
                saturation_median = 0; // No saturation in grayscale
                saturation_stdev = 0;
                hue_median = 0; // No hue in grayscale
                hue_stdev = 0;
            } else {
                // Convert to HSB
                run("HSB Stack");
                run("Convert Stack to Images");

                // Measure brightness
                selectWindow("Brightness");
                run("Measure");
                brightness_median = getResult("Median");
                brightness_stdev = getResult("StdDev");
                close();

                // Measure saturation
                selectWindow("Saturation");
                run("Measure");
                saturation_median = getResult("Median");
                saturation_stdev = getResult("StdDev");
                close();

                // Measure hue
                selectWindow("Hue");
                run("Measure");
                hue_median = getResult("Median");
                hue_stdev = getResult("StdDev");
                close();
            }

            // Clear results
            run("Clear Results");

            // Write measurements to file name ("\t" + File.getName(dir) + ) or subfolder name (File.getName(File.getParent(dir))
            print(f, File.getName(path) + "\t" + id + "\t" + brightness_median + "\t" + brightness_stdev + "\t" + saturation_median + "\t" + saturation_stdev + "\t" + hue_median + "\t" + hue_stdev + "\t" + "" + "\t" + path + "\n");

        } else {
            // Print if image format is unsupported
            print("Unsupported format: " + path);
        }
    }
}
