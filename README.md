# kOS-updater-requester
2 scripts for file handling in kOS and the lib needed to run them


The script Updater.ks will scan the local kOS volumes for files and then update the local files with the copies from the archive volume.

  The script requires the lib lib_file_util.ks and will need to have the RUNPATHONCE edited to point at the copy of the lib on the local volume or use the version called no_lib_Updater.ks as that doesn't need the lib.

  The script matches the name of the local file and a file on the archive overwriting the local file with the version on the archive if the other 3 flags are met and enabled

  The script has a internal white list of extension that it will scan.
	Only extensions on the while list will be looked at by the script.
	The list is only set to with the extension of "ks" by default but more can be added by editing the code.
	  Extension on the while list must only be the charters after the "." and not include the ".".
		EXAMPLE: "ks" will work but ".ks" will not

	Flag 1 is extension matching, has enable/disable parameter.
	  If the local file's extension is ".ks" then the file on the archive must have a extension of ".ks" not ".ksm" or ".txt".

	Flag 2 is path matching, has enable/disable parameter.
	  If the local file's path is "1:/lib/" then the file on the archive must have a path of "0:/lib" not "0:/" or "0:/boot/".

	Flag 3 is size mismatching, has enable/disable parameter.
	  If the local file's size is "123" then the file on the archive must not have a size of "123" but any other size will work.
	  Note: the default way text files on windows computer are saved leaves you with 2 charters to note the start of a new line and kOS only has one so when coping a file kOS removes the extra charter.  This means that the size check will not work as intended because even after being copied the file on the archive will be larger than the file on the kOS core.


  Updater.ks has 3 parameters they all have defaults so the user doesn't need to always type them in every time the script is run.

	Parameter 1: extension matching enable/disable, FALSE = enable and TRUE = disable, default is FALSE
	Parameter 2:	  path matching enable/disable, FALSE = enable and TRUE = disable, default is TRUE
	Parameter 3:   size mismatching enable/disable, FALSE = enable and TRUE = disable, default is TRUE



The script Need_File.ks will scan the local volume for the file and if not found locally then it attempt to find a copy on the archive and copy it to the local volume.
  
  The script requires the lib lib_file_util.ks and will need to have the RUNPATHONCE edited to point at the copy of the lib on the local volume or use the version called no_lib_Need_File.ks as that doesn't need the lib.

  The script requires the first parameter to run

  The script will also preserve the path of the file from the archive to the local volume.
	EXAMPLE: archive path of "0:/lib/" will result in the file being copied to "1:/lib/".

  Need_File.ks has 2 parameters and only one has a default.

	Parameter 1: the name of the file to be looked for without the extension.
	  EXAMPLE: "Need_File"

	Parameter 2: the extension of the file to be looked for this is optional and defaults any extension.
	  EXAMPLE: "ks" or "txt"



The lib lib_file_util.ks has its functions documented internally in comments.