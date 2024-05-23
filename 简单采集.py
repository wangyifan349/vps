import requests
import os
from bs4 import BeautifulSoup
from fake_useragent import UserAgent

# 定义一个函数，用于获取页面内容
def get_page_content(url):
    try:
        # 随机生成请求头
        user_agent = UserAgent()
        headers = {'User-Agent': user_agent.random}
        
        # 定义代理
        proxies = {
            'http': 'http://your_proxy_ip:your_proxy_port',
            'https': 'https://your_proxy_ip:your_proxy_port'
        }
        
        # 发送GET请求获取页面内容
        response = requests.get(url, headers=headers, proxies=proxies, timeout=10)
        
        # 检查请求是否成功
        if response.status_code == 200:
            return response.content
        else:
            print("获取页面内容失败:", response.status_code)
            return None
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
