#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: test-re.sh <testfile> <reg.exp.file>"
  exit
fi

GREP=grep
CAT=cat

infile=$1
refile=$2

if [ ! -f $infile ]; then
  echo "Input test file not found. Aborting ..."
  exit
fi

if [ ! -f $refile ]; then
  echo "Regular expression file not found. Aborting ..."
  exit
fi

found=`which $GREP`
if [ "x$found" == "x" ]; then
  echo "$GREP not found. Aborting..."
  exit
fi

re=`cat $refile`

$CAT $infile | $GREP -n -e "$re"
