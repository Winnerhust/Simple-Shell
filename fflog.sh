#!/bin/sh -
#根据.conf配置文件中的logfile指定的日志文件路径，读取日志
if [ "$1" = "-h" ]
then 
    echo usage: fflog asyntab.conf
    return 
else :
fi

if [ -f $1 ]
then :
else
    echo $1 is not exist!
    return
fi

log=$(awk -F= '/^logfile=/ {print $2 }' $1)

s=1
for i in $log*.log
do 
    echo [$s]:$i
    s=$((s+1))
done

echo please input an id of logs:
read id

s=1
ch_log=1
for i in $log*.log
do
    if [ $s -eq $id ]
    then 
        ch_log=$i
        #echo you choose $ch_log
        break
    else
        s=$((s+1))
    fi
done

echo begin to follow the tail to $ch_log:
tail -f $ch_log
