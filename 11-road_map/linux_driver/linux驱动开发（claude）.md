---
tags:
  - linux驱动
创建日期: 2025-04-10
---
# WSL2环境下的ARM驱动开发与QEMU验证指南



在WSL2环境中进行Linux内核和驱动开发需要一些特殊配置，以下是针对WSL2环境的详细指南：

## 1. WSL2环境准备

首先，确保您的WSL2环境正确配置：

```bash
# 检查WSL版本
wsl --status

# 安装必要的开发工具
sudo apt update
sudo apt install -y build-essential flex bison libssl-dev libelf-dev bc qemu-system-arm gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi debootstrap
```

## 2. 在WSL2中使用QEMU启动ARM vexpress系统

```bash
# 创建一个专用目录
mkdir -p ~/arm_dev
cd ~/arm_dev

# 创建rootfs (确保使用WSL中的Linux路径，不要使用Windows路径)
mkdir -p rootfs
cd rootfs

# 创建rootfs镜像
dd if=/dev/zero of=rootfs.img bs=1M count=128
mkfs.ext4 rootfs.img
mkdir -p mnt
sudo mount rootfs.img mnt
~~sudo debootstrap --arch=amd64 focal mnt http://mirrors.aliyun.com/ubuntu/ #使~~用阿里云镜像，此处大坑，使用了64位的架构！！！
sudo debootstrap --arch=armhf focal /mnt/rootfs http://mirrors.aliyun.com/ubuntu/ # 阿里云找不到armhf的根文件系统目录

sudo debootstrap --arch=armhf focal /mnt/rootfs http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ # 使用清华的源进行加速
sudo umount mnt

cd ..

# 启动QEMU (使用nographic模式，这在WSL中非常重要)
qemu-system-arm \
  -M vexpress-a9 \
  -kernel path/to/your/zImage \
  -dtb path/to/your/vexpress-v2p-ca9.dtb \
  -drive file=rootfs/rootfs.img,format=raw \
  -append "root=/dev/mmcblk0 console=ttyAMA0 rw" \
  -nographic \
  -net nic -net user,hostfwd=tcp::2222-:22
```

<font color="#ffc000">注意</font>⚠️：
	1.  [[rootfs]] 中解释了创建rootfs中的各个步骤的含义。
	2. 根文件系统[[debootstrap]]的使用说明，与buybox 和Buildroot/Yocto等工具做了比较。
	3. [[根文件系统密码设置]]
		
在WSL2中使用QEMU的关键注意事项：

- 一定要使用`-nographic`选项，因为WSL2默认没有图形输出
- 如果需要图形界面，需要在Windows上安装X服务器(如VcXsrv)并配置DISPLAY环境变量
- 使用`hostfwd`将端口转发到WSL2中，方便SSH访问

## 3. 编译内核和驱动

在WSL2中编译内核和驱动需要特别注意文件系统性能问题：

```bash
# 确保在WSL文件系统中工作，而不是在Windows挂载路径(/mnt/c/...)
cd ~/arm_dev

# 克隆或使用您已有的内核源码
# 如果尚未下载内核源码：
# git clone --depth=1 https://github.com/torvalds/linux.git
# cd linux

# 配置交叉编译环境
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-

# 使用vexpress配置
make vexpress_defconfig

# 可选：开启模块支持和内核调试选项
make menuconfig
# 选择 "Enable loadable module support"
# 选择 "Kernel hacking" -> "Kernel debugging"

# 编译内核 (注意线程数量，WSL可能需要限制)
make -j$(nproc) zImage dtbs modules
```

## 4. 创建简单驱动并在WSL2中集成到内核

以下是一个简单的字符设备驱动示例，适合在WSL2+QEMU环境中测试：

