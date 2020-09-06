#!/bin/bash

. ./configs.sh
clear
errCounter=0

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "       Employee Performance Review Menu       " "|"
printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s %-46s %s\n" "|" "A - Add New Performance Review" "|"
printf "%s %-46s %s\n" "|" "S - Search Performance Review" "|"
printf "%s %-46s %s\n" "|" "D - Delete Performance Review" "|"
printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s %-46s %s\n" "|" "Q - Quit (Return to HR Management Menu)" "|"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while
    printf "Please select a choice: "
    read -n1 choice; choice=$(echo "$choice" | tr 'a-z' 'A-Z')

    case "$choice" in
    A) ./EmpValidationForm.sh;;
    S) ./PerformanceReviewSearch.sh;;
    D) ./PerformanceReviewDelete.sh;;
    Q) ./Task1_Menu.sh; exit 0;;
    *)
        printf "\n\n${LIGHTRED}Invalid choice entered. Please select either (${GREEN}A${LIGHTRED}) or (${BLUE}S${LIGHTRED}) or (${PURPLE}D${LIGHTRED}) or (${YELLOW}Q${LIGHTRED}).${NC}\n\n"
        errCounter=$(( $errCounter + 1 ))
        choice="x"   
    esac
[[ "$choice" == "x" && $errCounter -lt 3 ]]
do : 
done

if [[ $errCounter -eq 3 ]]; then
    printf "${YELLOW}Please stop spamming choices. You will be returned to Main Menu shortly ...${NC} "
    sleep 3; ./Task1_Menu.sh; exit 0
fi