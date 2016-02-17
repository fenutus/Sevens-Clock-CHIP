#!/bin/bash

gpio_enable()
{
  PIN=$(($1));
  sudo sh -c "echo $PIN > /sys/class/gpio/export"
}

gpio_disable()
{
  PIN=$(($1));
  sudo sh -c "echo $PIN > /sys/class/gpio/unexport"
}

gpio_mode()
{
  PIN=$(($1));
  if [[ ! -d /sys/class/gpio/gpio$PIN ]] ; then
    echo "GPIO$1 has not been enabled yet, please call gpio_enable"
    return -1
  fi
  MODE=""
  if [[("$2" == "in")]] ; then
    MODE="in"
  elif [[("$2" == "out")]] ; then
    MODE="out"
  fi
  if [[ "$MODE" == "" ]] ; then
    echo 'Valid modes are "in" or "out"'
    return -1;
  fi
  sudo sh -c "echo $MODE > /sys/class/gpio/gpio$PIN/direction"
}

gpio_write()
{
  if [[("$#" -lt 2)]] ; then
    echo "Usage: gpio_write pin value"
    return -1
  fi
  PIN=$(($1));
  sudo sh -c "echo $2 > /sys/class/gpio/gpio$PIN/value"
}

gpio_read()
{
  PIN=$(($1));
  cat /sys/class/gpio/gpio$PIN/value
}
