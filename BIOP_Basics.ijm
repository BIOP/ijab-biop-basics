/* Set of Macro Tools to convert JaCoP output to result tables
 *  and to batch colocalization analyses (Intensity-Based)
 *  Olivier Burri, Romain Guiet
 *  2016 
 *  EPFL - SV - PTECH - PTBIOP
 *  http://biop.epfl.ch
*/


// Name ActionBar
bar_name = "BIOP Basics";

bar_file = replace(bar_name, " ", "_")+".ijm";
bar_jar  = replace(bar_name, " ", "_")+".jar";
 
// Install the BIOP Library
call("BIOP_LibInstaller.installLibrary", "BIOP"+File.separator+"BIOPLib.ijm");

//v4 . threshold for Stack

runFrom = "jar:file:BIOP/"+bar_jar+"!/"+bar_file;
//////////////////////////////////////////////////////////////////////////////////////////////
// The line below is for debugging. Place this VSI file in the ActionBar folder within Plugins
//////////////////////////////////////////////////////////////////////////////////////////////
runFrom = "/plugins/ActionBar/Debug/"+bar_file;

if(isOpen(bar_name)) {
	run("Close AB", bar_name);
}

run("Action Bar",runFrom);
exit();


//Start of ActionBar

<codeLibrary>
function toolName() {
	return "BIOP Basics Parameters";
}
</codeLibrary>

<text><html><font size=2.5 color=#0C2981> Folder and Image
<line>
<button>
label=Set Folder
icon=noicon
arg=<macro>
//Open the file and parse the data
openParamsIfNeeded();
setImageFolder("Select Working Folder");
</macro>

<button>
label=Open Image
icon=noicon
arg=<macro>
selectImageDialog();
</macro>
</line>

<text><html><font size=2.5 color=#0C2981> Macro
<line>
<button>
label= SET
icon=noicon
arg=<macro>
	macroFile = File.openDialog("Select the macro to run");
	setData("Macro File",macroFile);
</macro>
</line>

<line>
<button>
label= START
icon=noicon
arg=<macro>
	macroFile = getData("Macro File");
	if (macroFile == ""){
		macroFile = File.openDialog("Select the macro to run");
		setData("Macro File",macroFile);
	}
	folder = getImageFolder();
	run("BIOP Run Macro...", "macro_file=["+macroFile+"] logservice=[org.scijava.log.StderrLogService [priority = -100.0]] scriptservice=[org.scijava.script.DefaultScriptService [priority = 100.0]] imagefolder=["+folder+"]");
</macro>
</line>

<text><html><font size=3 color=#0C2981> Close & cleanUp
<line>
<button>
label= Images
icon=noicon
arg=<macro>
closeAll("image");
</macro>

<button>
label= Non-Images
icon=noicon
arg=<macro>
closeAll("nonimage");
</macro>
</line>

<line>
<button>
label= All
icon=noicon
arg=<macro>
closeAll("image");
closeAll("nonimage");
</macro>

<line>
<button>
label= All but Current Image
icon=noicon
arg=<macro>
close("\\Others");
</macro>
</line>