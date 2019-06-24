#!/bin/bash
#Created by kisen
num=50 #上限
systemver=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`


if [[ $systemver = "6" ]];then
echo "当前是Centos6系统"
for i in `awk '/Failed/{print $(NF-3)}' /var/log/secure|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'`
do
iptables -I INPUT -p tcp -s $i --dport 22 -j DROP
done

else 
echo "当前是Centos7系统"
for i in `awk '/Failed/{print $(NF-3)}' /var/log/secure|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'`
do
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=$i drop'
done
fi