```c
/* simple_char_driver.c */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/uaccess.h>

#define DEVICE_NAME "simple_char_dev"
#define CLASS_NAME "simple_char"

static int major_number;
static struct class *simple_char_class = NULL;
static struct device *simple_char_device = NULL;
static char message[256] = {0};
static short message_size;

/* 函数原型 */
static int dev_open(struct inode *, struct file *);
static int dev_release(struct inode *, struct file *);
static ssize_t dev_read(struct file *, char *, size_t, loff_t *);
static ssize_t dev_write(struct file *, const char *, size_t, loff_t *);

static struct file_operations fops = {
    .open = dev_open,
    .read = dev_read,
    .write = dev_write,
    .release = dev_release,
};

static int __init simple_char_init(void) {
    printk(KERN_INFO "simple_char: 初始化模块\n");
    
    /* 动态分配主设备号 */
    major_number = register_chrdev(0, DEVICE_NAME, &fops);
    if (major_number < 0) {
        printk(KERN_ALERT "simple_char: 注册设备号失败\n");
        return major_number;
    }
    printk(KERN_INFO "simple_char: 注册设备号: %d\n", major_number);
    
    /* 创建设备类 - 修改这里，移除THIS_MODULE参数 */
    simple_char_class = class_create(CLASS_NAME);
    if (IS_ERR(simple_char_class)) {
        unregister_chrdev(major_number, DEVICE_NAME);
        printk(KERN_ALERT "simple_char: 创建设备类失败\n");
        return PTR_ERR(simple_char_class);
    }
    printk(KERN_INFO "simple_char: 设备类创建成功\n");
    
    /* 创建设备 */
    simple_char_device = device_create(simple_char_class, NULL, MKDEV(major_number, 0), NULL, DEVICE_NAME);
    if (IS_ERR(simple_char_device)) {
        class_destroy(simple_char_class);
        unregister_chrdev(major_number, DEVICE_NAME);
        printk(KERN_ALERT "simple_char: 创建设备失败\n");
        return PTR_ERR(simple_char_device);
    }
    printk(KERN_INFO "simple_char: 设备创建成功\n");
    
    return 0;
}

static void __exit simple_char_exit(void) {
    device_destroy(simple_char_class, MKDEV(major_number, 0));
    class_destroy(simple_char_class);
    unregister_chrdev(major_number, DEVICE_NAME);
    printk(KERN_INFO "simple_char: 模块卸载成功\n");
}

static int dev_open(struct inode *inodep, struct file *filep) {
    printk(KERN_INFO "simple_char: 设备已打开\n");
    return 0;
}

static ssize_t dev_read(struct file *filep, char *buffer, size_t len, loff_t *offset) {
    int error_count;
    
    /* 如果已经读取完成则返回0 */
    if (*offset >= message_size)
        return 0;
    
    /* 将数据复制到用户空间 */
    error_count = copy_to_user(buffer, message + *offset, message_size - *offset);
    
    if (error_count == 0) {
        /* 修改格式化说明符，使用%zd而不是%d */
        printk(KERN_INFO "simple_char: 发送 %zd 字节数据到用户\n", (size_t)(message_size - *offset));
        *offset += message_size;
        return (message_size - *offset);
    } else {
        printk(KERN_INFO "simple_char: 向用户发送数据失败\n");
        return -EFAULT;
    }
}

static ssize_t dev_write(struct file *filep, const char *buffer, size_t len, loff_t *offset) {
    /* 确保写入数据不会超出buffer范围 */
    if (len > 255) len = 255;
    
    /* 将数据从用户空间复制到内核 */
    if (copy_from_user(message, buffer, len)) {
        printk(KERN_INFO "simple_char: 从用户获取数据失败\n");
        return -EFAULT;
    }
    
    message_size = len;
    message[len] = '\0';
    printk(KERN_INFO "simple_char: 收到 %zu 字节数据: %s\n", len, message);
    
    return len;
}

static int dev_release(struct inode *inodep, struct file *filep) {
    printk(KERN_INFO "simple_char: 设备已关闭\n");
    return 0;
}

module_init(simple_char_init);
module_exit(simple_char_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Desperado1001");
MODULE_DESCRIPTION("简单字符设备驱动示例");
MODULE_VERSION("0.1");
```

## 5. 在WSL2中添加驱动到内核

```bash
# 在内核源码目录中创建驱动目录
cd ~/arm_dev/linux
mkdir -p drivers/my_driver

# 将驱动代码保存到此目录
cat > drivers/my_driver/simple_char_driver.c << 'EOL'
/* 此处粘贴上面的驱动代码 */
EOL

# 创建Makefile
cat > drivers/my_driver/Makefile << 'EOL'
obj-m += simple_char_driver.o
EOL

# 创建Kconfig
cat > drivers/my_driver/Kconfig << 'EOL'
menu "My Custom Drivers"

config SIMPLE_CHAR_DRIVER
    tristate "Simple Character Driver"
    default m
    help
      This is a simple character device driver for testing.
      If unsure, say N.

endmenu
EOL

# 修改drivers目录的Kconfig
echo 'source "drivers/my_driver/Kconfig"' >> drivers/Kconfig

# 修改drivers目录的Makefile
echo 'obj-$(CONFIG_SIMPLE_CHAR_DRIVER) += my_driver/' >> drivers/Makefile

# 重新配置内核以启用新驱动
make menuconfig
# 导航到: Device Drivers -> My Custom Drivers -> Simple Character Driver
# 将其选为 [M] 模块

# 编译驱动模块
make -j$(nproc) modules
```

## 6. 在WSL2中使用QEMU测试驱动

### 作为内核模块测试

