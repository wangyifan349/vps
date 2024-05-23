#https://bridges.torproject.org/bridges?transport=obfs4


# 清除系统代理设置
gsettings set org.gnome.system.proxy mode 'none'
# 清除转发规则
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -t raw -F
sudo iptables -t raw -X
sudo iptables -t filter -F
sudo iptables -t filter -X






apt install gcc
apt install g++
apt install python3
apt install python3-pip
apt install default-jdk
apt install nodejs
apt install npm
npm install -g typescript
apt install git

pip install Pillow requests  opencv-python urlllib3

apt install build-essential cmake pkg-config libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev libexpat1-dev libpgm-dev qttools5-dev-tools libhidapi-dev libusb-1.0-0-dev libprotobuf-dev protobuf-compiler libudev-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev libboost-locale-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev python3 ccache doxygen graphviz

apt install libevent-dev libminiupnpc-dev libnatpmp-dev libsqlite3-dev
   #这部分是比特币需要的
apt-get install python3-pyqt5
apt-get install libsecp256k1-dev
apt-get install automake libtool
apt-get install python3-cryptography
apt-get install python3-setuptools python3-pip
apt-get install python3-requests gettext qttools5-dev-tools
#洋葱基本的需要
apt install apt-transport-https  git  wget
wget -qO- https://deb.torproject.org/torproject.org/\
A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import

gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
    | sudo apt-key add -

apt install tor deb.torproject.org-keyring


# Add cloudflare gpg key
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
# Add this repo to your apt repositories
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
# Install
sudo apt-get update && sudo apt-get install cloudflare-warp


############基本网络工具
# 安装 Wireshark 抓包工具
apt install wireshark -y

# 补充的基本网络工具：
# 1. ping：用于测试网络连接和测量主机之间的往返时间
# 2. traceroute：用于跟踪数据包从源到目的地的路径
# 3. netstat：用于显示网络状态和连接信息
# 4. ifconfig：用于配置和显示网络接口信息
# 5. arp：用于显示和修改 ARP 缓存
# 6. nslookup：用于查询 DNS 名称服务器
# 7. dig：用于执行 DNS 查询
# 8. curl：用于通过 URL 进行数据传输
# 9. wget：用于从网络上下载文件
# 10. nmap：用于网络发现和安全扫描
# 11. tcpdump：用于抓取和分析网络数据包
# 12. iptables：用于配置 Linux 防火墙和 NAT 规则
# 13. ssh：用于远程登录到其他计算机
# 14. scp：用于在本地和远程系统之间安全地复制文件
# 15. telnet：用于与远程主机建立 Telnet 连接

# 安装补充的基本网络工具
apt install iputils-ping traceroute net-tools dnsutils curl wget nmap tcpdump iptables openssh-client openssh-server telnet -y
# 安装补充的基本网络工具：
# 1. htop：用于监视系统资源使用情况，包括 CPU、内存和网络等
# 2. iftop：用于实时监视网络流量，显示各个网络接口的实时流量信息
# 3. mtr：是 traceroute 和 ping 的结合体，用于诊断网络问题并测量网络延迟
# 4. speedtest-cli：用于测试 Internet 带宽速度
# 5. iperf：用于测试网络带宽和性能
# 6. ngrep：用于匹配和显示网络流量中的特定模式
# 7. tcpflow：用于捕获和保存 TCP 流量
# 8. netcat：用于创建 TCP/UDP 连接，进行端口扫描和网络调试
# 9. lynx：用于在终端中浏览网页，支持文本界面的网页浏览器
# 10. w3m：也是一个文本界面的网页浏览器，支持图像、表格和链接等元素
# 11. socat：用于建立双向的数据通道，支持多种协议的数据传输
# 12. siege：用于压力测试 Web 服务器，模拟大量用户访问
# 13. httperf：用于测试 Web 服务器的性能和负载能力
# 14. lsof：用于显示系统打开的文件和网络连接情况
# 15. nload：用于实时监视网络流量，以图形方式显示网络使用情况
# 安装补充的基本网络工具
apt install htop iftop mtr-tiny speedtest-cli iperf ngrep tcpflow netcat lynx w3m socat siege httperf lsof nload -y
sudo systemctl enable systemd-resolved
sudo systemctl start systemd-resolved

# 8. 使用 swappiness 设置交换空间的使用率
sudo sysctl vm.swappiness=10

# 9. 禁用自动更新
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl disable apt-daily-upgrade.service

# 10. 禁用不需要的服务（根据需要自行调整）
sudo systemctl disable bluetooth.service
sudo systemctl disable cups.service

# 15. 清理系统日志和临时文件
sudo journalctl --vacuum-time=7d
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo apt clean
# 12. 安装并使用 ZRAM 来增加内存压缩
sudo apt install zram-config
sudo systemctl enable zram-config

# 13. 使用 EarlyOOM 来避免系统死锁
sudo apt install earlyoom
sudo systemctl enable earlyoom

# 14. 使用 CPUFreq 控制 CPU 频率和调节器
sudo apt install indicator-cpufreq
# 13. 使用 EarlyOOM 来避免系统死锁
sudo apt install earlyoom
sudo systemctl enable earlyoom



