#!/bin/bash
clear
choice="Y"
while [ "$choice" = "Y" ]
do
error="Got Error"

while [ "$error" = "Got Error" ]
do
error="No Error"
echo "=========================="
echo "Add New Employee Form (HR)"
echo "=========================="
echo -n "Employee IC.Number (001025-10-9999) : "
read ICNo

declare -a ICNoArray
mapfile -t ICNoArray < Employee.txt
numOfCol="${#ICNoArray[@]}"

for ((i=0; i<numOfCol; i++)) do
if [[ $(echo "${ICNoArray[$i]}" | cut -d':' -f 2) = "$ICNo" ]]
then
   echo; echo "Existing employee."
   sleep 3
   ./Task1_Menu.sh
fi
done

echo -n "Employee Name (Tan Mei Lee / @)     : "
read empName
echo -n "Contact Number (012-12345678)       : "
read contNo
echo -n "Email (tanml@bacs2093.my)           : "
read email
echo -n "Gender (M - Male/F - Female)        : "
read gender
echo -n "Birth Date (25-01-1979)             : "
read DOB
echo -n "Job Title (Accountant/Sales,etc)    : "
read jobTitle
echo -n "Joined Date (15-02-2003)            : "
read joinDate
echo

if [[ "$ICNo" =~ ^(([0-9]{2}((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01])|(0[13456789]|1[012])(0[1-9]|[12][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8])))|([02468][048]|[13579][26])0229)-(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|71|72|74|75|76|77|78|79|82|83|84|85|86|87|88|89|90|91|92|93|98|99)-[0-9]{4} ]]
then
if [[ "$gender" =~ ^(M|F)$ ]] ; then
    if [[ "$gender" = "M" && ! "${ICNo: -1}" =~ ^(1|3|5|7|9)$ ]] || [[ "$gender" = "F" && ! "${ICNo: -1}" =~ ^(2|4|6|8|0)$ ]] ; then
        echo "IC and gender does not match"
        error="Got Error"
    else
       if [[ "$gender" = "M" ]]; then
          gender="Male"
       elif [[ "$gender" = "F" ]]; then
          gender="Female"
       fi
    fi
else
    echo "Please select only M or F"
    error="Got Error"
fi

ICNoToDate=$(date -d$(echo "$ICNo" | cut -c1-6) +%d-%m-%Y)

if [[ "$DOB" =~ (^(((0[1-9]|1[0-9]|2[0-8])[\-](0[1-9]|1[012]))|((29|30|31)[\-](0[13578]|1[02]))|((29|30)[\-](0[4,6,9]|11)))[\-](19|[2-9][0-9])[0-9][0-9]$)|(^29[\-]02[\-](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$) ]]
then
    if ! [[ "$ICNoToDate" = "$DOB" ]]; then
        echo "IC date and Birth Date not match"
        error="Got Error"
    fi
else
    echo "Birth Date format is 25-02-2020. Please enter again."
    error="Got Error"
fi

else
    echo "IC format is 001225-10-9999. Please enter again."
    error="Got Error"
fi

if ! [[ "$empName" =~ ^[a-zA-Z\ \/\@]+$ ]]
then
echo "Employee name only allow alphabet, whitespace, "/" and "@". Please enter again."
error="Got Error"
fi

if ! [[ "$contNo" =~ ^(010|011|012|013|014|016|017|018|019)-[0-9]{7,8}$ ]]
then
echo "Contact number format is 012-12345678. Please enter again."
error="Got Error"
fi

if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]
then
echo "Wrong email format. Please enter again."
error="Got Error"
fi

if ! [[ "$jobTitle" =~ ^[a-zA-Z\ ]+$ ]]
then
   echo "Job title only allow whitespace and alpabet. Please enter again."
   error="Got Error"
fi

if ! [[ "$joinDate" =~ (^(((0[1-9]|1[0-9]|2[0-8])[\-](0[1-9]|1[012]))|((29|30|31)[\-](0[13578]|1[02]))|((29|30)[\-](0[4,6,9]|11)))[\-](19|[2-9][0-9])[0-9][0-9]$)|(^29[\-]02[\-](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$) ]]
then
   echo "Join Date format is wrong. Please enter again."
   error="Got Error"
fi

done

yesNo="Q"
while ! [[ "$yesNo" = "Y" || "$yesNo" = "N" ]]; do
echo -n "Are you sure you want to add employee $ICNo ? (Y)es or (N)o : "
read yesNo

if [[ "$yesNo" = "Y" ]]; then
printf '%s:%s:%s:%s:%s:%s:%s:%s:%s\n' 'HR' "$ICNo" "$empName" "$contNo" "$email" "$gender" "$DOB" "$jobTitle" "$joinDate" >> Employee.txt
elif [[ "$yesNo" = "N" ]]; then
break
else
echo "Invalid choice! Please select Y or N."
echo
fi
done

choice="not y"
while ! [[ "$choice" = "Y" || "$choice" = "Q" ]]; do
echo -n "Add Another Employee? (Y)es or (Q)uit : "
read choice

if [[ "$choice" = "Y" ]]; then
choice="Y"
elif [[ "$choice" = "Q" ]]; then
choice="Q"
else
echo "Invalid choice! Please select Y or Q."
echo
fi
done
done
./Task1_Menu.sh
