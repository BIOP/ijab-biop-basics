@ECHO OFF

ECHO Copying BIOP_Basics.ijm to current folder
copy C:\Fiji\plugins\ActionBar\Debug\BIOP_Basics.ijm

ECHO Creating JAR FILE
jar cf BIOP_Basics.jar plugins.config icons *.ijm

ECHO Copying BIOP_Basics to Fiji folder
copy *.jar C:\Fiji\plugins\BIOP

PAUSE