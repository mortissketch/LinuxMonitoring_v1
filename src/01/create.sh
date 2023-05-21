#!/bin/bash

function create()
{
	sumIter=0
	touch result.log
	for (( countDir=0; countDir < $countFolders; countDir++ ))
	do
		if [[ ${#letterFolders} -lt 4 ]]
		then
			nameFolder=""
			folderNameCreateMin
		else
			nameFolder=$letterFolders
			folderNameCreateMax
		fi
		fileCreate
	done
}

function folderNameCreateMin()
{
	countLetter=${#letterFolders}
	for (( i=0; i<5-$countLetter+$countDir; i++ ))
	do
		nameFolder+="$(echo ${letterFolders:0:1})"
	done
	nameFolder+=$letterFolders
	nameFolder+="_"
	nameFolder+=$(date +"%d%m%y")
	mkdir $(echo $path/$nameFolder)
	echo $nameFolder -- $(date +'%e.%m.%Y') -- >> result.log
}

function folderNameCreateMax()
{
	countLetter=${#letterFolders}
	lastLetter=$countLetter-1
	for (( i=0; i<$countDir; i++ ))
        do
                nameFolder+="$(echo ${letterFolders:$lastLetter:1})"
 	done
	nameFolder+="_"
        nameFolder+=$(date +"%d%m%y")
        mkdir $(echo $path/$nameFolder)
        echo $nameFolder -- $(date +'%e.%m.%Y') -- >> result.log
}

function fileCreate()
{
	fileFirstPart="$(echo "$letterFiles" | awk -F "." '{print $1}')"
	expansion="$(echo "$letterFiles" | awk -F "." '{print $2}')"
	countLetterFile=${#fileFirstPart}
	for (( fileCounter=0; fileCounter<$countFiles; fileCounter++ ))
	do
		if [[ $countLetterFile -lt 4 ]]
		then
			nameFile=""
			fileNameCreateMin
		else
			nameFile=$fileFirstPart
			fileNameCreateMax
		fi
		sumIter=$(($sumIter+1))
		echo $path"/"$nameFolder"/"$nameFile -- $(date +'%e.%m.%Y') -- $size "Kb" >> result.log
	done
}

function fileNameCreateMin()
{
	for (( i=0; i<4-$countLetterFile+$sumIter; i++ ))
	do
		nameFile+="$(echo ${letterFiles:0:1})"
	done
	nameFile+=$fileFirstPart
	nameFile+="_"
	nameFile+=$(date +"%d%m%y")
	nameFile+="."
	nameFile+=$expansion
	fallocate -l $size"KB" $path/$nameFolder/$nameFile
	if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
	then
		exit 1
	fi
}

function fileNameCreateMax()
{
	lastLetter=$countLetterFile-1
	for (( i=$countFolders*$countFiles-1; i>$sumIter; i-- ))
        do
		nameFile+="$(echo ${letterFiles:$lastLetter:1})"
	done
        nameFile+="_"
        nameFile+=$(date +"%d%m%y")
        nameFile+="."
        nameFile+=$expansion
        fallocate -l $size"KB" $path/$nameFolder/$nameFile
        if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
        then
                exit 1
        fi
}
