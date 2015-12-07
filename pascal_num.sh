#!/usr/bin/bash

n=$1

if [ -z $n ]
then
read -p "Row Number:" n
fi

typeset -A Tab

Tab[0,0]=1
for i in $(seq 1 $n)
do
  Tab[$i,0]=1
  for j in $(seq 1 $(($i-1)))
  do
    a=${Tab[$((i-1)),$((j-1))]}
    b=${Tab[$((i-1)),$j]}
    Tab[$i,$j]=$(( a + b ))
  done
  Tab[$i,$i]=1
done

summary()
{
  for i in $(seq 0 $n)
  do
    for j in $(seq 0 $i)
    do
      echo -n ${Tab[$i,$j]} " "
    done
    echo
  done
  echo
}

summary
