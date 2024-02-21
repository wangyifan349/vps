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
apt install wireshark -y
   
   
   
