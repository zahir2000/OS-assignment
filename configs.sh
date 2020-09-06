#Customizations
LIGHTBLUE="\033[0;94m"
BOLDRED="\033[31;1m"
BOLDYELLOW="\033[33;1m"
RED="\033[0;31m"
LIGHTRED="\033[0;91m"
LIGHTYELLOW="\033[0;93m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
NC="\033[0m"
ITALIC="\033[3m"
BOLD="\033[1m"
UNDERLINE="\033[4m"
UNDERLINEBOLD="\033[1;4m"
BOLDGREEN="\033[32;1m"
BOLDBLUE="\033[34;1m"
BOLDPURPLE="\033[35;1m"
UNDERLINEBOLDYELLOW="\033[33;1;4m"
WHITEBACKGROUND="\033[30;107m"
WHITE="\033[0;37m"

#Regular Expressions
REGEX_IC="^([0-9]{6}-[0-9]{2}-[0-9]{4})|(q)$"
REGEX_PERIOD="^(((0[1-9])|(1[0-2]))-[12][0-9]{3})|(q)$"
REGEX_RESPONSE="^(n|q)$"
REGEX_KPI="^(KPI_[0-9]{2})|(q|Q)$"
REGEX_RATE="^(([0-9]|10)|(q|Q))$"
REGEX_RESPONSE_PRF="^(y|b)$"
REGEX_CHOICE="^(m)|(d)|(r)$"

#Permissions
chmod u+x "PerformanceReviewForm.sh"
chmod u+x "PerformanceReviewSearch.sh"

#Text Files
kpiFile="KPI.txt"
employeeFile="Employee.txt"