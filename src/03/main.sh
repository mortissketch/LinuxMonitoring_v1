#!/bin/bash

. ./check.sh
. ./remove.sh

export countValue=${#}
export method=${1}

red='\033[031m'
normal='\033[0m'

check
removeMethod
