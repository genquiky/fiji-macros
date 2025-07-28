/* "Change size of images, replacing the file"
    This macro batch processes all the files in a folder/subfolders
    Also, skip non-JPG-TIFF without stopping the macro. */ 

// Clear console
print("\\Clear");

// Ask user to choose a directory
dir = getDirectory("Choose a Directory ");

// Enable batch mode
setBatchMode(true);

// Process files in the chosen directory and its subdirectories
processFiles(dir);


// Function to recursively process files
function processFiles(dir) {
    // Get list of files in the directory
    list = getFileList(dir);
    // Iterate over each file in the list
    for (i = 0; i < list.length; i++) {
        // Check if it's a directory
        if (endsWith(list[i], "/"))
            processFiles("" + dir + list[i]); // Recursively process subdirectory
        else {
            path = dir + list[i]; // Full path of the file
            processFile(path); // Process the file
        }
    }
}

// Function to process each file
function processFile(path) {    
      if  (endsWith(list[i], ".png")) {  // || (endsWith(list[i], ".jpg") || endsWith(list[i], ".jpeg") || endsWith(list[i], ".JPEG") || endsWith(list[i], ".JPG") || endsWith(list[i], ".tif") || endsWith(list[i], ".TIF") // Check if the file extension is one of the supported image formats      
        open(path); // Open the image        
        image_ID = i + 1; // Get image ID       
		print("\\Update:Processing image: " + image_ID + "/" + list.length + "\t" + list[i] + "\t" + dir);  // Print update message      
        run("Size..."); // Resize the image       
        save(path);// replace the image
        close(); // Close the image
    }
}

call("java.lang.System.gc"); // call Java garbage collector to free memory
