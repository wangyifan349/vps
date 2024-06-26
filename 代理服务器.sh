apt update
apt install build-essential cmake

###########################cloudflare-warp安装启用##########################
apt install git python3-pip  curl -y
curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list
apt-get update &&  apt-get install cloudflare-warp
warp-cli register
warp-cli set-mode proxy
warp-cli set-proxy-port 5000
#设置代理模式和监听端口5000
warp-cli connect
warp-cli enable-always-on#自动永久开启
###########################cloudflare-warp安装启用##########################
wget https://github.com/XTLS/Xray-install/raw/main/install-release.sh
bash ./install-release.sh
rm -rf /usr/local/etc/xray/*
#################删除默认的分流使用的文件，改用新的规则############################
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O /usr/local/etc/xray/geosite.dat
wget https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -O /usr/local/etc/xray/geoip.dat
chmod 400 /usr/local/etc/xray/*
#################删除默认的分流使用的文件，改用新的规则############################
apt install nginx -y
service nginx stop
rm -rf /usr/share/nginx/html
rm -rf /etc/nginx/conf.d/*
rm -rf /usr/local/etc/xray
systemctl enable xray

service xray stop
service nginx stop
####################删除和禁用当前的配置文件，用FTP手动复制吧#############
apt install python3-pip 
pip3 install -U pip 
pip3 install pycryptodome  pyopenssl  pyftpdlib
apt install openssl
#########################解决一下证书问题#######################
certbot certonly --standalone --rsa-key-size 4096 -d  www.aiary.xyz
cp /etc/letsencrypt/live/www.aiary.xyz/*.pem /usr/local/etc/xray/
cp /etc/letsencrypt/live/www.aiary.xyz/*.pem  /ftp/
cp /etc/letsencrypt/live/www.aiary.xyz/*.pem /etc/nginx/conf.d/
cp /etc/letsencrypt/live/www.aiary.xyz/*.pem /etc/nginx/conf.d/
chmod 400 /ftp/*.pem
chmod 400 /usr/local/etc/xray/*.pem
#########################解决一下证书问题#######################
systemctl stop snapd
systemctl disable snapd

   
   

#######################################################################


##############################
{
      "protocol": "socks",
      "settings": {
         "servers": [{
            "address": "127.0.0.1",
            "port": 10086
         }]
      },
      "tag": "warp"
}
#######################################
      {
        "type": "field",
        "outboundTag": "warp",
        "domain": [
          "geosite:cn"
        ],
        "enabled": true
      },
      {
        "type": "field",
        "outboundTag": "warp",
        "ip": [
          "geoip:cn"
        ],
        "enabled": true
      }
##########################################将国内流量重定向给cloudflare-warp###########################
