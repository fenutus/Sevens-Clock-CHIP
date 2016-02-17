#!/bin/bash

pinit()
{
        source gpioFree.sh

        pins=( "408" "409" "410" "411" "412" "413" "414" "415" "132" "133" "134" "135" "136" "137" "138" "139" )

        for p in "${pins[@]}"
        do
                gpio_enable "$p"
                gpio_mode "$p" out
                gpio_write "$p" 0
        done
}

pclear()
{
        source gpioFree.sh

        pins=( "408" "409" "410" "411" "412" "413" "414" "415" "132" "133" "134" "135" "136" "137" "138" "139" )

        for p in "${pins[@]}"
        do
                gpio_disable "$p"
        done
}
