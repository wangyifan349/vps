apt install nginx
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
########################假设服务器使用Php7.4########################
sudo apt install php7.4 php7.4-fpm
sudo systemctl start php7.4-fpm
sudo systemctl enable php7.4-fpm
sudo cp /etc/php/7.4/fpm/php.ini /etc/php/7.4/fpm/php.ini.bak
sudo cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.bak
#修改  /etc/php/7.4/fpm/php.ini  和  /etc/php/7.4/fpm/pool.d/www.conf  文件
# 修改 php.ini 文件以关闭 cgi.fix_pathinfo，这提高了 PHP 的安全性
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.4/fpm/php.ini
# 设置 PHP 允许的最大 POST 数据大小为 50M，这对于上传较大文件很有用
sudo sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php/7.4/fpm/php.ini
# 设置 PHP 允许的最大上传文件大小为 50M，这同样对于上传较大文件很有用
sudo sed -i 's/upload_max_filesize = .*/upload_max_filesize = 50M/' /etc/php/7.4/fpm/php.ini
# 设置 PHP 脚本的最大执行时间为 30 秒，这有助于防止脚本运行过长时间
sudo sed -i 's/max_execution_time = .*/max_execution_time = 30/' /etc/php/7.4/fpm/php.ini
# 设置 PHP 脚本可以使用的最大内存量为 256M，这有助于处理需要大量内存的脚本
sudo sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php/7.4/fpm/php.ini
# 修改 PHP-FPM 的监听路径，使其通过 Unix socket 监听，这通常比 TCP/IP 端口监听更高效
sudo sed -i 's/^listen = .*/listen = \/run\/php\/php7.4-fpm.sock/' /etc/php/7.4/fpm/php.ini
# 定义 PHP-FPM 子进程的最大数量。这个值应该根据您的服务器资源（如内存和CPU）以及预期的负载来调整。
# 较高的值可以处理更多的并发请求，但也会消耗更多的资源。
MAX_CHILDREN=10
# 定义启动时创建的子进程数量。这个值应该根据您的服务器在正常负载下的预期需求来设置。
# 这有助于在服务器启动时立即处理请求，而不是在请求到来时才创建新的子进程。
START_SERVERS=4
# 定义在空闲状态下保持的最小空闲子进程数量。这确保了即使在负载较低时，也有一定数量的子进程准备接受请求。
# 这有助于快速响应突然增加的请求，而不需要花时间启动新的子进程。
MIN_SPARE_SERVERS=2
# 定义在空闲状态下允许的最大空闲子进程数量。这有助于控制资源使用，避免在不需要时占用过多资源。
# 如果空闲子进程数量超过此值，超出的子进程将被终止。
MAX_SPARE_SERVERS=6
# 使用 sed 命令来修改配置
sudo sed -i "s/pm.max_children = .*/pm.max_children = $MAX_CHILDREN/" /etc/php/7.4/fpm/pool.d/www.conf
sudo sed -i "s/pm.start_servers = .*/pm.start_servers = $START_SERVERS/" /etc/php/7.4/fpm/pool.d/www.conf
sudo sed -i "s/pm.min_spare_servers = .*/pm.min_spare_servers = $MIN_SPARE_SERVERS/" /etc/php/7.4/fpm/pool.d/www.conf
sudo sed -i "s/pm.max_spare_servers = .*/pm.max_spare_servers = $MAX_SPARE_SERVERS/" /etc/php/7.4/fpm/pool.d/www.conf

sudo apt install php8.1 php8.1-fpm


sudo apt install -y php8.1 php8.1-fpm php8.1-mysql php8.1-xml php8.1-mbstring php8.1-curl php8.1-zip




sudo systemctl start php8.1-fpm
sudo systemctl enable php8.1-fpm
sudo cp /etc/php/8.1/fpm/php.ini /etc/php/8.1/fpm/php.ini.bak
sudo cp /etc/php/8.1/fpm/pool.d/www.conf /etc/php/8.1/fpm/pool.d/www.conf.bak
# 修改 /etc/php/8.1/fpm/php.ini 和 /etc/php/8.1/fpm/pool.d/www.conf 文件
# 修改 php.ini 文件以关闭 cgi.fix_pathinfo，这提高了 PHP 的安全性
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini
# 设置 PHP 允许的最大 POST 数据大小为 50M，这对于上传较大文件很有用
sudo sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php/8.1/fpm/php.ini
# 设置 PHP 允许的最大上传文件大小为 50M，这同样对于上传较大文件很有用
sudo sed -i 's/upload_max_filesize = .*/upload_max_filesize = 50M/' /etc/php/8.1/fpm/php.ini
# 设置 PHP 脚本的最大执行时间为 30 秒，这有助于防止脚本运行过长时间
sudo sed -i 's/max_execution_time = .*/max_execution_time = 30/' /etc/php/8.1/fpm/php.ini
# 设置 PHP 脚本可以使用的最大内存量为 256M，这有助于处理需要大量内存的脚本
sudo sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php/8.1/fpm/php.ini
# 修改 PHP-FPM 的监听路径，使其通过 Unix socket 监听，这通常比 TCP/IP 端口监听更高效
sudo sed -i 's/^listen = .*/listen = \/run\/php\/php8.1-fpm.sock/' /etc/php/8.1/fpm/php.ini

# 注意：以下变量定义和 sed 命令需要在 Bash 脚本中执行，或者您可以手动设置这些值并使用 sed 命令
MAX_CHILDREN=10
START_SERVERS=4
MIN_SPARE_SERVERS=2
MAX_SPARE_SERVERS=6

# 使用 sed 命令来修改配置
sudo sed -i "s/pm.max_children = .*/pm.max_children = $MAX_CHILDREN/" /etc/php/8.1/fpm/pool.d/www.conf
sudo sed -i "s/pm.start_servers = .*/pm.start_servers = $START_SERVERS/" /etc/php/8.1/fpm/pool.d/www.conf
sudo sed -i "s/pm.min_spare_servers = .*/pm.min_spare_servers = $MIN_SPARE_SERVERS/" /etc/php/8.1/fpm/pool.d/www.conf
sudo sed -i "s/pm.max_spare_servers = .*/pm.max_spare_servers = $MAX_SPARE_SERVERS/" /etc/php/8.1/fpm/pool.d/www.conf



