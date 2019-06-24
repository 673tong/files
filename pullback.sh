#!/bin/bash
#Created by haiyun
num=50 #上限
for i in `awk '/Failed/{print $(NF-3)}' /var/log/secure|sort|uniq -c|sort -rn|awk '{if ($1>$num){print $2}}'`
do
iptables
 -I INPUT -p tcp -s $i --dport 22 -j DROP
done
