#!/bin/bash

function print()
{
	case $arg in
		1) cat ../04/[1-5]_file.log | sort -k 9 >> all_sort_by_code.log
			echo "check ./all_sort_by_code.log";;
		2) awk '{print $1}' ../04/[1-5]_file.log | sort | uniq >> ip.log
			echo "check ./ip.log";;
		3) awk '$9 ~ /[45]0[0-9]/' ../04/[1-5]_file.log >> error.log
			echo "check ./error.log";;
		4) awk '$9 ~ /[45]0[0-9]/' ../04/[1-5]_file.log >> error.log
			awk '{print $1}' ./error.log | sort |uniq >> ip_error.log
			echo "check ./ip_error.log"
			rm -rf error.log;;
	esac
}
