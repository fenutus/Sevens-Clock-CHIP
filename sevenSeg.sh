#!/usr/bash

source ../code/gpioFree.sh

#current time
d=`date`
timeRaw=`echo "$d" | cut -d' ' -f 4`
time="${timeRaw:0:5}"

#this so can split e.g. 19:38 in to 1 9 3 8 for processing - removes colon
digits=(`echo $time | grep -o .`)
declare -A position=( ["0"]="0" ["1"]="1" ["2"]="3" ["3"]="4" )

#7-seg chips tend to use A-D B-C grouping of inputs, so output reordered
declare -A decToBin=( ["0"]="0000"  #0000
         ["1"]="0100"  #0001
         ["2"]="0001"  #0010
         ["3"]="0101"  #0011
         ["4"]="0010"  #0100
         ["5"]="0110"  #0101
         ["6"]="0011"  #0110
         ["7"]="0111"  #0111
         ["8"]="1000"  #1000
         ["9"]="1010" ) #1001

#pins available as standard on C.H.I.P.
declare -A pinOuts=( ["0"]="408 409 410 411"
         ["1"]="412 413 414 415"
         ["2"]=""       #blank line so it works with "position"
         ["3"]="132 133 134 135"
         ["4"]="136 137 138 139" )

#####################################
#           and so the magic        #
#####################################

for pos in  "${position[@]}"
do
#       echo "GPIOs: ${pinOuts[$pos]}" # output to cli - not necessary for main function
        pinArr=(`echo "${pinOuts[$pos]}" | egrep -o "[[:digit:]]{3}"`)
        pinList="${pinArr[$pos]}"
        word="${decToBin[${digits[$pos]}]}"
        bitArray=(`echo $word | grep -o .`)
        for i in {0..3}
        do
                gpio_write "${pinArr[i]}" "${bitArray[i]}"
#               echo "${pinArr[i]}" "${bitArray[i]}" #as above, print, not necessary for main function
        done
done
