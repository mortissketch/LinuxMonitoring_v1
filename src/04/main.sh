#!/bin/bash

function methods()
{
	choice=$((1+$RANDOM%5))
	case $choice in
		1) echo -n "\"GET" >> $fileName;;
		2) echo -n "\"POST" >> $fileName;;
		3) echo -n "\"PUT" >> $fileName;;
		4) echo -n "\"PATCH" >> $fileName;;
		5) echo -n "\"DELETE" >> $fileName;;
	esac
}

function request()
{
	choice=$((1+$RANDOM%10))
	case $choice in
		1) echo -n " /downloads HTTP/1.1\"" >> $fileName;;
		2) echo -n " /pictures HTTP/1.1\"" >> $fileName;;
		3) echo -n " /support HTTP/1.1\"" >> $fileName;;
		4) echo -n " /links HTTP/1.1\"" >> $fileName;;
		5) echo -n " /home HTTP/1.1\"" >> $fileName;;
		6) echo -n " /feed HTTP/1.1\"" >> $fileName;;
		7) echo -n " /im HTTP/1.1\"" >> $fileName;;
		8) echo -n " /friends HTTP/1.1\"" >> $fileName;;
		9) echo -n " /albums HTTP/1.1\"" >> $fileName;;
		10) echo -n " /apps HTTP/1.1\"" >> $fileName;;
	esac
}

function statusCode()
{
	choice=$((1+$RANDOM%10))
	case $choice in
		1) echo -n " 200 \"-\" " >> $fileName;; #ok
		2) echo -n " 201 \"-\" " >> $fileName;; #created
		3) echo -n " 400 \"-\" " >> $fileName;; #bad request
		4) echo -n " 401 \"-\" " >> $fileName;; #unauthorized
		5) echo -n " 403 \"-\" " >> $fileName;; #forbidden
		6) echo -n " 404 \"-\" " >> $fileName;; #not found
		7) echo -n " 500 \"-\" " >> $fileName;; #internal server error
		8) echo -n " 501 \"-\" " >> $fileName;; #not implemented
		9) echo -n " 502 \"-\" " >> $fileName;; #bad gateway
		10) echo -n " 503 \"-\" " >> $fileName;; #service unavailable
	esac
}

function agents()
{
	choice=$((1+$RANDOM%8))
	case $choice in
		1) echo "\"Mozilla\"" >> $fileName;;
		2) echo "\"Google Chrome\"" >> $fileName;;
		3) echo "\"Opera\"" >> $fileName;;
		4) echo "\"Safari\"" >> $fileName;;
		5) echo "\"Internet Explorer\"" >> $fileName;;
		6) echo "\"Microsoft Edge\"" >> $fileName;;
		7) echo "\"Crawler and bot\"" >> $fileName;;
		8) echo "\"Library and net tool\"" >> $fileName;;
	esac
}

red='\033[031m'
normal='\033[0m'

date="$(date +"%Y-%m-%d") 00:00:00 $(date +%z)"
seconds=$((10+$RANDOM%51))

if [[ $# -ne 0 ]]
then
	echo "${red}ERROR${normal} invalid number of arguments (u need 0 args)"
	exit 1
fi

countRecords=$(( 100 + $RANDOM % 901 ))
for (( i=1; i < 6; i++ ))
do
	fileName=$i
	fileName+="_file.log"
	for (( j=0; j < $countRecords; j++ ))
	do
		ip_name=""
		for (( ip_part=0; ip_part<4; ip_part++ ))
		do
			ip=$(( 1+$RANDOM%255 ))
			ip_name+=$ip
			if [[ ip_part -ne 3 ]]
			then
				ip_name+="."
			fi
		done
		echo -n $ip_name >> $fileName
		echo -n " - - " >> $fileName
		echo -n "[$(date -d "$date+$seconds seconds" +'%d/%b/%Y:%H:%M:%S %z')] " >> $fileName
		methods
		request
		statusCode
		agents
		tmp=$((10+$RANDOM%51))
		let "seconds+=$tmp"
	done
	date="$(date +"%Y-%m-%d") 00:00:00 $(date +%z)"
	date="$(date -d "$date - $(($i+1)) days" +'%Y-%m-%d')"
done
