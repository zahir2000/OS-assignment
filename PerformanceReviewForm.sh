#!/bin/bash

clear

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
NC="\033[0m"
ITALIC="\033[3m"

REGEX_KPI="^(KPI_[0-9]{2})|(q)$"
REGEX_RATE="^([1-9]|10)$"

kpiFile="KPI.txt"

echo "================================"
echo "Employee Performance Review Form"
echo "================================"

while
while

echo; echo -n "Please enter the KPI Code: "
read kpiCode

if [[ !($kpiCode =~ $REGEX_KPI) ]]; then
	echo; echo "Incorrect KPI Code entered. Please follow (KPI_XX) format"
fi

[[ !($kpiCode =~ $REGEX_KPI) ]]
do :
done

if [ $kpiCode == 'q' ]; then
	#Return to Menu
	exit 1;
fi

kpiFound=0

if [ -f "$kpiFile" -a -r "$kpiFile" ]; then
while IFS=':' read -ra ADDR; do
	for i in "${ADDR[0]}"; do
		if [ "$kpiCode" == "${i//[[:blank:]]/}" ]; then
			kpiDesc="$(echo -e "${ADDR[1]}" | sed -e 's/^[[:space:]]*//')"
			kpiFound=1
		fi
	done;
done < "$kpiFile"
fi

if [[ kpiFound -eq 0 ]]; then
	echo; echo -e "${BLUE}$kpiCode${RED} does not exist. Enter (${YELLOW}q${RED}) to quit.${NC}"
fi

[[ kpiFound -eq 0 ]]
do :
done

echo; echo -e "KPI - Key Performance Indicator: ${BLUE}$kpiDesc${NC}"
echo; echo -en "Please enter the Rate obtained (${ITALIC}max 10 - min 0${NC}): "
read rate

if [[ $rate =~ $REGEX_RATE ]]; then
	echo "Correctt rate";
fi