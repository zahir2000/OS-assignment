#!/bin/bash
clear
choice=r

echo "========================="
echo "Department Selection Menu"
echo "========================="
echo "P - PD (Production Department)"
echo "U - PU (Purchasing Department)"
echo "S - SM (Sales and Marketing Department)"
echo "H - HR (Human Resource Department)"
echo "A - AF (Accounting and Finance Department)"
echo "I - IT (Information Technology Department)"
echo
echo "Q - Quit (Return to Human Resource Management Menu)"
echo

while [ "$choice" = "r" ]
do
echo -n "Please select a choice: "
read choice
case "$choice" in
P) ./Task2_AddNewEmployeeFormPD.sh;;
U) ./Task2_AddNewEmployeeFormPU.sh;;
S) ./Task2_AddNewEmployeeFormSM.sh;;
H) ./Task2_AddNewEmployeeFormHR.sh;;
A) ./Task2_AddNewEmployeeFormAF.sh;;
I) ./Task2_AddNewEmployeeFormIT.sh;;
Q) ./Task1_Menu.sh;;
*) echo; echo "Invalide choice! Please select P, U, S, H, A, I or Q."; choice=r; echo
esac
done

