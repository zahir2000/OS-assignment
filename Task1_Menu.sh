#!/bin/bash

clear
chmod u+x "Task2_AddNewEmployee.sh"
chmod u+x "Task3_AddNewKPI.sh"
chmod u+x "EmpValidationForm.sh"

echo "=============================="
echo "Human Resouces Management Menu"
echo "=============================="
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
    R) ./EmpValidationForm.sh;;
    Q) exit 0;;
    *) echo; echo "Invalid choice! Please select E, K, R or Q."
esac
done