```bash
# 构建模块并复制到rootfs
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules_install INSTALL_MOD_PATH=~/arm_dev/rootfs/mnt
sudo mount ~/arm_dev/rootfs/rootfs.img ~/arm_dev/rootfs/mnt
sudo cp -r ~/arm_dev/linux/drivers/my_driver/simple_char_driver.ko ~/arm_dev/rootfs/mnt/lib/modules/*/
sudo umount ~/arm_dev/rootfs/mnt

# 启动QEMU
qemu-system-arm \
  -M vexpress-a9 \
  -kernel ~/arm_dev/linux/arch/arm/boot/zImage \
  -dtb ~/arm_dev/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
  -drive file=~/arm_dev/rootfs/rootfs.img,format=raw \
  -append "root=/dev/mmcblk0 console=ttyAMA0 rw" \
  -nographic \
  -net nic -net user,hostfwd=tcp::2222-:22

# 在QEMU内部加载驱动模块
insmod /lib/modules/*/simple_char_driver.ko

# 测试驱动
ls -l /dev/simple_char_dev
echo "测试消息" > /dev/simple_char_dev
cat /dev/simple_char_dev
dmesg | grep simple_char
```

## 7. WSL2中的QEMU远程调试

WSL2中进行QEMU调试需要注意端口转发问题：

```bash
# 启动QEMU并开启gdb服务器
qemu-system-arm \
  -M vexpress-a9 \
  -kernel ~/arm_dev/linux/arch/arm/boot/zImage \
  -dtb ~/arm_dev/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
  -drive file=~/arm_dev/rootfs/rootfs.img,format=raw \
  -append "root=/dev/mmcblk0 console=ttyAMA0 rw" \
  -nographic \
  -s -S
```

在另一个WSL2终端中：

```bash
arm-linux-gnueabi-gdb ~/arm_dev/linux/vmlinux
(gdb) target remote localhost:1234
(gdb) b simple_char_init
(gdb) c
```

## 8. WSL2特有注意事项

1. 文件系统性能：
    
    ```bash
    # 避免在Windows挂载点(/mnt/c/)进行内核编译
    # 确保您的项目目录在WSL2文件系统中（如~/arm_dev）
    ```
    
2. 网络配置：
    
    ```bash
    # 检查WSL2网络配置
    ip addr
    # 如果需要在Windows上访问WSL2中的服务，使用端口转发
    # 如QEMU中的hostfwd=tcp::2222-:22
    ```
    
3. 图形界面（如果需要）：
    
    ```bash
    # 在Windows上安装X服务器(VcXsrv或Xming)
    # 配置WSL2的DISPLAY环境变量
    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
    # 将此添加到~/.bashrc以使其永久生效
    echo 'export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk "{print \$2}"):0.0' >> ~/.bashrc
    ```
    
4. WSL2内存限制配置（对大型编译有用）：
    
    ```bash
    # 在Windows中创建.wslconfig文件
    # Windows文件路径：C:\Users\<YourUsername>\.wslconfig
    # 内容：
    # [wsl2]
    # memory=8GB
    # processors=4
    ```
    

## 9. 驱动开发实用脚本

为了简化WSL2环境中的开发流程，您可以创建以下实用脚本：

```bash
# 创建编译脚本 build_driver.sh
cat > build_driver.sh << 'EOL'
#!/bin/bash
cd ~/arm_dev/linux
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabi-
make -C ~/arm_dev/linux M=~/arm_dev/linux/drivers/my_driver modules
EOL
chmod +x ~/arm_dev/build_driver.sh

# 创建部署脚本 deploy_driver.sh
cat > deploy_driver.sh << 'EOL'
#!/bin/bash
sudo mount ~/arm_dev/rootfs/rootfs.img ~/arm_dev/rootfs/mnt
sudo cp ~/arm_dev/linux/drivers/my_driver/simple_char_driver.ko ~/arm_dev/rootfs/mnt/root/
sudo umount ~/arm_dev/rootfs/mnt
EOL
chmod +x ~/arm_dev/deploy_driver.sh

# 创建QEMU启动脚本 start_qemu.sh
cat > ./start_qemu.sh << 'EOL'
#!/bin/bash
qemu-system-arm \
  -M vexpress-a9 \
  -kernel /home/paolo/linux-master/arch/arm/boot/zImage \
  -dtb /home/paolo/linux-mater/arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
  -drive file=/home/paolo/arm_dev/rootfs/rootfs.img,format=raw \
  -append "root=/dev/mmcblk0 console=ttyAMA0 rw" \
  -nographic \
  -net nic -net user,hostfwd=tcp::2222-:22
EOL
chmod +x ~/arm_dev/start_qemu.sh
```

使用这些脚本可以大大简化WSL2中的驱动开发工作流程。您只需要执行：