# 23. 设置 CPU 调度策略为性能模式
sudo cpupower frequency-set -g performance


# 16. 禁用不必要的系统服务（根据需要自行调整）
sudo systemctl disable avahi-daemon.service
sudo systemctl disable ModemManager.service
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable networkd-dispatcher.service
sudo systemctl disable plymouth-quit-wait.service
sudo systemctl disable ufw.service
   
# 33. 清理旧日志文件
sudo journalctl --vacuum-time=7d
# 28. 清理临时文件
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# 29. 清理 APT 软件包缓存
sudo apt clean
# 27. 清理旧内核
sudo apt autoremove --purge


# 24. 禁用不必要的服务（继续）
sudo systemctl disable apport.service
sudo systemctl disable cups-browsed.service
sudo systemctl disable keyboard-setup.service
sudo systemctl disable lvm2-monitor.service
sudo systemctl disable multipathd.service
sudo systemctl disable nfs-client.target
sudo systemctl disable nfs-server.service
sudo systemctl disable plymouth-read-write.service
sudo systemctl disable speech-dispatcher.service
sudo systemctl disable udisks2.service
sudo systemctl disable wpa_supplicant.service

# 25. 禁用不必要的定时任务
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily-upgrade.service
sudo systemctl disable logrotate.service

# 34. 安装中文输入法（fcitx 输入法框架）
sudo apt install fcitx fcitx-config-gtk fcitx-module-cloudpinyin fcitx-sunpinyin

# 35. 安装中文语言包
sudo apt install language-pack-zh-hans language-pack-zh-hans-base   





# 34. 安装中文输入法（fcitx 输入法框架）
sudo apt install fcitx fcitx-config-gtk fcitx-module-cloudpinyin fcitx-sunpinyin

# 35. 安装中文语言包
sudo apt install language-pack-zh-hans language-pack-zh-hans-base

# 36. 设置默认输入法为 fcitx，并重启系统
im-config -n fcitx
reboot

# 37. 安装扩展字体和图标
sudo apt install fonts-noto-color-emoji fonts-firacode gnome-tweaks

# 38. 安装 GNOME Shell 扩展
sudo apt install gnome-shell-extensions gnome-shell-extension-dash-to-dock gnome-shell-extension-ubuntu-dock gnome-shell-extension-appindicator

# 39. 安装图标和主题
sudo apt install gnome-icon-theme gnome-icon-theme-symbolic arc-theme papirus-icon-theme

# 40. 安装 Plank Dock
sudo apt install plank

# 41. 安装 Conky 系统监视器
sudo apt install conky-all

# 42. 安装图形化系统优化工具
sudo apt install gnome-tweaks unity-tweak-tool

# 43. 安装 GIMP 图像编辑器
sudo apt install gimp

# 44. 安装 VLC 媒体播放器
sudo apt install vlc

# 45. 安装 LibreOffice 办公套件
sudo apt install libreoffice

# 46. 安装 Chromium 浏览器
sudo apt install chromium-browser

# 47. 安装截图工具
sudo apt install gnome-screenshot

# 48. 安装其他常用工具（根据需求自行添加）
sudo apt install git wget curl htop neofetch

# 51. 安装字体管理器
sudo apt install font-manager

# 52. 安装触摸板手势支持（如适用）
sudo apt install libinput-tools

# 53. 安装截图工具
sudo apt install shutter

# 54. 安装悬浮窗口预览工具
sudo apt install compiz compizconfig-settings-manager

# 55. 安装 WPS Office（可选）
sudo apt install wps-office

# 56. 安装 Typora Markdown 编辑器（可选）
sudo apt install typora
# 57. Wireshark：网络抓包工具，用于分析网络流量
sudo apt install wireshark

# 58. tcpdump：命令行下的网络抓包工具，用于捕获和分析网络数据包
sudo apt install tcpdump

# 59. nmap：网络发现和安全扫描工具，用于端口扫描、服务识别等
sudo apt install nmap

# 60. Metasploit：渗透测试框架，用于进行安全评估和攻击模拟
sudo apt install metasploit-framework

# 61. Snort：入侵检测系统（IDS），用于实时监控和检测网络攻击
sudo apt install snort

# 62. Aircrack-ng：无线网络安全工具，用于测试和破解无线网络的安全性
sudo apt install aircrack-ng

# 63. ettercap：中间人攻击工具，用于网络欺骗和流量拦截
sudo apt install ettercap-graphical

# 64. Hydra：密码破解工具，用于暴力破解登录凭据
sudo apt install hydra

# 65. John the Ripper：密码破解工具，用于破解哈希密码
sudo apt install john

# 66. Nikto：Web 服务器漏洞扫描工具，用于检测 Web 应用程序的安全漏洞
sudo apt install nikto

# 67. THC-Hydra：多协议密码破解工具，支持多种协议的暴力破解
sudo apt install hydra

# 68. Yersinia：网络攻击工具，用于测试网络设备的安全性
sudo apt install yersinia

# 69. Ettercap-NG：中间人攻击工具，用于欺骗局域网内的设备
sudo apt install ettercap-common
# 80. 禁用自动更新服务
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl disable apt-daily-upgrade.service
