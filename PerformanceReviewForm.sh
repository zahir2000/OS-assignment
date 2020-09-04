#!/bin/bash

clear

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
NC="\033[0m"
ITALIC="\033[3m"

#name="Zahir Sher"
#icNo="111111-11-1111"
#to="08-2000"
#from="01-2000"

name="$1"
icNo="$2"
to="$3"
from="$4"

REGEX_KPI="^(KPI_[0-9]{2})|(q|Q)$"
REGEX_RATE="^(([0-9]|10)|(q|Q))$"
REGEX_RESPONSE="^(y|b)$"

kpiFile="KPI.txt"
kpiCounter=0

isFirstTime=1
isAddMore=1

kpiCode=()
kpiCriteria=()
perfComment=()
perfRate=()

getStaffPerformance() {
    score=$(( $1 ))

    if [[ $score -le 2 && $score -ge 0 ]]; then
        echo "Poor"
    elif [[ $score -eq 3 ]]; then
        echo "Unsatisfactory"
    elif [[ $score -le 5 && $score -ge 4 ]]; then
        echo "Satisfactory"
    elif [[ $score -le 7 && $score -ge 6 ]]; then
        echo "Very Satisfactory"
    elif [[ $score -le 10 && $score -ge 8 ]]; then    
        echo "Outstanding"
    else
        printf "${RED}Invalid Marks Range!${NC}"
    fi
}

while

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s\n" "|        Employee Performance Review Form        |"
printf "%s\n" "+————————————————————————————————————————————————+"

inCounter=0
inAvgScore=0
while [[ $inCounter -lt ${#kpiCriteria[@]} ]]; do
    printf "|  %-38s %5s  |\n" "${kpiCriteria[$inCounter]}" "${perfRate[$inCounter]}"
    inAvgScore=$(( $inAvgScore+${perfRate[$inCounter]} ))
    inCounter=$(( $inCounter+1 ))

    if [[ $inCounter -eq ${#kpiCriteria[@]} ]]; then
        inAvgScore=$(( $inAvgScore / ${#perfRate[@]} ))
        printf "%s\n" "+================================================+"
        printf "|  %-38s %5s  |\n" "Average Rating Score" "$inAvgScore"
        printf "|  %-26s %17s  |\n" "Perforamance" "$(getStaffPerformance $inAvgScore)"
        printf "%s\n" "+————————————————————————————————————————————————+"
    fi
done

while
while

#Maybe the ability to modify the entered KPI Code.

echo; echo -n "Please enter the KPI Code: "
read inKpiCode
inKpiCode=$(echo "$inKpiCode" | tr 'a-z' 'A-Z')

if [[ !($inKpiCode =~ $REGEX_KPI) ]]; then
	echo; printf "${RED}Incorrect KPI Code entered.${NC}\nPlease follow (${GREEN}KPI_XX${NC}) format\n"
fi

[[ !($inKpiCode =~ $REGEX_KPI) ]]
do :
done

if [ "$inKpiCode" == "Q" ]; then
	./EmpValidationForm.sh
	exit 0;
fi

kpiFound=0; kpiDuplicated=0

for item in "${kpiCode[@]}"; do
    if [[ "$inKpiCode" == "$item" ]]; then
        kpiDuplicated=1
    fi
done

if [ -f "$kpiFile" -a -r "$kpiFile" -a $kpiDuplicated -eq 0 ]; then
while IFS=':' read -r code criteria desc; do
	if [ "$inKpiCode" == "${code//[[:blank:]]/}" ]; then
        kpiCode+=("$inKpiCode")
		kpiCriteria+=("$(echo -e "${criteria}" | sed -e 's/^[[:space:]]*//')")
		kpiFound=1
	fi
done < "$kpiFile"
fi

if [ $kpiFound -eq 0 -a $kpiDuplicated -eq 0 ]; then
	echo; echo -e "${BLUE}$inKpiCode${RED} does not exist. Enter (${YELLOW}q${RED}) to quit.${NC}"
elif [[ $kpiDuplicated -eq 1 ]]; then
    printf "\n${BLUE}$inKpiCode${RED} has already been selected. Please select another KPI criteria.${NC}\n"
fi

[[ $kpiFound -eq 0 || $kpiDuplicated -eq 1 ]]
do :
done

echo; echo -e "KPI - Key Performance Indicator: ${BLUE}${kpiCriteria[$kpiCounter]}${NC}"

while

echo; echo -en "Please enter the Rate obtained (${ITALIC}max 10 - min 0${NC}): "
read rate

if [[ !($rate =~ $REGEX_RATE) ]]; then
	echo; echo -e "${RED}Rate must be between ${BLUE}0 - 10${RED}. Enter (${YELLOW}q${RED}) to quit.${NC}";
fi

if [ "$rate" == "q" ]; then
	#Return to Menu
	exit 1;
fi

[[ !($rate =~ $REGEX_RATE) ]]

do :
done

echo; echo -n "Comments (if any): "; read comments;

if [ -z "$comments" ]; then
    comments="-"
fi

perfRate+=("$rate")
perfComment+=("$comments")

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

if [ $isFirstTime -eq 1 -a -n "$name" -a -n "$icNo" -a -n "$to" -a -n "$from" ]; then
    ( 
        printf "%50s\n%52s\n" "Employee Performance Review" "==============================="
        printf "\nEmployee IC. Number    : $icNo\n"
        printf "Employee Name          : $name\n"
        printf "Review Period          : From $from To $to\n\n"
        printf "==============================================================================\n"
        printf "KPI Criteria:\t\t\t\tRate Obtained:\t\t\t\tComments:\t\n"
        printf "==============================================================================\n"
        #printf "%-32s %-22s %-22s" "$kpiCriteria" "$perfRate" "$perfComment"
    ) > "${icNo}KPIResult.txt"
    isFirstTime=0
fi
    
echo "$(head -n 10 ${icNo}KPIResult.txt)" > "${icNo}KPIResult.txt"
(
    i=0; avgRatingScore=0
    while [ $i -lt ${#kpiCriteria[@]} ]; do
        printf "%-32s %-22s %-22s\n" "${kpiCriteria[$i]}" "${perfRate[$i]}" "${perfComment[$i]}"
        avgRatingScore=$(( $avgRatingScore+${perfRate[$i]} ))
        i=$(( $i+1 ))
    done

    avgRatingScore=$(( $avgRatingScore / ${#perfRate[@]} ))
    echo; echo "Average Performance Rating Score: $avgRatingScore"
    perfAdj=$(getStaffPerformance $avgRatingScore)
    echo; echo "Overall staff performance: $perfAdj"
) >> "${icNo}KPIResult.txt"

clear
kpiCounter=$(( $kpiCounter + 1 ))

if [[ $response == 'b' ]]; then
    isAddMore=0
    ./EmpValidationForm.sh
fi
    #If inserted anything to file, sleep for a while and show echo then return back.

[[ isAddMore -eq 1 ]]
do : 
done
