#!/bin/bash

clear

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
NC="\033[0m"
ITALIC="\033[3m"

REGEX_KPI="^(KPI_[0-9]{2})|(q)$"
REGEX_RATE="^(([0-9]|10)|(q))$"
REGEX_RESPONSE="^(y|b)$"

kpiFile="KPI.txt"

#TODO: Check if the KPI has already been selected previously.

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
while IFS=':' read -r code criteria desc; do
	#for i in "${ADDR[0]}"; do
		if [ "$kpiCode" == "${code//[[:blank:]]/}" ]; then
			kpiCriteria="$(echo -e "${criteria}" | sed -e 's/^[[:space:]]*//')"
			kpiFound=1
		fi
	#done;
done < "$kpiFile"
fi

if [[ kpiFound -eq 0 ]]; then
	echo; echo -e "${BLUE}$kpiCode${RED} does not exist. Enter (${YELLOW}q${RED}) to quit.${NC}"
fi

[[ kpiFound -eq 0 ]]
do :
done

echo; echo -e "KPI - Key Performance Indicator: ${BLUE}$kpiCriteria${NC}"

while

echo; echo -en "Please enter the Rate obtained (${ITALIC}max 10 - min 0${NC}): "
read rate

if [[ !($rate =~ $REGEX_RATE) ]]; then
	echo; echo -e "${RED}Rate must be between ${BLUE}0 - 10${RED}. Enter (${YELLOW}q${RED}) to quit.${NC}";
fi

if [ $rate == 'q' ]; then
	#Return to Menu
	exit 1;
fi

[[ !($rate =~ $REGEX_RATE) ]]

do :
done

echo; echo -n "Comments (if any): "; read comments;

while
	echo; echo -en "Press (${GREEN}y${NC}) to continue to enter the Employee's marks or (${RED}b${NC}) to return to the previous screen: "
    read -n 1 response;

	if [[ !($response =~ $REGEX_RESPONSE)  ]]; then
		echo;echo; echo -e "Please enter either (${GREEN}y${NC}) or (${RED}b${NC})"
	fi

	[[ $response != 'y' && $response != 'b' ]]

do :
done

#Check if response is Y or B

if [[ $response == 'b' ]]; then
    ./EmpValidationForm.sh
elif [[ $response == 'y' ]]; then
    
fi
