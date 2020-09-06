#!/bin/bash

clear

. ./configs.sh

#name="Zahir Sher"
#icNo="111111-11-1111"
#to="08-2000"
#from="01-2000"

name="$1"
icNo="$2"
to="$3"
from="$4"

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

kpiDeleted=0
kpiModified=0

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "       Employee Performance Review Form       " "|"
printf "%s\n" "+————————————————————————————————————————————————+"
printf "|  ${BOLD}%-29s ${BLUE}%13s${NC}  |\n" "IC. Number" "$icNo"
printf "|  ${BOLD}%-13s ${BLUE}%30s${NC}  |\n" "Name" "$name"
printf "|  ${BOLD}%-25s ${BLUE}%18s${NC}  |\n" "Period" "$from to $to"
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

echo; echo "Please enter the KPI Code:-"
echo -en "(${GREEN}KPI_XX${NC}): "
read inKpiCode
inKpiCode=$(echo "$inKpiCode" | tr 'a-z' 'A-Z')

if [[ !($inKpiCode =~ $REGEX_KPI) ]]; then
	echo; printf "${RED}Incorrect KPI Code entered.${NC}\nPlease follow (${GREEN}KPI_XX${NC}) format\n"
fi

[[ !($inKpiCode =~ $REGEX_KPI) ]]
do :
done

if [ "$inKpiCode" == "Q" ]; then
	./EmpValidationForm.sh; exit 0;
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
    
        printf "\n${BLUE}$inKpiCode${RED} has already been selected.${NC}\n\n"
        printf "${UNDERLINE}Would you like to${NC}:-\n"
        echo -e "(${GREEN}m${NC}) - Modify KPI Rate"
        echo -e "(${RED}d${NC}) - Delete KPI Rate"
        echo -e "(${YELLOW}r${NC}) - Select New KPI"
        echo -n "Please select a choice: "; read -n1 dupChoice; dupChoice=$(echo "$dupChoice" | tr 'A-Z' 'a-z')

    while
        case "$dupChoice" in
            m)
                mod=0
                while [ $mod -lt ${#kpiCode[@]} ]; do
                    if [[ "$inKpiCode" == ${kpiCode[$mod]} ]]; then
                        modOrigRate=${perfRate[$mod]}
                        break
                    fi
                    mod=$(( $mod+1 ))
                done

                while
                while

                    printf "\n\nPlease enter the ${BOLDGREEN}new${NC} Rate obtained (${ITALIC}min 0 - max 10${NC}): "
                    read modRate

                    if [[ !($modRate =~ $REGEX_RATE) ]]; then
                        printf "\n${RED}Rate must be between ${BLUE}0 - 10${RED}. Enter (${YELLOW}q${RED}) to quit.${NC}";
                    fi

                    if [ "$modRate" == "q" ]; then
                        isAddMore=0
                        ./EmpValidationForm.sh; exit 0
                    fi

                [[ !($modRate =~ $REGEX_RATE) ]]

                do :
                done

                if [[ $modOrigRate -eq $modRate ]]; then
                    printf "\n${RED}The ${BOLDGREEN}new${RED} rate cannot be same as original rate. Please re-enter.${NC}"
                fi  

                [[ $modOrigRate -eq $modRate ]]

                do :
                done

                echo; echo -n "Comments (if any): "; read modComments;

                printf "\nAre you sure you want to modify the rate from ${RED}$modOrigRate${NC} to ${GREEN}$modRate${NC}"
                
                while
                    printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
                    read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')

                    if [[ "$choice" == "y" ]]; then
                        perfRate[$mod]="$modRate"
                        
                        if [ -n "$modComments" ]; then
                            perfComment[$mod]="$modComments"
                        fi

                        kpiModified=1
                        printf "\n\n${BOLDGREEN}KPI Rate successfuly modified.${NC}\n"
                    elif [[ "$choice" == "n" ]]; then
                        echo
                    fi

                [[ "$choice" != "y" && "$choice" != "n" ]]
                do :
                done
                ;;
            d)
                del=0
                while [ $del -lt ${#kpiCode[@]} ]; do
                    if [[ "$inKpiCode" == ${kpiCode[$del]} ]]; then
                        delCriteria=${kpiCriteria[$del]}
                        delRate=${perfRate[$del]}
                        break
                    fi
                    del=$(( $del+1 ))
                done
                printf "\n\n${UNDERLINE}Are you sure you want to delete${NC}:\n=> ${BOLDBLUE}$inKpiCode${NC} (${BLUE}$delCriteria${NC}) with rate of ${BOLDPURPLE}$delRate${NC}"
                
                while
                    printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
                    read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')

                    if [[ "$choice" == "y" ]]; then
                        kpiCode=(${kpiCode[@]:0:$del} ${kpiCode[@]:$(($del + 1))})
                        kpiCriteria=(${kpiCriteria[@]:0:$del} ${kpiCriteria[@]:$(($del + 1))})
                        perfComment=(${perfComment[@]:0:$del} ${perfComment[@]:$(($del + 1))})
                        perfRate=(${perfRate[@]:0:$del} ${perfRate[@]:$(($del + 1))})
                        kpiCounter=$(( $kpiCounter - 1 ))
                        kpiDeleted=1

                        printf "\n\n${BOLDGREEN}KPI successfuly deleted.${NC}\n"
                    elif [[ "$choice" == "n" ]]; then
                        echo
                    fi

                [[ "$choice" != "y" && "$choice" != "n" ]]
                do :
                done
                ;;
            r)
                echo
                ;;
            *)
                printf "\n\nInvalid choice entered. Please enter (${GREEN}m${NC}) or (${RED}d${NC}) or (${YELLOW}r${NC}).\n\n"
                echo -n "Please select a choice: "; read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')
        esac

    [[ !($dupChoice =~ $REGEX_CHOICE) ]]
    do :
    done
fi

if [[ $kpiDeleted -eq 1 || $kpiModified -eq 1 ]]; then
    break
fi

[[ $kpiFound -eq 0 || $kpiDuplicated -eq 1 ]]
do :
done

if [[ $kpiDeleted -eq 0 && $kpiModified -eq 0 ]]; then

    echo; echo -e "KPI - Key Performance Indicator: ${BLUE}${kpiCriteria[$kpiCounter]}${NC}"

    while

    echo; echo -en "Please enter the Rate obtained (${ITALIC}min 0 - max 10${NC}): "
    read rate

    if [[ !($rate =~ $REGEX_RATE) ]]; then
        echo; echo -e "${RED}Rate must be between ${BLUE}0 - 10${RED}. Enter (${YELLOW}q${RED}) to quit.${NC}";
    fi

    if [ "$rate" == "q" ]; then
        #Return to Menu
        isAddMore=0
        ./EmpValidationForm.sh; exit 0
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

fi

while
	echo; echo -en "Press (${GREEN}y${NC}) to continue to enter the Employee's marks or (${RED}b${NC}) to return to the previous screen: "
    read -n 1 response; response=$(echo "$response" | tr 'A-Z' 'a-z')

	if [[ !($response =~ $REGEX_RESPONSE_PRF)  ]]; then
		echo;echo; echo -e "Please enter either (${GREEN}y${NC}) or (${RED}b${NC})"
	fi

	[[ !($response =~ $REGEX_RESPONSE_PRF) ]]

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
        printf "%-26s %-28s %-22s\n" "KPI Criteria:" "Rate Obtained:" "Comments:"
        printf "==============================================================================\n"
    ) > "${icNo}KPIResult/$from-$to.txt"
    isFirstTime=0
