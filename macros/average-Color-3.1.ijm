// "Average Color 3.1"
//
// This macro batch processes all the files in a folder/subfolders
//Selecting the ROI of all images and then saving a copy in PNG format.
// Also skip non-JPG-TIFF without stopping the macro.
// Modified by @NUNEZ.VIZ 2021
 
print("\\Clear");
dir = getDirectory("Choose a Directory ");
path2 = getDirectory("Choose the Directory to Save Images");

setBatchMode(true);
processFiles(dir);

function processFiles(dir) {
   list = getFileList(dir);
   print("---> Directory contains " + list.length + " files at " + dir);
   for (i=0; i<list.length; i++) {
       if (endsWith(list[i], "/"))
           processFiles(""+dir+list[i]);
       else {
          path = dir+list[i];
          processFile(path);
       }
   }
}

function processFile(path) {
   if  (endsWith(list[i], ".jpg") || endsWith(list[i], ".jpeg") || endsWith(list[i], ".JPEG") || endsWith(list[i], ".JPG") || endsWith(list[i], ".tif") || endsWith(list[i], ".TIF")) {
        open(path);       
        image_ID = i + 1;
        print("\\Update:Saving image: " + image_ID + "/" + list.length + "\t" + list[i] + "\t" + path2);
        
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
                    
        		run("Select All");
        		run("Average Color", "cielab");
        		
            }	
        
        	// Construct new file name for PNG file
        	newName = path2 + File.separator + image_ID + "_" + File.getNameWithoutExtension(path) + ".png";
        	saveAs("PNG", newName);
        	close();
        
        } else {
            // Print if image format is unsupported
            print("Unsupported format: " + path);
        }
   }
}
