import tensorflow as tf
import tensorflow_hub as hub
import matplotlib.pyplot as plt

# 设置显卡内存动态分配
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
    except RuntimeError as e:
        print(e)

# 1. DCGAN (Deep Convolutional Generative Adversarial Network)
dcgan = hub.load("https://tfhub.dev/google/progan-128/1")  # 使用128x128像素的图像生成器
dcgan_samples = dcgan(tf.random.normal([5, 512]))  # 生成5个图像，输入噪声维度为512
plt.figure(figsize=(10, 10))
for i in range(5):
    plt.subplot(1, 5, i+1)
    plt.imshow(dcgan_samples[i])
    plt.axis('off')
plt.show()

# 2. StyleGAN (Style-based Generative Adversarial Network)
stylegan = hub.load("https://tfhub.dev/google/progan-256/1")  # 使用256x256像素的图像生成器
stylegan_samples = stylegan(tf.random.normal([5, 512]))  # 生成5个图像，输入噪声维度为512
plt.figure(figsize=(10, 10))
for i in range(5):
    plt.subplot(1, 5, i+1)
    plt.imshow(stylegan_samples[i])
    plt.axis('off')
plt.show()

# 3. BigGAN (Large-Scale Generative Adversarial Network)
biggan = hub.load("https://tfhub.dev/deepmind/biggan-512/1")  # 使用512x512像素的图像生成器
biggan_samples = biggan(tf.random.normal([5, 140]))  # 生成5个图像，输入噪声维度为140
plt.figure(figsize=(10, 10))
for i in range(5):
    plt.subplot(1, 5, i+1)
    plt.imshow(biggan_samples[i])
    plt.axis('off')
plt.show()

# 4. CycleGAN (Cycle-Consistent Generative Adversarial Network)
cyclegan = hub.load("https://tfhub.dev/google/cycle_gan/horse2zebra/1")  # 将马图像转换为斑马图像的模型
cyclegan_samples = cyclegan(tf.random.normal([5, 256, 256, 3]))  # 生成5个斑马图像，输入尺寸为256x256x3
plt.figure(figsize=(10, 10))
for i in range(5):
    plt.subplot(1, 5, i+1)
    plt.imshow(cyclegan_samples[i])
    plt.axis('off')
plt.show()

# 5. StarGAN (Star Generative Adversarial Network)
stargan = hub.load("https://tfhub.dev/captain-pool/esrgan-tf2/1")  # 单图像超分辨率增强模型
stargan_samples = stargan(tf.random.normal([5, 256, 256, 3]))  # 生成5个增强图像，输入尺寸为256x256x3
plt.figure(figsize=(10, 10))
for i in range(5):
    plt.subplot(1, 5, i+1)
    plt.imshow(stargan_samples[i])
    plt.axis('off')
plt.show()
