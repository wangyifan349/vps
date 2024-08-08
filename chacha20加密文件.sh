#!/bin/bash

# 设置一些变量
DATA_DIR="./data" # 存放要处理的数据文件的目录
ENCRYPTED_DIR="./encrypted" # 存放加密后数据文件的目录
DECRYPTED_DIR="./decrypted" # 存放解密后数据文件的目录
PASSWORD="your_password_here" # 用于生成密钥的密码

# 创建目录
mkdir -p $DATA_DIR $ENCRYPTED_DIR $DECRYPTED_DIR

# 打印美化的欢迎信息
echo "========================================"
echo "        OpenSSL ChaCha20 Script         "
echo "========================================"
echo ""
echo "请选择操作："
echo "1. 加密"
echo "2. 解密"
read -p "输入选项 (1 或 2): " operation

# 检查用户输入
if [ "$operation" != "1" ] && [ "$operation" != "2" ]; then
    echo "无效选项，请输入 1 或 2."
    exit 1
fi

# 执行加密操作
if [ "$operation" == "1" ]; then
    echo "开始加密操作..."
    find $DATA_DIR -type f | while read -r file; do
        base_name=$(basename "$file")
        encrypted_file="$ENCRYPTED_DIR/$base_name.enc"
        
        echo "正在加密 $file..."
        if ! openssl enc -chacha20 -salt -pbkdf2 -pass pass:$PASSWORD -in "$file" -out "$encrypted_file"; then
            echo "加密 $file 失败."
            exit 1
        fi
        
        # 恢复文件的修改时间
        touch -r "$file" "$encrypted_file"
    done
    echo "所有文件加密完成，存放在 $ENCRYPTED_DIR."
fi

# 执行解密操作
if [ "$operation" == "2" ]; then
    echo "开始解密操作..."
    find $ENCRYPTED_DIR -type f -name "*.enc" | while read -r file; do
        base_name=$(basename "$file" .enc)
        decrypted_file="$DECRYPTED_DIR/$base_name.dec"
        
        echo "正在解密 $file..."
        if ! openssl enc -d -chacha20 -salt -pbkdf2 -pass pass:$PASSWORD -in "$file" -out "$decrypted_file"; then
            echo "解密 $file 失败."
            exit 1
        fi
        
        # 恢复文件的修改时间
        touch -r "$file" "$decrypted_file"
    done
    echo "所有文件解密完成，存放在 $DECRYPTED_DIR."
fi

echo "========================================"
echo "        操作已成功完成！                "
echo "========================================"





#!/bin/bash

# 设置一些变量
DATA_DIR="./data" # 存放要处理的数据文件的目录
ENCRYPTED_DIR="./encrypted" # 存放加密后数据文件的目录
DECRYPTED_DIR="./decrypted" # 存放解密后数据文件的目录
CHACHA20_KEY="0123456789abcdef0123456789abcdef" # 32 字节 (256 位) 的 ChaCha20 密钥
CHACHA20_IV="0123456789abcdef" # 12 字节 (96 位) 的 ChaCha20 初始向量 (IV)

# 创建目录
mkdir -p $DATA_DIR $ENCRYPTED_DIR $DECRYPTED_DIR

# 打印美化的欢迎信息
echo "========================================"
echo "        OpenSSL ChaCha20 Script         "
echo "========================================"
echo ""
echo "请选择操作："
echo "1. 加密"
echo "2. 解密"
read -p "输入选项 (1 或 2): " operation

# 检查用户输入
if [ "$operation" != "1" ] && [ "$operation" != "2" ]; then
    echo "无效选项，请输入 1 或 2."
    exit 1
fi

# 执行加密操作
if [ "$operation" == "1" ]; then
    echo "开始加密操作..."
    find $DATA_DIR -type f | while read -r file; do
        base_name=$(basename "$file")
        encrypted_file="$ENCRYPTED_DIR/$base_name.enc"
        
        echo "正在加密 $file..."
        if ! openssl enc -chacha20 -K $CHACHA20_KEY -iv $CHACHA20_IV -in "$file" -out "$encrypted_file"; then
            echo "加密 $file 失败."
            exit 1
        fi
        
        # 恢复文件的修改时间
        touch -r "$file" "$encrypted_file"
    done
    echo "所有文件加密完成，存放在 $ENCRYPTED_DIR."
fi

# 执行解密操作
if [ "$operation" == "2" ]; then
    echo "开始解密操作..."
    find $ENCRYPTED_DIR -type f -name "*.enc" | while read -r file; do
        base_name=$(basename "$file" .enc)
        decrypted_file="$DECRYPTED_DIR/$base_name.dec"
        
        echo "正在解密 $file..."
        if ! openssl enc -d -chacha20 -K $CHACHA20_KEY -iv $CHACHA20_IV -in "$file" -out "$decrypted_file"; then
            echo "解密 $file 失败."
            exit 1
        fi
        
        # 恢复文件的修改时间
        touch -r "$file" "$decrypted_file"
    done
    echo "所有文件解密完成，存放在 $DECRYPTED_DIR."
fi

echo "========================================"
echo "        操作已成功完成！                "
echo "========================================"



