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