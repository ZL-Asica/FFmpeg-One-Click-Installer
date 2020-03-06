#!/usr/bin/env bash
#
# Auto install ffmpeg
# 自动安装ffmpeg
#
# System Required:  CentOS 6/7, Ubuntu, Debian
#
# Copyright (C) 2019-2020 ZL Asica <zl@zla.moe>
#
# URL: https://www.zla.moe/
#

red='\033[0;31m'
cyan='\033[1;36m'
plain='\033[0m'
light_blue='\033[1;34m'

cur_dir=$(pwd)

[[ $EUID -ne 0 ]] && echo -e "${red}错误:${plain} 此脚本必须以root账户运行!" && exit 1

if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo "此脚本仅可运行于centos 6/7，Ubuntu，Debian"
fi

arch=$( uname -m )
lbit=$( getconf LONG_BIT )

# 变量 v  保存命令执行结果 使用反斜单引号 （``）包裹命令
 
v=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`

#开始安装
clear
start(){
    if [ $release -eq centos ]; then
        rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
        if [ $v -eq 7 ]; then
            rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
        elif [ $v -eq 6 ]; then
            rpm -Uvh http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm
        fi
        yum update
        yum install ffmpeg ffmpeg-devel -y
    else
        add-apt-repository ppa:jonathonf/ffmpeg-4
        apt update
        apt install ffmpeg
    fi
    ffmpeg
    if [ $? -ne 0 ]; then
        clear
    else
        echo "ffmpeg安装失败，建议重试或选择编译安装" && exit 1
    fi
    echo "----------------------------------------"
    echo "${cyan}ffmpeg已安装完成(Complete!)"
    echo "有任何问题欢迎通过邮箱给我反馈"
    echo "也欢迎访问我的博客 https://www.zla.moe/"
    echo "zl@zla.moe"
}

echo "---------- 系统信息 ----------"
echo " OS      : $release"
echo " Arch    : $arch ($lbit Bit)"
echo "------------ 脚本信息 ---------------------"
echo "ZL Asica的ffmpeg一键安装脚本(V1.0)"
echo "本脚本用于为centos 6/7，Ubuntu，Debian一键安装ffmpeg"
echo "By-ZL Asica"
echo "我的博客: https://www.zla.moe/"
echo "------------ 操作提示 ---------------------"
echo "请键入y以继续，n以结束，或你可以直接摁下 Ctrl+C 以退出"
read -p "y/n:" choice
case $choice in
	"y")
	start
	;;
	"n")
	exit 0;
	;;
	*)
	echo "请键入单字母 y 或 n!"
	;;
esac