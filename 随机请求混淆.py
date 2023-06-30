import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin
from fake_useragent import UserAgent
import random
import time
print("用于防止v2ray这类软件的记录，你可以在客户端运行，服务器如果有记录将会将正常流量和你的流量混淆在一起，使得记录的内容价值下降。如果你翻墙使用机场，那么可以运行该脚本")
print("需要最新的requests库和比较高版本的python3,否则需要配置代理")
proxies = {
   'http': 'http://127.0.0.1:10809',
   'https': 'http://127.0.0.1:10809',
}#这部分没启用，最新版本requests库设置代理后，会自动生效
# 其他 URL 列表
other = [
    "https://twitter.com",
    "https://developer.twitter.com",
    "https://blog.twitter.com",
    "https://ads.twitter.com",
    "https://about.twitter.com",
    "https://tensorflow.org",
    "https://github.com/tensorflow",
    "https://tensorboard.dev",
    "https://discuss.tensorflow.org",
    "https://apple.com",
    "https://icloud.com",
    "https://itunes.apple.com",
    "https://developer.apple.com",
    "https://support.apple.com",
    "https://tableau.com",
    "https://powerbi.microsoft.com",
    "https://looker.com",
    "https://qlik.com",
    "https://domo.com",
    "https://google.com/analytics",
    "https://alteryx.com",
    "https://splunk.com",
    "https://rapidminer.com",
    "https://ibm.com/analytics",
    "https://douyin.com",
    "https://tiktok.com",
    "https://snssdk.com",
    "https://amemv.com",
    "https://musical.ly",
    "https://pstatp.com"
]

def get_html_content(url):
    """
    发送HTTP GET请求以获取网页内容
    """
    ua = UserAgent()
    headers = {'User-Agent': ua.random}
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return response.text

def extract_https_links(soup, base_url):
    """
    从BeautifulSoup对象中提取HTTPS链接
    """
    links = soup.find_all('a')
    unique_links = set()

    for link in links:
        href = link.get('href')
        if href and href.startswith('https'):
            unique_links.add(href)
        else:
            absolute_url = urljoin(base_url, href)  # 将相对路径转换为绝对路径
            if absolute_url.startswith('https'):
                unique_links.add(absolute_url)

    return list(unique_links) + other

def scrape_website(url):
    """
    爬取指定网页
    """
    try:
        html_content = get_html_content(url)
        soup = BeautifulSoup(html_content, 'html.parser')
        links = extract_https_links(soup, url)
        print(links)  # 输出整理后的链接列表

        for link in links:
            try:
                html_content = get_html_content(link)
                print(link)
                # 进一步处理链接内容
            except requests.exceptions.RequestException as err:
                print(f"请求发生错误: {err}")

    except requests.exceptions.RequestException as err:
        print(f"请求发生错误: {err}")

def main():
    """
    主函数，程序入口点
    """
    base_url = 'http://www.hao123.com'
    html_content = get_html_content(base_url)
    soup = BeautifulSoup(html_content, 'html.parser')
    sorted_links = sorted(extract_https_links(soup, base_url), reverse=True)

    while True:
        selected_link = random.choice(sorted_links)
        scrape_website(selected_link)

        wait_time = random.randint(180,880)
        time.sleep(wait_time)

if __name__ == "__main__":
    main()
