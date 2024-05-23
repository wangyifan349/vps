from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from bs4 import BeautifulSoup

# 定义一个函数，用于获取页面内容
def get_page_content(url):
    try:
        # 设置Firefox的配置参数
        options = Options()
        options.headless = True  # 设置为无界面模式，可以加快页面加载速度
        options.add_argument('--disable-gpu')  # 禁用GPU加速，有时可以解决一些页面渲染问题
        options.add_argument('--no-sandbox')  # 禁用沙盒模式，有时可以解决一些权限问题
        options.add_argument('--disable-dev-shm-usage')  # 禁用/dev/shm使用，有时可以解决一些内存不足的问题
        
        # 指定GeckoDriver驱动的位置
        driver_path = "/path/to/geckodriver"
        # 指定Firefox浏览器的位置
        firefox_binary_path = "/path/to/firefox"
        
        # 使用GeckoDriver驱动启动Firefox浏览器
        driver = webdriver.Firefox(options=options, executable_path=driver_path, firefox_binary=firefox_binary_path)
        
        # 请求页面
        driver.get(url)
        
        # 获取页面源代码
        page_source = driver.page_source
        
        # 关闭浏览器
        driver.quit()
        
        return page_source.encode('utf-8')
    except Exception as e:
        print("获取页面内容时出错:", str(e))
        return None

# 定义一个函数，用于提取页面中的超链接和文本
def extract_links_and_text(html_content):
    try:
        # 使用BeautifulSoup解析HTML内容
        soup = BeautifulSoup(html_content, 'html.parser')
        # 找到所有超链接标签
        links = soup.find_all('a')
        # 提取超链接的href属性和文本内容
        links_data = [(link.get('href'), link.text) for link in links]
        # 提取页面文本内容
        text_content = soup.get_text()
        return links_data, text_content
    except Exception as e:
        print("提取超链接和文本时出错:", str(e))
        return [], ""

# 主函数
def main():
    # 目标网站URL
    target_url = "https://example.com"
    # 获取页面内容
    page_content = get_page_content(target_url)
    if page_content:
        # 提取页面中的超链接和文本
        links, text = extract_links_and_text(page_content)
        
        # 保存页面内容到本地
        save_path = "page_content.html"
        with open(save_path, "wb") as file:
            file.write(page_content)
        print("页面内容已保存至:", save_path)
        
        # 打印超链接
        print("超链接:")
        for link in links:
            print("链接:", link[0], "| 文本:", link[1])
        # 打印文本内容
        print("\n文本内容:")
        print(text)

if __name__ == "__main__":
    main()

"""
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from bs4 import BeautifulSoup
import time  # 引入时间模块，用于等待页面加载

# 定义一个函数，用于获取页面内容
def get_page_content(url):
    try:
        # 设置Firefox的配置参数
        options = Options()
        options.headless = True  # 设置为无界面模式，可以加快页面加载速度
        options.add_argument('--disable-gpu')  # 禁用GPU加速，有时可以解决一些页面渲染问题
        options.add_argument('--no-sandbox')  # 禁用沙盒模式，有时可以解决一些权限问题
        options.add_argument('--disable-dev-shm-usage')  # 禁用/dev/shm使用，有时可以解决一些内存不足的问题
        
        # 指定GeckoDriver驱动的位置
        driver_path = "/path/to/geckodriver"
        # 指定Firefox浏览器的位置
        firefox_binary_path = "/path/to/firefox"
        
        # 使用GeckoDriver驱动启动Firefox浏览器
        driver = webdriver.Firefox(options=options, executable_path=driver_path, firefox_binary=firefox_binary_path)
        
        # 请求页面
        driver.get(url)
        
        # 等待页面加载，这里可以根据实际情况调整等待时间
        time.sleep(2)
        
        # 获取页面源代码
        page_source = driver.page_source
        
        # 关闭浏览器
        driver.quit()
        
        return page_source.encode('utf-8')
    except Exception as e:
        print("获取页面内容时出错:", str(e))
        return None

# 定义一个函数，用于提取页面中的超链接和文本
def extract_links_and_text(html_content):
    try:
        # 使用BeautifulSoup解析HTML内容
        soup = BeautifulSoup(html_content, 'html.parser')
        # 找到所有超链接标签
        links = soup.find_all('a')
        # 提取超链接的href属性和文本内容
        links_data = [(link.get('href'), link.text) for link in links]
        # 提取页面文本内容
        text_content = soup.get_text()
        return links_data, text_content
    except Exception as e:
        print("提取超链接和文本时出错:", str(e))
        return [], ""

# 主函数
def main():
    # 目标网站URL
    target_url = "https://example.com"
    # 获取页面内容
    page_content = get_page_content(target_url)
    if page_content:
        # 提取页面中的超链接和文本
        links, text = extract_links_and_text(page_content)
        
        # 保存页面内容到本地
        save_path = "page_content.html"
        with open(save_path, "wb") as file:
            file.write(page_content)
        print("页面内容已保存至:", save_path)
        
        # 打印超链接
        print("超链接:")
        for link, _ in links:
            print("链接:", link)
        
        # 进一步采集每个链接指向的页面内容
        for link, _ in links:
            # 过滤掉空链接和JavaScript链接
            if link and not link.startswith("javascript:"):
                # 构建完整的链接地址
                full_link = target_url + link if link.startswith("/") else link
                print("进一步采集链接:", full_link)
                # 获取页面内容
                sub_page_content = get_page_content(full_link)
                if sub_page_content:
                    # 提取页面中的超链接和文本
                    sub_links, sub_text = extract_links_and_text(sub_page_content)
                    
                    # 保存页面内容到本地
                    sub_save_path = full_link.replace("/", "_") + ".html"
                    with open(sub_save_path, "wb") as file:
                        file.write(sub_page_content)
                    print("子页面内容已保存至:", sub_save_path)
                    
                    # 打印子页面中的超链接
                    print("子页面超链接:")
                    for sub_link, _ in sub_links:
                        print("链接:", sub_link)
                    print()
                    
                    # 这里可以根据需要，继续对子页面进行进一步采集

if __name__ == "__main__":
    main()
"""
