#!/bin/bash

#variables

ARCH=$(uname -a)
CPU=$(nproc)
VCPU=$(cat /proc/cpuinfo | grep processor | wc -l)
MEM=$(free --mega | awk 'NR==2' | awk '{print $3}')"/"$(free --mega | awk 'NR==2' | awk '{print $4}')"MB ("$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')"%)"
DSK=$(df -Bm | awk 'NR==4' | awk '{print $3}' | awk '{print substr($0, 0, 4)}')"/"$(df -Bg | awk 'NR==4' | awk '{print $4}')" ("$(df -Bg | awk 'NR==4' | awk '{print $5}')")"
CPL=$(top -n 1 -b | grep load | awk '{print $11}' | awk '{print substr($0, 0, 3)}')"%"
LB=$(who -b | awk '{print $3, $4}')
LVM=$(lsblk | grep lvm | wc -l)
LV=$(if [ $LVM == 0 ];then echo "#LVM use: no"; else echo "#LVM use: yes"; fi)
TCP=$(ss -s | grep estab | awk '{print $4}' | awk '{print substr($0, 0, 1)}')" ESTABLISHED"
USR=$(who|wc -l)
IP=$(hostname -I)" ("$(ip addr | grep link | awk 'NR==2'| awk '{print $2}')")"
SUDO=$(sudo grep sudo /var/log/auth.log | wc -l)" cmd"

#printing

wall "
	#Architecture: $ARCH
	#CPU physical : $CPU
	#vCPU : $VCPU
	#Memory Usage: $MEM
	#Disk Usage: $DSK
	#CPU load: $CPL
	#Last boot: $LB
	$LV
	#Connexions TCP : $TCP
	#User log: $USR
	#Network: IP $IP
	#Sudo : $SUDO "
