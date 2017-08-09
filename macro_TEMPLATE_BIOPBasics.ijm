// @String(label="Macro Mode",choices={"Current Image","Current Folder"}) modeChoice

// @String(value="Parameters for Detection", visibility="MESSAGE") textDetection
// @Integer(label="Channel for detection",value=1) detection_chNbr

// @Integer(label="Gaussian Blur sigma",value=1) detection_gBlur
// @Integer(label="Find Maxima noise tolerance",value=100) detection_noiseTol
// @Integer(label="Clear False Positive cutoff - 0 to disable",value=200) detection_meanCutOff

// @String(value="Parameters for Measurements", visibility="MESSAGE") textMeasurements
// @Integer(label="Spots diameter in pixel",value=6) spots_diameter
// @Integer(label="First channel to Measure detection",value=2) measure1_chNbr
// @Integer(label="Second channel To Measure detection",value=3) measure2_chNbr

/*
 * romain dot guiet (at) epfl dot ch
 * olivier dot burri (at) epfl dot ch
 */
 
if (modeChoice == "Current Image"){
	testMode = true ;
} else {
	testMode = false ;
}


// Install the BIOP Library (from PTBIOP update site)
call("BIOP_LibInstaller.installLibrary", "BIOP"+File.separator+"BIOPLib.ijm");
//run("Close All");
//run("Clear Results");
roiManager("Reset");
setForegroundColor(255, 255, 255);
setBackgroundColor(0, 0, 0);

run("Set Measurements...", "mean display redirect=None decimal=3");

if (testMode){
	if (nImages>0){
		processImage();	
	} else{
		showMessage("Please, open an image first.");
		return;
	}
	
} else { // process a folder
	setBatchMode(!testMode);
	
	toolName();
	
	//get directory 
	imageFolder = getImageFolder();
	saveFolder = getSaveFolder();
	imageNumber = getNumberImages();

	for (imageIndex = 0 ; imageIndex < imageNumber ; imageIndex++){
		roiManager("Reset");
		openImage(imageIndex);					// open the image (an its assiciated roiset.zip)
		processImage();							// process the image
		saveRois("Open");//saveRois("Save")		// save the ROIset 
		saveCurrentImage();						// save the current image (within "\Processed")
		run("Close All");						// close all
	}
	
	// save the results
	if( isOpen("Results") ){
		selectWindow("Results");
		saveAs("Results", imageFolder+"results.txt");
	}
	

	setBatchMode(false);
}
showMessage("Jobs DONE!");


// required functions 

function toolName() {
	return "BIOP Basics Parameters";
}

function processImage(){
	imageName = getTitle();
	getDimensions(width, height, channels, slices, frames);
	getVoxelSize(widthPixel, heightPixel, depthPixel, unitPixel);
	rowIndexBefore = nResults;
	roiCount = roiManager("Count");

	//... set here some iamge processing and analysis
}


