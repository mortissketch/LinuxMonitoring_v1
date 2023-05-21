#!/bin/bash

. ./check.sh
. ./create.sh

export countValue=${#}
export letterFolders=${1}
export letterFiles=${2}
export size=${3}

red='\033[031m'
normal='\033[0m'

check
create
