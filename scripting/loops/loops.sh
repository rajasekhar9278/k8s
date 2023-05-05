#!/bin/bash

# This program will print 1 to 10
TO_BE_INSTALLED=y
while [ "$TO_BE_INSTALLED" == "y" ]
do
    # ask the software to be installed
    read -p "Enter the software which you want to install: " NAME
    echo "software to be installed is $NAME"
    read -p "If you want to install more softwares enter y and any other key toexit: "TO_BE_INSTALLED
done

#!/bin/bash

TO_BE_INSTALLED


#!/bin/bash
# This program is to print simple intrest
echo "Enter the principal value"
read "p"
echo "Enter the rate of intrest"
read "r"
echo "Enter the time period"
read "t"
s=`exp $p\*$t\*$r/100
echo "The simple intrest is s"
read $s

#!/bin/bash
# This program is to print 
echo "Enter the radius of the circle"
read "r"
area=(echo"3.14*$r*$r" | bc)
echo "area of circle is   "$area