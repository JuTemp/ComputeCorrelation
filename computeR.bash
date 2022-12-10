#!/bin/bash

# bash computeR.bash "1 2 3 4" "5 6 7 8"

function mean()
{
  arr=($@)
  r=0
  for i in ${arr[@]}
  do
    r=`echo "scale=18;$r+$i" | bc`
  done
  echo "scale=18;$r/${#arr[@]}" | bc
}

xarr=($1)
yarr=($2)
xm=`mean "${xarr[@]}"`
ym=`mean "${yarr[@]}"`
len=0
if [ ${#xarr[@]} -ne ${#yarr[@]} ]
then
  echo "Array numbers are not equal. Exit."
  exit
else
  len=${#xarr[@]}
fi

ssr=0
varx=0
vary=0
for i in `seq 0 1 $(($len - 1))`
do
  dxm=`echo "scale=18;${xarr[i]}-$xm" | bc`
  dym=`echo "scale=18;${yarr[i]}-$ym" | bc`
  ssr=`echo "scale=18;$ssr+$dxm*$dym" | bc`
  varx=`echo "scale=18;$varx+$dxm*$dxm" | bc`
  vary=`echo "scale=18;$vary+$dym*$dym" | bc`
done
sst=`echo "scale=18;sqrt($varx*$vary)" | bc`
printf "%.18f" `echo "scale=18;1/3"|bc`
