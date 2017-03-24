# kOS-updater-requester
2 scripts for file handling in kOS and the lib needed to run them


the script Updater.ks will scan the local kOS volumes for files and then update the local files with the copies from the archive volume

  the script requires the lib lib_file_util.ks and will need to have the RUNPATHONCE edited to point at the copy of the lib on the local volume
	or use the version called no_lib_Updater.ks as that doesn't need the lib
	
  the script matches the name of the local file and a file on the archive overwiting the local file with the version on the archive if the other 3 flags are met and enabled
  
  the script has a internal white list of extension that it will scan
	only extensions on the while list will be looked at by the script
	the list is only set to with the extension of "ks" by defult but more can be added by editing the code
	  extension on the while list must only be the charters after the "." and not include the "."
		EXAMPLE: "ks" will work but ".ks" will not
  
	flag 1 is extension matching, has enable/disable parameter
	  if the local file's extension is ".ks" then the file on the archive must have a extension of ".ks" not ".ksm" or ".txt"
	  
	flag 2 is path matching, has enable/disable parameter
	  if the local file's path is "1:/lib/" then the file on the archive must have a path of "0:/lib" not "0:/" or "0:/boot/"
	  
	flag 3 is size mismatching, has enable/disable parameter
	  if the local file's size is "123" then the file on the archive must not have a size of "123" but any other size will work
	  
  
  updater.ks has 3 parameters they all have defaults so the user doesn't need to always type them in every time the script is run
  
	parameter 1: extension matching enable/disable, FALSE = enable and TRUE = disable, default is FALSE
	parameter 2:	  path matching enable/disable, FALSE = enable and TRUE = disable, default is TRUE
	parameter 3:   size mismatching enable/disable, FALSE = enable and TRUE = disable, default is TRUE


the script Need_File.ks will scan the local volume for the file and if not found locally then it attempt to find a copy on the archive and copy it to the local volume
  
  the script requires the lib lib_file_util.ks and will need to have the RUNPATHONCE edited to point at the copy of the lib on the local volume
	or use the version called no_lib_Updater.ks as that doesn't need the lib
	
  the script requires the first parameter to run
  
  the script will also preserve the path of the file from the archive to the local volume
	EXAMPLE: archive path of "0:/lib/" will result in the file being copied to "1:/lib/"
  
  Need_File.ks has 2 parameters and only one has a default
  
	parameter 1: the name of the file to be looked for without the extension
	  EXAMPLE: "Need_File"
	  
	parameter 2: the extension of the file to be looked for this is optional and defaults any extension
	  EXAMPLE: "ks" or "txt"

the lib lib_file_util.ks has it's functions documented internally