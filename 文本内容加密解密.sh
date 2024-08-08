#!/bin/bash

# 定义文件名
PRIVATE_KEY="ec_private.pem"
PUBLIC_KEY="ec_public.pem"
ENCRYPTED_FILE="encrypted.txt"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 功能菜单
echo -e "${CYAN}请选择操作：${NC}"
echo -e "${GREEN}1. 生成密钥对并加密文字${NC}"
echo -e "${GREEN}2. 使用私钥解密文字${NC}"
read -p "请输入选项 (1 或 2): " OPTION

if [ "$OPTION" == "1" ]; then
    # 生成椭圆曲线私钥（使用 secp256k1）
    echo -e "${BLUE}生成椭圆曲线私钥...${NC}"
    openssl ecparam -genkey -name secp256k1 -out $PRIVATE_KEY
    if [ $? -ne 0 ]; then
        echo -e "${RED}生成私钥失败。${NC}"
        exit 1
    fi
    echo -e "${GREEN}私钥已保存到 $PRIVATE_KEY${NC}"

    # 从私钥生成公钥
    echo -e "${BLUE}从私钥生成公钥...${NC}"
    openssl ec -in $PRIVATE_KEY -pubout -out $PUBLIC_KEY
    if [ $? -ne 0 ]; then
        echo -e "${RED}生成公钥失败。${NC}"
        exit 1
    fi
    echo -e "${GREEN}公钥已保存到 $PUBLIC_KEY${NC}"

    # 提示用户输入要加密的文字
    read -p "请输入要加密的文字: " TEXT

    # 将要加密的文字保存到临时文件
    echo -e "${BLUE}保存要加密的文字到临时文件...${NC}"
    echo -n "$TEXT" > plaintext.txt

    # 使用公钥加密文字
    echo -e "${BLUE}使用公钥加密文字...${NC}"
    openssl pkeyutl -encrypt -inkey $PUBLIC_KEY -pubin -in plaintext.txt -out $ENCRYPTED_FILE
    if [ $? -ne 0 ]; then
        echo -e "${RED}加密失败。${NC}"
        rm plaintext.txt
        exit 1
    fi
    echo -e "${GREEN}加密后的文字已保存到 $ENCRYPTED_FILE${NC}"

    # 打印加密后的内容（Base64 编码）
    echo -e "${YELLOW}加密后的内容（Base64 编码）是：${NC}"
    ENCRYPTED_TEXT=$(base64 -w 0 $ENCRYPTED_FILE)
    echo -e "${CYAN}-----BEGIN ENCRYPTED MESSAGE-----${NC}"
    echo "$ENCRYPTED_TEXT"
    echo -e "${CYAN}-----END ENCRYPTED MESSAGE-----${NC}"

    # 清理临时文件
    rm plaintext.txt $ENCRYPTED_FILE

    # 提供解密的办法
    echo ""
    echo -e "${YELLOW}要解密，请使用以下命令：${NC}"
    echo -e "${CYAN}echo \"$ENCRYPTED_TEXT\" | base64 -d > encrypted.bin${NC}"
    echo -e "${CYAN}openssl pkeyutl -decrypt -inkey <私钥文件路径> -in encrypted.bin -out decrypted.txt${NC}"
    echo -e "${CYAN}cat decrypted.txt${NC}"

elif [ "$OPTION" == "2" ]; then
    # 提示用户输入私钥文件路径
    read -p "请输入私钥文件路径: " PRIVATE_KEY_PATH

    # 提示用户输入加密的 Base64 内容
    read -p "请输入加密的 Base64 内容: " ENCRYPTED_TEXT

    # 将 Base64 内容保存为二进制文件
    echo -e "${BLUE}将 Base64 内容保存为二进制文件...${NC}"
    echo "$ENCRYPTED_TEXT" | base64 -d > encrypted.bin

    # 使用私钥解密文字
    echo -e "${BLUE}使用私钥解密文字...${NC}"
    openssl pkeyutl -decrypt -inkey $PRIVATE_KEY_PATH -in encrypted.bin -out decrypted.txt
    if [ $? -ne 0 ]; then
        echo -e "${RED}解密失败。${NC}"
        rm encrypted.bin
        exit 1
    fi
    echo -e "${GREEN}解密后的文字已保存到 decrypted.txt${NC}"

    # 显示解密后的文字
    echo -e "${YELLOW}解密后的文字是：${NC}"
    cat decrypted.txt

    # 清理临时文件
    rm encrypted.bin decrypted.txt

else
    echo -e "${RED}无效的选项。${NC}"
    exit 1
fi