```bash
~/arm_dev/build_driver.sh    # 编译驱动
~/arm_dev/deploy_driver.sh   # 部署到根文件系统
~/arm_dev/start_qemu.sh      # 启动QEMU测试环境
```

在QEMU系统内部：

```bash
insmod /root/simple_char_driver.ko
ls -l /dev/simple_char_dev
```

希望这些WSL2特定的修改和指南对您有所帮助！如果您有任何与WSL2环境相关的特定问题，请随时询问。

## 编译问题处理
[[驱动编译文件缺失错误问题处理]]

## 流程梳理
1. 编译内核
	- 指定平台arm （32位）
	- 交叉编译器版本 arm-linux-gnueabifh-
	- 指定厂商配置vexpres_defconfig
	-  手动修改配置 make menuconfig 
		- 文件系统
		- debug
		- 协议
	- 编译内核
2. [[rootfs]]根文件系统制作
3. 编写驱动程序，生成ko
	- [[simple_char_drive解释]]
4. 通过mount 根文件系统的方式挂在到/root 目录，使用`immod driver.ko` 加载驱动
5. 启动开发板
# github 推送

现在，我将创建仓库的基本结构并添加详细的README文档。先创建README.md文件：

现在我将创建必要的目录结构和文件，以确保仓库包含完整的学习资源。首先创建setup目录及其脚本：

现在添加QEMU准备脚本：

添加WSL2配置指南：

现在添加实用脚本：

添加驱动部署脚本：

添加QEMU启动脚本：

添加字符设备驱动示例：

添加字符设备驱动的Makefile：

添加README.md到examples目录：

最后，添加调试技巧文档：

我已成功创建了Linux驱动学习仓库并上传了相关文档和代码。以下是仓库的详细信息：

## 仓库概览

**仓库名称**: linux-driver-learning **仓库链接**: https://github.com/Desperado1001/linux-driver-learning **仓库描述**: Linux驱动开发学习仓库 - 使用WSL2和QEMU进行ARM架构驱动开发与测试

## 仓库结构

仓库包含了详细的学习路线和实例代码，目录结构如下：

```
linux-driver-learning/
├── README.md                  # 主文档，包含详细学习路线
├── setup/                     # 环境配置脚本
│   ├── install_dependencies.sh  # 依赖项安装脚本
│   ├── prepare_qemu.sh          # QEMU环境准备脚本
│   └── setup_wsl.md             # WSL2配置指南
├── examples/                  # 示例驱动
│   ├── char_driver/             # 字符设备驱动
│   │   ├── simple_char_driver.c   # 字符设备驱动源码
│   │   └── Makefile               # 编译脚本
│   └── README.md                # 示例说明文档
├── scripts/                   # 实用脚本
│   ├── build_driver.sh          # 驱动编译脚本
│   ├── deploy_driver.sh         # 驱动部署脚本
│   └── start_qemu.sh            # QEMU启动脚本
└── docs/                      # 文档
    └── debugging.md             # 调试技巧文档
```

## 主要特点

1. **详细的学习路线**：README.md中提供了从基础到高级的完整学习路径
2. **环境配置指南**：针对WSL2和QEMU环境的详细配置说明
3. **实用脚本**：提供了一系列脚本简化开发流程
4. **示例驱动**：包含详细注释的字符设备驱动示例
5. **调试技巧**：全面的驱动调试方法文档

## 学习路线

仓库提供了一个清晰的学习路线，分为四个阶段：

1. **环境搭建与基础知识**
    
    - 开发环境配置
    - 内核基础
    - 第一个驱动模块
2. **字符设备驱动开发**
    
    - 基本字符设备操作
    - 高级特性实现
3. **平台驱动与设备树**
    
    - 平台驱动模型
    - 设备树开发
4. **高级主题**
    
    - 内存与DMA管理
    - 中断处理
    - 调试技术

## 使用方法

开始使用此仓库学习Linux驱动开发：

1. 克隆仓库

```bash
git clone https://github.com/Desperado1001/linux-driver-learning.git
cd linux-driver-learning
```

2. 配置开发环境

```bash
# 安装依赖项
bash setup/install_dependencies.sh

# 配置QEMU环境
bash setup/prepare_qemu.sh
```

3. 编译并测试驱动示例

```bash
# 编译字符设备驱动
cd examples/char_driver
make

# 部署驱动到QEMU
bash ../../scripts/deploy_driver.sh ./ simple_char_driver.ko

# 启动QEMU测试环境
bash ../../scripts/start_qemu.sh
```

在仓库的README.md文档中提供了更详细的使用说明和学习路径。通过按照文档的指导逐步学习，您可以系统地掌握Linux驱动开发的知识和技能。

希望这个仓库能够帮助您在WSL2环境中高效地学习Linux驱动开发！