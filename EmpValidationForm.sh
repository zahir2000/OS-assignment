#!/bin/bash

REGEX_IC="^([0-9]{6}-[0-9]{2}-[0-9]{4})|(q)$"
REGEX_PERIOD="^(((0[1-9])|(1[0-2]))-[12][0-9]{3})|(q)$"
REGEX_RESPONSE="^((n|N)|(q|Q))$"

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
LIGHTBLUE="\033[0;94m"
YELLOW="\033[0;33m"
NC="\033[0m"
BOLD="\033[1m"
BOLDRED="\033[31;1m"
BOLDYELLOW="\033[33;1m"
ITALIC="\033[3m"
UNDERLINE="\033[4m"

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

compareDate() {
	if [ $3 -ge $1 -a $3 -le $2 ]; then
		echo 1
	fi
}

clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "           Employee Validation Form           " "|"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while
echo "Please Enter The Review Period:-"
echo -en "FROM (${GREEN}mm-yyyy${NC}): " 
read from;

while [[ !($from =~ $REGEX_PERIOD) ]]; do
	echo
	echo -e "${RED}Incorrect date entered.${NC}"
	echo -e "Please follow (${GREEN}mm-yyyy${NC}) format. Enter (${RED}q${NC}) to quit."
	printf "${LIGHTBLUE}Year must be between 1000 to 2999${NC}\n"
	echo
	echo -en "FROM (${GREEN}mm-yyyy${NC}): " 
	read from;
done

if [[ $from == 'q' ]]; then
    #Return to menu
    exit 0;
fi

echo -en "TO   (${GREEN}mm-yyyy${NC}): " 
read to;

while [[ !($to =~ $REGEX_PERIOD) ]]; do
	echo
	echo -e "${RED}Incorrect date entered.${NC}"
	echo -e "Please follow (${GREEN}mm-yyyy${NC}) format. Enter (${RED}q${NC}) to quit."
	printf "${LIGHTBLUE}Year must be between 1000 to 2999${NC}\n"
	echo
	echo -en "TO   (${GREEN}mm-yyyy${NC}): " 
	read to;
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
echo -en "(${GREEN}xxxxxx-xx-xxxx${NC}): "
read icNo;

while

	#If IC is not in correct format
	if [[ !($icNo =~ $REGEX_IC) ]]; then
		echo
		echo -e "${RED}Incorrect IC. Number entered.${NC}"
		echo -e "Please follow (${GREEN}xxxxxx-xx-xxxx${NC}) format. Enter (${RED}q${NC}) to quit."
		echo
		echo -en "IC (${GREEN}xxxxxx-xx-xxxx${NC}): "
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
    while IFS=':' read -r empDep empIc empName empPh empEmail empGender empDob empJb empJoinDate ; do
        if [ "$icNo" == "${empIc//[[:blank:]]/}" ]; then
            name=$empName
            jobTitle=$empJb
            department=$empDep
            employeeFound=1
            break
        fi
    done < "$filename"
fi

if [[ employeeFound -eq 1 ]]; then

	echo;
	echo -e "Employee Name  : ${BLUE}$name${NC}"
	echo; echo -e "Job Title      : ${BLUE}$jobTitle${NC}"
	echo; echo -e "Department     : ${BLUE}$department${NC}"

	while
	echo; echo -en "Press (${GREEN}n${NC}) to continue to the Employee Performance Review Form or (${RED}q${NC}) to quit from the prompt and return to Human Resource Management Menu: "
	read -n 1 response

	if [[ !($response =~ $REGEX_RESPONSE)  ]]; then
		echo;echo; echo -e "Please enter either (${GREEN}n${NC}) or (${RED}q${NC})"
	fi

	[[ !($response =~ $REGEX_RESPONSE) ]]

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
		#A check to see if the entered period falls within existing files...?
		#Retrieve ev

		if [[ -d "${icNo}KPIResult" && -r "${icNo}KPIResult" ]]; then
			#File Exists
			
			if [[ -f "${icNo}KPIResult/$from-$to.txt" && -r "${icNo}KPIResult/$from-$to.txt" ]]; then
				echo -e "${BOLDRED}There is a KPI Report with the same period.${NC}"
				printf "\n${UNDERLINE}Would you like to overwrite it?${NC}"
				
				while
                    printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
                    read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')

                    if [[ "$choice" == "y" ]]; then
						./PerformanceReviewForm.sh "$name" $icNo $to $from
                    elif [[ "$choice" == "n" ]]; then
                        ./EmpValidationForm.sh
                    fi

                [[ "$choice" != "y" && "$choice" != "n" ]]
                do :
                done
			else
				origFrom=$( echo $from | cut -d "-" -f 2 )$( echo $from | cut -d "-" -f 1 )
				origTo=$( echo $to | cut -d "-" -f 2 )$( echo $to | cut -d "-" -f 1 )
				clashCounter=0; clashedFiles=1
				
				for entry in "${icNo}KPIResult"/*
				do
					file=$( echo ${entry} | cut -d "/" -f 2 | cut -d "." -f 1 )
					entryFrom=$( echo $file | cut -d "-" -f 2 )$( echo $file | cut -d "-" -f 1 )
					entryTo=$( echo $file | cut -d "-" -f 4 )$( echo $file | cut -d "-" -f 3 )

					if [[ $(compareDate $entryFrom $entryTo $origFrom) == 1 || $(compareDate $entryFrom $entryTo $origTo) == 1 ]]; then
						if [ $clashCounter -eq 0 ]; then
							printf "${BOLDYELLOW}Warning${NC}\n"
							printf "The entered period (${GREEN}$from${NC} to ${GREEN}$to${NC}) clashes with the following employee review periods:\n"
							clashCounter=1
						fi

						echo "${clashedFiles}. $( echo $file | cut -d "-" -f 1,2 ) to $( echo $file | cut -d "-" -f 3,4 )"
						clashedFiles=$(( $clashedFiles + 1 ))
					fi
				done

				printf "\n${UNDERLINE}Would you like to continue to the Employee Performance Review Form?${NC}"

				while
                    printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
                    read -n1 choice; choice=$(echo "$choice" | tr 'A-Z' 'a-z')

                    if [[ "$choice" == "y" ]]; then
						./PerformanceReviewForm.sh "$name" $icNo $to $from
                    elif [[ "$choice" == "n" ]]; then
                        ./EmpValidationForm.sh
                    fi

                [[ "$choice" != "y" && "$choice" != "n" ]]
                do :
                done
				
				#./PerformanceReviewForm.sh "$name" $icNo $to $from
			fi
		else
			mkdir "${icNo}KPIResult"
			./PerformanceReviewForm.sh "$name" $icNo $to $from
		fi
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