#!/bin/bash

. ./configs.sh
clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Delete           " "|"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while

. ./ReviewSearch.sh

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
        
        for entry in "${icNo}KPIResult"/*
        do
            file=$( echo ${entry} | cut -d "/" -f 2 | cut -d "." -f 1 )
            files+=("$file")
            resultCounter=$(( $resultCounter + 1 ))
            fileOutput=$( echo $file | sed s/./" to "/8 )
            printf "${BOLD}%3s${NC} %-20s\n" "$resultCounter." "$fileOutput"
        done
    fi
 
    if [[ resultCounter -ne 0 ]]; then
    
        while
            printf "\nWhich file would you like to ${RED}delete${NC} (1 - $resultCounter): "
            read deleteFile; deleteFile=$(echo "$deleteFile" | tr 'A-Z' 'a-z')

            if [[ $deleteFile == 'q' ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            fi

            if [[ $deleteFile -lt 1 || $deleteFile -gt $resultCounter ]]; then
                printf "\n${LIGHTRED}Incorrect file number selected.${NC}\nPlease ensure it is within (${GREEN}1 - $resultCounter${NC})\n"
            fi

        [[ $deleteFile -lt 1 || $deleteFile -gt $resultCounter ]]
        do :
        done

        deleteFile=$(( $deleteFile - 1 ))
        resultFile="${icNo}KPIResult/${files[$deleteFile]}.txt"

        fileOutput=$( echo ${files[$deleteFile]} | sed s/./" to "/8 )
        printf "\nAre you sure you want to delete ${RED}$fileOutput${NC}?"

        while
            printf "\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 confirmChoice; confirmChoice=$(echo "$confirmChoice" | tr 'A-Z' 'a-z')

            if [[ "$confirmChoice" == "y" ]]; then
                rm -f $resultFile
                printf "${GREEN}\n\nFile (${BOLDGREEN}$fileOutput${GREEN}) successfully deleted.${NC}"
            fi

        [[ "$confirmChoice" != "y" && "$confirmChoice" != "n" ]]
        do :
        done

        anotherFile="x"
        printf "\n\n${UNDERLINEBOLDYELLOW}Would you like to delete another file?${NC}"

        while
            printf "\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 anotherFile; anotherFile=$(echo "$anotherFile" | tr 'A-Z' 'a-z')

            if [[ "$anotherFile" == "n" ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            elif [[ "$anotherFile" == "y" ]]; then
                clear
                printf "%s\n" "+————————————————————————————————————————————————+"
                printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Delete           " "|"
                printf "%s\n" "+————————————————————————————————————————————————+"
            fi

        [[ "$anotherFile" != "y" && "$anotherFile" != "n" ]]
        do :
        done
    else
        echo -e "${ITALIC}No KPI results found.${NC}"

        printf "\n${UNDERLINEBOLDYELLOW}Would you like to search again?${NC}"

        while
            printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 searchAgain; searchAgain=$(echo "$searchAgain" | tr 'A-Z' 'a-z')

            if [[ "$searchAgain" == "n" ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            elif [[ "$searchAgain" == "y" ]]; then
                employeeFound=0
                clear
                printf "%s\n" "+————————————————————————————————————————————————+"
                printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Delete           " "|"
                printf "%s\n\n" "+————————————————————————————————————————————————+"
            fi

        [[ "$searchAgain" != "y" && "$searchAgain" != "n" ]]
        do :
        done
    fi
else
    echo; echo -e "Employee with ${LIGHTBLUE}$icNo${LIGHTRED} does not exist.\n${NC}Enter (${YELLOW}q${NC}) to return to HR Management Menu\n"
fi

[[ $anotherFile == "y" ]]
do : 
done

[[ $employeeFound -eq 0 ]]
do :
done