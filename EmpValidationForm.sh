#!/bin/bash

REGEX_IC="^([0-9]{6}-[0-9]{2}-[0-9]{4})|(q)$"
REGEX_PERIOD="^(((0[1-9])|(1[0-2]))-[0-9]{4})|(q)$"
REGEX_RESPONSE="^(n|q)$"

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
NC="\033[0m"

filename="Employee.txt"
employee=""

getName() {
	echo $1 | cut -d ":" -f 3
}

getJobTitle() {
	echo $1 | cut -d ":" -f 8
}

getDepartment() {
	echo $1 | cut -d ":" -f 1
}

checkDate() {
    toMon=$( echo "$1" | cut -d'-' -f 1 )
    fromMon=$( echo "$2" | cut -d'-' -f 1 )

    toYear=$( echo "$1" | cut -d'-' -f 2 )
    fromYear=$( echo "$2" | cut -d'-' -f 2 )

    if [ $toYear -gt $fromYear ]; then
        echo 1
    elif [ $toYear -ge $fromYear -a $toMon -gt $fromMon ]; then
        echo 1
    else
        echo 0
    fi
}

clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s\n" "|            Employee Validation Form            |"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while
echo "Please Enter The Review Period:-"
echo -n "FROM (mm-yyyy): " 
read from;

while [[ !($from =~ $REGEX_PERIOD) ]]; do
	echo
	echo -e "${RED}Incorrect date entered.${NC}"
	echo -e "Please follow (${GREEN}mm-yyyy${NC}) format. Enter (${RED}q${NC}) to quit."
	echo
	echo -n "FROM (mm-yyyy): " 
	read from;
	
	if [ $from == 'q' ]; then
		#Return to Menu
		exit 1;
	fi
done

if [[ $from == 'q' ]]; then
    #Return to menu
    exit 0;
fi

echo -n "TO   (mm-yyyy): " 
read to;

while [[ !($to =~ $REGEX_PERIOD) ]]; do
	echo
	echo -e "${RED}Incorrect date entered.${NC}"
	echo -e "Please follow (${GREEN}mm-yyyy${NC}) format. Enter (${RED}q${NC}) to quit."
	echo
	echo -n "TO (mm-yyyy): " 
	read to;
	
	if [ $to == 'q' ]; then
		#Return to Menu
		exit 1;
	fi
done

if [[ $to == 'q' ]]; then
    #Return to menu
    exit 0;
fi

if [[ $(checkDate "$to" "$from") == 0 ]]; then
	echo; echo -e "${RED}TO ($to) date must be after the FROM ($from) date${NC}"; echo;
fi

[[ $(checkDate "$to" "$from") == 0 ]]
do :
done

echo;

while

echo "Please Enter the Employee's IC. Number:-"
echo -n "(xxxxxx-xx-xxxx): "
read icNo;

while

	#If IC is not in correct format
	if [[ !($icNo =~ $REGEX_IC) ]]; then
		echo
		echo -e "${RED}Incorrect IC. Number entered.${NC}"
		echo -e "Please follow (${GREEN}xxxxxx-xx-xxxx${NC}) format. Enter (${RED}q${NC}) to quit."
		echo
		echo -n "IC (xxxxxx-xx-xxxx): "
		read icNo;
	fi
	
	#If user quit
	if [ $icNo == 'q' ]; then
		#Return to Menu
		exit 1;
	fi
	
	#Loop while IC format is not correct
	[[ !($icNo =~ $REGEX_IC) ]]
do :
done

employeeFound=0

if [ -f "$filename" -a -r "$filename" ]; then
	while read line; do
		while IFS=':' read -ra ADDR; do
			for i in "${ADDR[1]}"; do
				if [ "$icNo" == "${i//[[:blank:]]/}" ]; then
					# "Match found!"
					employee="$line"
					employeeFound=1
					break;
				fi
			done;
		done <<< "$line"
	done < $filename
fi

if [[ employeeFound -eq 1 ]]; then

	name=$(getName "$employee")
	jobTitle=$(getJobTitle "$employee")
	department=$(getDepartment "$employee")

	echo;
	echo -e "Employee Name: ${BLUE}$name${NC}"
	echo; echo -e "Job Title: ${BLUE}$jobTitle${NC}"
	echo; echo -e "Department: ${BLUE}$department${NC}"

	while
	echo; echo -en "Press (${GREEN}n${NC}) to continue to the Employee Performance Review Form or (${RED}q${NC}) to quit from the prompt and return to Human Resource Management Menu: "
	read -n 1 response

	if [[ !($response =~ $REGEX_RESPONSE)  ]]; then
		echo;echo; echo -e "Please enter either (${GREEN}n${NC}) or (${RED}q${NC})"
	fi

	[[ $response != 'n' && $response != 'q' ]]

	do :
	done

	echo; echo;

    case "$response" in
    [qQ])
        #return to menu
        exit 0
        ;;
    [nN])
        #Check if the period already exists(matches), then ask to override or return.
        #check if there is a match with the year (both years)
        ./PerformanceReviewForm.sh "$name" $icNo $to $from
        ;;
    *)
        echo "Invalid Choice!"
    esac
fi

if [[ employeeFound -eq 0 ]]; then
	echo; echo -e "${RED}IC. Number (${BLUE}$icNo${RED}) does not belong to any existing employees. Enter (${YELLOW}q${RED}) to quit${NC}"; echo
fi

[[ employeeFound -eq 0 ]]

do :
done