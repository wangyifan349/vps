#!/bin/bash

# 定义文件名
PRIVATE_KEY="ec_private_key.pem"
PUBLIC_KEY="ec_public_key.pem"
CSR="ec_csr.pem"
CERT="ec_cert.pem"
PKCS12_CERT="ec_cert.p12"

# 生成椭圆曲线私钥（使用 secp256r1 曲线）
echo "生成椭圆曲线私钥..."
openssl ecparam -genkey -name secp256r1 -out $PRIVATE_KEY
if [ $? -ne 0 ]; then
    echo "生成私钥失败。"
    exit 1
fi
echo "私钥已保存到 $PRIVATE_KEY"
echo "私钥内容："
cat $PRIVATE_KEY

# 从私钥生成公钥
echo "从私钥生成公钥..."
openssl ec -in $PRIVATE_KEY -pubout -out $PUBLIC_KEY
if [ $? -ne 0 ]; then
    echo "生成公钥失败。"
    exit 1
fi
echo "公钥已保存到 $PUBLIC_KEY"
echo "公钥内容："
cat $PUBLIC_KEY

# 生成证书签名请求 (CSR)
echo "生成证书签名请求 (CSR)..."
openssl req -new -key $PRIVATE_KEY -out $CSR
if [ $? -ne 0 ]; then
    echo "生成 CSR 失败。"
    exit 1
fi
echo "CSR 已保存到 $CSR"
echo "CSR 内容："
cat $CSR

# 生成自签名证书，有效期为 365 天
echo "生成自签名证书..."
openssl req -x509 -key $PRIVATE_KEY -in $CSR -out $CERT -days 365
if [ $? -ne 0 ]; then
    echo "生成自签名证书失败。"
    exit 1
fi
echo "自签名证书已保存到 $CERT"
echo "自签名证书内容："
cat $CERT

# 可选：将私钥和证书转换为 PKCS#12 格式
echo "将私钥和证书转换为 PKCS#12 格式..."
openssl pkcs12 -export -inkey $PRIVATE_KEY -in $CERT -out $PKCS12_CERT
if [ $? -ne 0 ]; then
    echo "转换为 PKCS#12 格式失败。"
    exit 1
fi
echo "PKCS#12 证书已保存到 $PKCS12_CERT"
echo "PKCS#12 证书内容："
cat $PKCS12_CERT

# 检查证书内容
echo "检查证书内容..."
openssl x509 -in $CERT -text -noout
if [ $? -ne 0 ]; then
    echo "检查证书内容失败。"
    exit 1
fi

# 提示用户如何配置 Nginx
echo ""
echo "请将以下配置添加到您的 Nginx 配置文件中："
echo "server {"
echo "    listen 443 ssl;"
echo "    server_name your_domain.com;"
echo ""
echo "    ssl_certificate /path/to/$CERT;"
echo "    ssl_certificate_key /path/to/$PRIVATE_KEY;"
echo ""
echo "    # 推荐的 SSL 设置"
echo "    ssl_protocols TLSv1.2 TLSv1.3;"
echo "    ssl_prefer_server_ciphers on;"
echo "    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256';"
echo ""
echo "    # 其他服务器配置..."
echo "}"
echo ""
echo "完成后，请运行以下命令测试并重启 Nginx："
echo "sudo nginx -t && sudo systemctl restart nginx"
