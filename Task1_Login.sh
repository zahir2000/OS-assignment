#!/bin/bash
. ./permissions.sh
clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s %s %s\n" "|" "  Welcome to the HR Management Login Screen!  " "|"
printf "%s\n" "+————————————————————————————————————————————————+"
echo

wrong="Wrong Login"
position="Not Manager"
while [[ "$wrong" = "Wrong Login" || "$position" = "Not Manager" ]]
do

declare -a loginArray
mapfile -t loginArray < Login.txt
numOfCol="${#loginArray[@]}"

echo -n "Email:    "
read email
echo -n "Password: "
read -s pass
echo

for ((i=0; i<numOfCol; i++)) do
if [[ $(echo "${loginArray[$i]}" | cut -d':' -f 1) = "$email" && $(echo "${loginArray[$i]}" | cut -d':' -f 2) = "$pass" ]]; then
   if [[ $(echo "${loginArray[$i]}" | cut -d':' -f 4) = "Manager" ]]; then
      echo "Login Successful."
      echo
      wrong="Correct Login"
      postion="Manager"
      break;
   else
      wrong="Correct Login"
      position="Not Manager"
   fi
else
   wrong="Wrong Login"
fi
done

if [[ "$wrong" = "Correct Login" ]]; then
   if ! [[ "$position" = "Not Manager" ]]; then
      echo "You don't have priviledge to access."
      echo
   else
      ./Task1_Menu.sh
      break;
   fi
else
   echo "Invalid email/password. Please enter again."
   echo
fi
done
