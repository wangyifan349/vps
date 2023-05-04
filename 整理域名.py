from urllib.parse import urlparse
import tldextract

# 定义一个函数，用于去除URL中的子域名部分
def remove_subdomain(url):
    domain_info = tldextract.extract(url)
    return f"{domain_info.domain}.{domain_info.suffix}"

# 定义一个函数，用于从指定文件中读取域名列表
def read_domains_from_file(file_path):
    with open(file_path, "r") as file:
        domains = []
        for line in file.readlines():
            domains.append(line.strip())
    return domains

# 定义一个函数，用于将去重后的域名列表保存到两个指定的文件中
def save_domains(unique_domains, output_file_path, formatted_output_file_path):
    # 保存到第一个文件
    with open(output_file_path, "w") as output_file:
        for domain in unique_domains:
            output_file.write(f"{domain}\n")

    # 保存到第二个文件，带格式的域名
    with open(formatted_output_file_path, "w") as formatted_output_file:
        for domain in unique_domains:
            formatted_output_file.write(f'"{domain}",\n')

# 主函数
def main():
    input_file_path = "domains.txt" # 输入文件路径
    output_file_path = "unique_domains.txt" # 输出文件路径
    formatted_output_file_path = "formatted_domains.txt" # 带格式的输出文件路径

    # 从输入文件中读取域名列表
    domains = read_domains_from_file(input_file_path)

    # 创建一个空集合，用于存储去重后的域名
    unique_domains = set()

    # 遍历输入文件中的每个域名，去除子域名并添加到unique_domains集合中
    for domain in domains:
        main_domain = remove_subdomain(domain)
        unique_domains.add(main_domain)

    # 将去重后的域名列表保存到指定的输出文件中
    save_domains(unique_domains, output_file_path, formatted_output_file_path)

if __name__ == "__main__":
    main()
