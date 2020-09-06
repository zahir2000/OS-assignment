#!/bin/bash
clear
addKPI="Y"

while [ "$addKPI" = "Y" ]; do
declare -a kpiArray
mapfile -t kpiArray < KPI.txt

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s %s %s\n" "|" " Add New Key Performance Indicator (KPI) Form " "|"
printf "%s\n" "+————————————————————————————————————————————————+"
echo "KPI Code (Auto generated) :" $(printf "KPI_%02d" "$((${#kpiArray[@]} + 1))")
echo -n "KPI Evaluation Criteria   : "
read KPICriteria
echo -n "Description               : "
read desc

if ! [[ "$KPICriteria" =~ ^[a-zA-Z\ ]+$ ]]; then
   echo "KPI evaluation criteria only allow white space and alphabet. Please enter again."
fi

if ! [[ "$desc" =~ ^[a-zA-Z\,\.\ ]+$ ]]; then
   echo "Description only allow alphabet, comma, full stop, and whitespace."
fi

if [[ "$desc" =~ ^[a-zA-Z\,\.\ ]+$ && "$KPICriteria" =~ ^[a-zA-Z\ ]+$ ]]; then
   yesNo="Not YN"
   while ! [[ "$yesNo" = "Y" || "$yesNo" = "N" ]]; do
   echo -n "Are you sure you want to add this new KPI? (Y)es or (N)o : "
   read yesNo
   if [ "$yesNo" = "Y" ]; then
      printf '%s:%s:%s\n' $(printf "KPI_%02d" "$((${#kpiArray[@]} + 1))") "$KPICriteria" "$desc" >> KPI.txt
   elif [ "$yesNo" = "N" ]; then
      break
   else
      echo "Invalid choice. Please select Y or N."
   fi
   done
fi

addKPI="Not YQ"
while ! [[ "$addKPI" = "Y" || "$addKPI" = "Q" ]]; do
echo -n "Add Another KPI? (Y)es or (Q)uit : "
read addKPI
if [ "$addKPI" = "Y" ]; then
   addKPI="Y"
elif [ "$addKPI" = "Q" ]; then
   echo; break
else
   echo "Invalid choice. Please select Y or Q."
fi
done
done
./Task1_Menu.sh
