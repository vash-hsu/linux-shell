#!/bin/bash
n=$1
target=$2

usage()
{
  echo Usage  : $0 NUMBER FILENAME
  echo Example: $0 8 target.txt
}

if [ -z $n ]
then
echo "ERROR: Number is necessary"
echo
usage
exit 0
fi

if [ -z $target ]
then
echo "ERROR: FILENAME is necessary"
echo
usage
exit 0
fi

typeset -A Tab

# x, y, left, right
handle()
{
  x=$1
  y=$2
  left=$3
  right=$4
  sum=$(($left+$right))
  #echo $x, $y, $left, $right
  if [[ $x == 0 && $y == 0 ]]
  then
    echo zip 1.zip $target
  fi
  if [[ $left -eq 0 || $right -eq 0 ]]
  then
    return
  fi
  if [[ $x -ge $y && $left -gt $right ]]
  then
    return
  fi
  if [ $left != $right ]
  then
    echo zip $sum.zip $left.zip $right.zip
  else
    echo zip $sum.zip $left.zip
    echo ln -s $left.zip _$right.zip
    echo zip -u $sum.zip _$right.zip
    echo rm _$right.zip
  fi
}


Tab[0,0]=1
handle 0 0 1 0
for i in $(seq 1 $n)
do
  Tab[$i,0]=1
  handle $i  0  1  0
  # for((j=1;j<$i;j++))
  for j in $(seq 1 $(($i-1)))
  do
    a=${Tab[$((i-1)),$((j-1))]}
    b=${Tab[$((i-1)),$j]}
    Tab[$i,$j]=$(( a + b ))
    handle $i  $j  $a  $b
  done
  Tab[$i,$i]=1
  handle $i  $i  1  0
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

#summary
