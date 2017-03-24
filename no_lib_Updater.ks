PARAMETER notUseExtension IS FALSE, //set if the file being updated must have the same extension as the file on the archive to be updated (FALSE = use and TRUE = ignore)
notUsePath IS TRUE, //sets if the file being updated must have the same path ignoreing voulme to be updated (FALSE = use and TRUE = ignore)
notUseSize IS TRUE. //sets if the file being updated must have a different size compared to the file on the archive to be updated (FALSE = use and TRUE = ignore)
IF EXISTS("0:/") {
CLEARSCREEN.
LOCAL localDir IS LIST().
LIST VOLUMES IN localDir.
LOCAL archiveDir IS localDir[0].
localDir:REMOVE(0).
LOCAL extList IS LIST("ks").

LOCAL localFiles IS dir_list_scan(localDir,extList).
LOCAL archiveFiles IS dir_scan(archiveDir,extList).

CD("1:/").
FOR lFile IN localFiles {
	FOR aFile IN archiveFiles {
		IF name_only(aFile[1]) = name_only(lFile[1]) {	//name check
			IF aFile[1]:EXTENSION = lFile[1]:EXTENSION OR notUseExtension {	//extension check
				IF no_root(aFile[0]) = no_root(lFile[0]) OR notUsePath {	//path check
					IF  aFile[1]:SIZE <> lFile[1]:SIZE OR notUseSize { //size check
						COPYPATH(aFile[0]:COMBINE(aFile[1]:NAME),lFile[0]).
						PRINT "Copying File: " + aFile[1].
						PRINT "        From: " + aFile[0] + " To: " + lFile[0].
						PRINT " ".
					}
				}
			}
		}
	}
}} ELSE { PRINT "Archive Not Found". }

FUNCTION dir_list_scan {
	PARAMETER dirList,extL.
	LOCAL dirRevert IS PATH().
	LOCAL masterList IS LIST().
	FOR dir IN dirList {
		FOR subFile IN dir_scan(Dir,extL,FALSE) {
			masterList:ADD(subFile).
		}
	}
	WAIT 0.01.
	CD(dirRevert).
	RETURN masterList.
}

FUNCTION dir_scan {
	PARAMETER dir,extL,doDirRevert IS TRUE.
	LOCAL masterList IS LIST().

	LOCAL dirRevert IS PATH().
	LOCAL dirPath IS PATH(dir).
	CD(dirPath).
	LOCAL fileList IS LIST().
	LIST FILES IN fileList.

	LOCAL dirList IS LIST().
	FOR filter IN fileList {
		FOR ext IN extL {
			IF filter:ISFILE AND ((filter:EXTENSION = ext) OR (-99999 = ext)) {
				masterList:ADD(LIST(dirPath,filter)).
			}
		}
		IF (NOT filter:ISFILE) {
			dirList:ADD(dirPath:COMBINE(filter + "/")).
		}
	}
	FOR subDir IN dirList {
		FOR subFile IN dir_scan(subDir,extL,FALSE) {
			masterList:ADD(subFile).
		}
	}
	IF doDirRevert { 
		WAIT 0.01.
		CD(dirRevert).
	}
	RETURN masterList.
}

FUNCTION no_root {
	PARAMETER segment.
	RETURN segment:SEGMENTS:JOIN("/").
}

FUNCTION name_only {
	PARAMETER fileName.
	RETURN fileName:NAME:SUBSTRING(0,fileName:NAME:LENGTH - (fileName:EXTENSION:LENGTH + 1)).
}