#!/bin/bash
export LANG=zh_CN.UTF-8

# 获取操作系统信息
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_DESCRIPTION
elif [ -f /etc/debian_version ]; then
    OS="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ]; then
    OS=`cat /etc/redhat-release`
else
    OS="$(uname -s) $(uname -r)"
fi

echo "操作系统：$OS"

# 获取内存信息
echo "内存信息："
free -h

# 获取 CPU 信息
echo "CPU 信息："
lscpu | grep "型号名称"
lscpu | grep "体系结构"

#输出结果为 KVM 或者 Bochs，则表示当前系统正在运行在 KVM 虚拟机或 Bochs 模拟器中。如果输出结果为空或是其他值，则表示当前系统没有运行在 KVM 环境中。
cat /sys/class/dmi/id/product_name
dmidecode -s system-product-name
