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