fi
    
echo "$(head -n 10 ${icNo}KPIResult/$from-$to.txt)" > "${icNo}KPIResult/$from-$to.txt"
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
) >> "${icNo}KPIResult/$from-$to.txt"

if [[ $kpiDeleted -eq 0 && $kpiModified -eq 0 ]]; then
    kpiCounter=$(( $kpiCounter + 1 ))
fi

if [[ $response == 'b' ]]; then
    isAddMore=0

    if [[ $kpiCounter -ne 0 ]]; then
        printf "\n\n${LIGHTYELLOW}Would you like to see the created Employee Performance Review?${NC}"

        while
            printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')
            
            if [[ "$choice" == "y" ]]; then
                clear
                printf "\n%50s\n%52s\n" "Employee Performance Review" "==============================="
                printf "\nEmployee IC. Number    : $icNo\n"
                printf "Employee Name          : $name\n"
                printf "Review Period          : From $from To $to\n\n"
                printf "==============================================================================\n"
                printf "%-26s %-28s %-22s\n" "KPI Criteria:" "Rate Obtained:" "Comments:"
                printf "==============================================================================\n"

                i=0; avgRatingScore=0
                while [ $i -lt ${#kpiCriteria[@]} ]; do
                    printf "%-32s %-22s %-22s\n" "${kpiCriteria[$i]}" "${perfRate[$i]}" "${perfComment[$i]}"
                    avgRatingScore=$(( $avgRatingScore+${perfRate[$i]} ))
                    i=$(( $i+1 ))
                done

                avgRatingScore=$(( $avgRatingScore / ${#perfRate[@]} ))
                echo; echo "Average Performance Rating Score: $avgRatingScore"
                perfAdj=$(getStaffPerformance $avgRatingScore)
                echo; echo "Overall staff performance: $perfAdj"; echo; echo

                printf "${LIGHTYELLOW}Press any key to continue ${NC}"
                read -n 1 -s -r -p ""

                ./EmpValidationForm.sh; exit 0
            fi
    
        [[ "$choice" != "y" && "$choice" != "n" ]]
        do :
        done
    else
        rm -f "${icNo}KPIResult/$from-$to.txt"
    fi

    ./EmpValidationForm.sh; exit 0
fi
    
clear

[[ isAddMore -eq 1 ]]
do : 
done
