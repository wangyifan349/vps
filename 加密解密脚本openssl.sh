#!/bin/bash

# 检查是否提供了操作类型、目录路径和密码
if [ "$#" -ne 3 ]; then
    echo "用法: \$0 <加密|解密> <目录路径> <密码>"
    exit 1
fi

# 获取操作类型、目录路径和密码
OPERATION=\$1
DIRECTORY=\$2
PASSWORD=\$3

# 检查目录是否存在
if [ ! -d "$DIRECTORY" ]; then
    echo "错误: 目录 $DIRECTORY 不存在。"
    exit 1
fi

# 遍历目录中的所有文件并加密或解密
process_files() {
    local DIR=\$1
    
    # 循环遍历当前目录下的每个项目
    for ITEM in "$DIR"/*; do
        
        # 如果项目是一个目录，则递归调用 process_files 函数
        if [ -d "$ITEM" ]; then
            process_files "$ITEM"
        
        # 如果项目是一个文件，则根据操作类型进行处理
        elif [ -f "$ITEM" ]; then
            
            # 如果操作类型是加密
            if [ "$OPERATION" == "加密" ]; then
                echo "正在加密 $ITEM..."
                
                # 使用 openssl 进行 AES-256-CBC 加密
                openssl enc -aes-256-cbc -salt -in "$ITEM" -out "$ITEM.enc" -k "$PASSWORD"
                
                # 检查加密操作是否成功
                if [ $? -eq 0 ]; then
                    echo "$ITEM 加密成功。"
                    
                    # 删除原始文件
                    rm "$ITEM"
                else
                    echo "加密 $ITEM 失败。"
                fi
            
            # 如果操作类型是解密
            elif [ "$OPERATION" == "解密" ]; then
                
                # 仅处理扩展名为 .enc 的文件
                if [[ "$ITEM" == *.enc ]]; then
                    echo "正在解密 $ITEM..."
                    
                    # 去掉 .enc 扩展名以生成解密后的文件名
                    DECRYPTED_FILE="${ITEM%.enc}"
                    
                    # 使用 openssl 进行 AES-256-CBC 解密
                    openssl enc -d -aes-256-cbc -in "$ITEM" -out "$DECRYPTED_FILE" -k "$PASSWORD"
                    
                    # 检查解密操作是否成功
                    if [ $? -eq 0 ]; then
                        echo "$ITEM 解密成功。"
                        
                        # 删除加密文件
                        rm "$ITEM"
                    else
                        echo "解密 $ITEM 失败。"
                    fi
                fi
            else
                echo "无效的操作类型: $OPERATION。请使用 '加密' 或 '解密'。"
                exit 1
            fi
        fi
    done
}

# 开始处理文件
echo "开始在目录 $DIRECTORY 中进行 $OPERATION 操作"
process_files "$DIRECTORY"
echo "所有文件已处理完毕。"
