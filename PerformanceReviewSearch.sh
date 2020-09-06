#!/bin/bash

. ./configs.sh
clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Search           " "|"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while

echo "Please Enter the Employee's IC. Number:-"
echo -en "(${GREEN}xxxxxx-xx-xxxx${NC}): "
read icNo; icNo=$(echo "$icNo" | tr 'A-Z' 'a-z')

while

	#If IC is not in correct format
	if [[ !($icNo =~ $REGEX_IC) ]]; then
		echo
		echo -e "${RED}Incorrect IC. Number entered.${NC}"
		echo -e "Please follow (${GREEN}xxxxxx-xx-xxxx${NC}) format. Enter (${RED}q${NC}) to quit."
		echo
		echo -en "IC (${GREEN}xxxxxx-xx-xxxx${NC}): "
		read icNo; icNo=$(echo "$icNo" | tr 'A-Z' 'a-z')
	fi
	
	#If user quit
	if [ $icNo == 'q' ]; then
		./PerformanceReviewMenu.sh
        exit 0
	fi
	
	#Loop while IC format is not correct
	[[ !($icNo =~ $REGEX_IC) ]]
do :
done

employeeFound=0

if [ -f "$employeeFile" -a -r "$employeeFile" ]; then
    while IFS=':' read -r empDep empIc empName empPh empEmail empGender empDob empJb empJoinDate ; do
        if [ "$icNo" == "${empIc//[[:blank:]]/}" ]; then
            name=$empName
            jobTitle=$empJb
            department=$empDep
            employeeFound=1
            break
        fi
    done < "$employeeFile"
fi

while  

if [[ $employeeFound -eq 1 ]]; then
    printf "\n${UNDERLINEBOLD}Employee Details:${NC}\n"
	echo -e "Employee Name  : ${LIGHTBLUE}$name${NC}"
	echo -e "Job Title      : ${LIGHTBLUE}$jobTitle${NC}"
	echo -e "Department     : ${LIGHTBLUE}$department${NC}"
    echo; printf "Searching for KPI Results."; sleep 1; printf "."; sleep 1; printf ".\n"

    printf "\n${UNDERLINEBOLDYELLOW}Search Results:${NC}\n"

    resultCounter=0; files=()
    if [[ -d "${icNo}KPIResult" && -r "${icNo}KPIResult" ]]; then
        filesCount=$(( $( ls -l "${icNo}KPIResult/" | wc -l ) - 1 ))
        #ls "${icNo}KPIResult/" | sort -k1.4,1.7 
        for entry in "${icNo}KPIResult"/*
        do
            file=$( echo ${entry} | cut -d "/" -f 2 | cut -d "." -f 1 )
            files+=("$file")
            resultCounter=$(( $resultCounter + 1 ))
            printf "${BOLD}%3s${NC} %-20s\n" "$resultCounter." "$file"
        done
    fi
 
    if [[ resultCounter -ne 0 ]]; then
    
        while
            printf "\nWhich file would you like to see (1 - $resultCounter): "
            read openFile; openFile=$(echo "$openFile" | tr 'A-Z' 'a-z')

            if [[ $openFile == 'q' ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            fi

            if [[ $openFile -lt 1 || $openFile -gt $resultCounter ]]; then
                printf "\n${LIGHTRED}Incorrect file number selected.${NC}\nPlease ensure it is within (${GREEN}1 - $resultCounter${NC})\n"
            fi

        [[ $openFile -lt 1 || $openFile -gt $resultCounter ]]
        do :
        done

        openFile=$(( $openFile - 1 ))
        resultFile="${icNo}KPIResult/${files[$openFile]}.txt"

        if [[ -f "$resultFile" && -r "$resultFile" ]]; then
            printf "\n${WHITE}================================================================================${WHITEBACKGROUND}\n\n"
            cat "$resultFile"
            echo -e "${WHITE}\n================================================================================${NC}"
        else
            echo -e "${RED}An error has occured. Please contact the administrator!${NC}"
        fi

    fi

    anotherFile="x"
    printf "\n${UNDERLINEBOLDYELLOW}Would you like to see another file?${NC}"

    while
        printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
        read -n1 anotherFile; anotherFile=$(echo "$anotherFile" | tr 'A-Z' 'a-z')

        if [[ "$anotherFile" == "n" ]]; then
            ./PerformanceReviewMenu.sh
            exit 0
        elif [[ "$anotherFile" == "y" ]]; then
            clear
            printf "%s\n" "+————————————————————————————————————————————————+"
            printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Search           " "|"
            printf "%s\n" "+————————————————————————————————————————————————+"
        fi

    [[ "$anotherFile" != "y" && "$anotherFile" != "n" ]]
    do :
    done

else
    echo; echo -e "Employee with ${LIGHTBLUE}$icNo${LIGHTRED} does not exist.${NC} Enter (${YELLOW}q${NC}) to return to HR Management Menu\n"
fi

[[ $anotherFile == "y" ]]
do : 
done

[[ $employeeFound -eq 0 ]]
do :
done