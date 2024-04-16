
apt install -y software-properties-common
add-apt-repository ppa:ondrej/php


apt install -y php7.4 php7.4-fpm php7.4-mysql php7.4-xml php7.4-curl php7.4-gd php7.4-mbstring
apt install -y nginx
add-apt-repository ppa:ondrej/php
systemctl restart nginx
systemctl restart php7.4-fpm
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
apt install -y software-properties-common
add-apt-repository ppa:ondrej/php
apt install -y php8.1 php8.1-cli php8.1-fpm php8.1-mysql php8.1-xml php8.1-curl php8.1-gd php8.1-mbstring
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
sudo add-apt-repository ppa:nathan-renniewaldock/flux
sudo apt update
sudo apt install fluxgui
systemd-analyze
#可以帮助你优化Ubuntu系统：
#查看当前启动项 使用 systemd-analyze 命令来查看启动过程中各个阶段所花费的时间：
sudo apt autoremove
sudo apt autoclean
cat /proc/sys/vm/swappiness


sudo systemctl disable apport.service
sudo systemctl stop apport.service
sudo dpkg-reconfigure popularity-contest
sudo apt remove popularity-contest
systemctl list-units --type=service --state=running
##################

```bash
# 更新软件包列表
sudo apt update

# 安装 GNU Privacy Guard，用于加密和签名数据
sudo apt install gnupg

# 安装 GNU Privacy Assistant，一个图形化的 GPG 密钥管理工具
sudo apt install gpa

# 安装 KGpg，一个 KDE 环境下的 GPG 密钥管理工具
sudo apt install kgpg

# 安装 Seahorse，一个 GNOME 环境下的 GPG 密钥管理工具
sudo apt install seahorse

# 安装 OpenSSL，一个用于安全通信的加密和解密工具
sudo apt install openssl

# 安装 Cryptsetup，用于加密和解密磁盘分区的工具
sudo apt install cryptsetup

# 安装 GnuTLS Bin，提供了一系列用于 TLS/SSL 通信的工具
sudo apt install gnutls-bin

# 安装 Haveged，一个提供随机数的守护进程，用于加密和密钥生成
sudo apt install haveged

# 安装 Keychain，用于管理 SSH 和 GPG 密钥的工具
sudo apt install keychain

# 安装 Pwgen，用于生成随机密码的工具
sudo apt install pwgen

# 安装 Sshpass，用于自动化 SSH 密码输入的工具（慎用，可能会有安全风险）
sudo apt install sshpass
apt install sshpass
# 再次更新软件包列表，确保所有软件都是最新版本
sudo apt update


# 安装 DNSCrypt-Proxy，用于加密 DNS 请求的代理工具
#apt install dnscrypt-proxy
#sudo apt install dnscrypt-proxy
#sudo mv /etc/dnscrypt-proxy/dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml.backup


# 使用 cat 编辑 resolved.conf 文件，配置 DNS over TLS
sudo bash -c 'cat > /etc/systemd/resolved.conf <<EOF
[Resolve]
DNS=1.1.1.1 
#FallbackDNS=8.8.8.8 8.8.4.4
#Domains=
DNSSEC=allow-downgrade
DNSOverTLS=yes
#MulticastDNS=no
#LLMNR=no
Cache=no
#Cache=no-negative
#CacheFromLocalhost=no
#DNSStubListener=yes
#DNSStubListenerExtra=
#ReadEtcHosts=yes
#ResolveUnicastSingleLabel=no
EOF'
# 重启 systemd-resolved 服务以应用更改
sudo systemctl restart systemd-resolved

echo "已成功配置使用 DNS over TLS（DoT）的加密 DNS。"

echo 'net.core.default_qdisc=fq' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo apt install iftop nethogs bmon
sudo apt install default-jdk
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install rustc
sudo apt install golang-go

sudo apt install golang-go
sudo apt install libm-dev
sudo apt install git
sudo apt install emacs
sudo apt install vim


sudo apt update
sudo apt install gimp
 
Inkscape（矢量图形编辑器）

 
sudo apt update
sudo apt install inkscape
 
Pinta（简单的图像编辑器，类似于Windows的Paint）

 
sudo apt update
sudo apt install pinta
 
Krita（专业的绘图程序）

 
sudo snap install krita
 
Shotwell（图片管理器，用于查看和组织照片，通常预安装在Ubuntu中）

 
sudo apt update
sudo apt install shotwell
 
digiKam（高级的照片管理软件）

# 安装 Digikam 图片管理软件
sudo apt install digikam

# 安装 BleachBit 系统清理工具
sudo apt install bleachbit
 

# 安装 deborphan 工具，用于清理孤立的软件包
sudo apt install deborphan
sudo deborphan | xargs sudo apt-get -y remove --purge

 
sudo apt update
sudo apt install vlc
 
SMPlayer - 一个基于MPlayer的图形界面媒体播放器。

 
sudo apt update
sudo apt install smplayer
 
#Clementine - 一款现代化的音乐播放器和音乐库组织器。

 
sudo apt update
sudo apt install clementine
 
Rhythmbox - GNOME的音乐播放器。

 
sudo apt update
sudo apt install rhythmbox
 
#Audacious - 一个开源的音频播放器，专注于低资源利用率和高音质。

 
sudo apt update
sudo apt install audacious
 
#Banshee - 一款功能强大的媒体播放器，提供多种媒体源的支持。

 
sudo apt update
sudo apt install banshee
 

#音频处理工具：

#Audacity - 一个开源、跨平台的音频编辑和录制软件。

 
sudo apt update
sudo apt install audacity
 
#Ardour - 一个专业级的数字音频工作站（DAW），用于录制、编辑和混合音乐。

 
sudo apt update
sudo apt install ardour
 
#Hydrogen - 一个高级的电子鼓机程序。

 
sudo apt update
sudo apt install hydrogen
 
#LMMS (Linux MultiMedia Studio) - 一个完整的音乐制作工具。

 
sudo apt update
sudo apt install lmms
 
#Rosegarden - 一个音乐合成与编辑软件。

 
sudo apt update
sudo apt install rosegarden
 
#Mixxx - 一个用于DJing的开源软件。

 
sudo apt update
sudo apt install mixxx
 
#Jack Audio Connection Kit - 一个专业的音频服务器，用于复杂的音频操作和路由。

 
sudo apt update
sudo apt install jackd2

sudo apt update
sudo apt install bleachbit

sudo apt install deborphan
sudo deborphan | xargs sudo apt-get -y remove --purge
 
sudo apt install byobu
sudo purge-old-kernels

sudo apt update
sudo apt install stacer
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt update
sudo apt install shadowsocks-qt5

sudo apt install --reinstall linux-image-$(uname -r)

apt install openvpn-systemd-resolved
uname -r

# 清理旧的内核
sudo purge-old-kernels













