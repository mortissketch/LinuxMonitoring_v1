#!/bin/bash

. ./check.sh
. ./create.sh

export countVal=${#}
export path=${1}
export countFolders=${2}
export letterFolders=${3}
export countFiles=${4}
export letterFiles=${5}
export size=${6}

red='\033[031m'
normal='\033[0m'

check
create
