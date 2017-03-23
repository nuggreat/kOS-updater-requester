# kOS-updater-requester
2 scripts for file handleing in kOS and the lib needed to run them

the script Updater.ks will scan the local kOS volumes for files and then update the local files with the copies from the archive volume
  Updater.ks requres a matching name betwene the local file and archive to copy the archive file to the local volume the 3 other things can be enable/disabled with paramters eather deafults in the code or set when the script is run
  
  updater.ks has 3 parameters they all have defaults so the user doesn't need to always type them in every time the script is run
    parameter 1: set if the file being updated must have the same extension as the file on the archive to be updated (FALSE = use and TRUE = ignore)
      EXAMPLE: if FALSE then if the local file's extension is ".ks" then the file on the archive must have a extension of ".ks" not ".ksm" or ".txt"
               if TRUE then the file's  extension is ignored
    parameter 2: sets if the file being updated must have the same path ignoreing voulme to be updated (FALSE = use and TRUE = ignore)
      EXAMPLE: if FALSE then if the local file's path is "1:/lib/" then the file on the archive must have a path of "0:/lib" not "0:/" or "0:/boot/"
               if TRUE then the file's path is ignored
    parameter 3: sets if the file being updated must have a different size compared to the file on the archive to be updated (FALSE = use and TRUE = ignore)
      EXAMPLE: if FALSE then if the local file's size is "123" then the file on the archive must not have a size of "123" but any other size will work
               if TRUE then the file's size is ignored
