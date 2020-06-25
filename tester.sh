#/usr/bin/bash
test_exit_status () {
    command ./207demography $2 $3 $4 &> /dev/null
    if [ $? == $1 ] ; then
        echo -e "\e[1m\e[92m"OK"\e[0m": $2 = $1
    else
        echo -e "\e[1m\e[91m"KO"\e[0m": $2 = $1
    fi
}
test_output () {
    EXPECT=mktemp
    OUTPUT=`command ./207demography $2 $3 $4 2>&1 | sed "$1q;d"`
    echo -e $5 > $EXPECT
    echo $OUTPUT | diff - $EXPECT > /dev/null
    if [ $? == 0 ] ; then
        echo -e "\e[1m\e[92m"OK"\e[0m": $2
    else
        echo -e "\e[1m\e[91m"KO"\e[0m": $2 "<" $(<$EXPECT) "\n\t>" $OUTPUT
    fi
    rm -rf $EXPECT
}
echo "> testing status..."
test_exit_status 84 BRAL BOL PER
test_exit_status 84 BRA BOLIU PER
test_exit_status 84 BRA BOL PERPO
test_exit_status 0 BRA BOL PER
test_exit_status 0 EUU
echo "> testing output..."
test_output "1" "BRA" "BOL" "PER" "Country: Bolivia, Brazil, Peru"
test_output "2" "BRA" "BOL" "PER" "Fit1"
test_output "3" "BRA" "BOL" "PER" " Y = 3.06 X - 5906.34"
test_output "4" "BRA" "BOL" "PER" "	Root-mean-square deviation: 2.22"
test_output "5" "BRA" "BOL" "PER" "	Population in 2050: 359.35"
test_output "6" "BRA" "BOL" "PER" "Fit2"
test_output "7" "BRA" "BOL" "PER" "	X = 0.33 Y + 1932.53"
test_output "8" "BRA" "BOL" "PER" "	Root-mean-square deviation: 2.22"
test_output "9" "BRA" "BOL" "PER" "	Population in 2050: 359.70"
test_output "10" "BRA" "BOL" "PER" "Correlation: 0.9991"