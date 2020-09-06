#!/bin/bash

clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s %s %s\n" "|" "        Human Resouces Management Menu        " "|"
printf "%s\n" "+————————————————————————————————————————————————+"
echo "E - Add New Employees"
echo "K - Add New Key Performance Indicator (KPI)"
echo "R - Performance Review"
echo
echo "Q - Quit (exit from program)"

choice=""

while ! [[ "$choice" = "E" || "$choice" = "K" || "$choice" = "R" || "$choice" = "Q" ]]; do
echo
echo -n "Please select a choice: "
read choice
case "$choice" in
    E) ./Task2_AddNewEmployee.sh;;
    K) ./Task3_AddNewKPI.sh;;
    R) ./PerformanceReviewMenu.sh;;
    Q) printf "\nSuccessfully quit the program."; sleep 2; echo; exit 0;;
    *) echo; echo "Invalid choice! Please select E, K, R or Q."
esac
done
