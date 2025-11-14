# [[Buildroot QEMU 仿真指南]]

## 1. 简介

QEMU 是一个强大的开源机器模拟器和虚拟器。将 Buildroot 与 QEMU 结合使用，可以在没有物理硬件的情况下，快速、方便地测试和调试您为嵌入式目标构建的 Linux 系统。这对于开发、验证内核、驱动程序、应用程序以及整个系统的启动过程非常有用。

Buildroot 对 QEMU 提供了良好的支持，并内置了多个针对不同 QEMU 模拟板卡的 `defconfig` 文件，使得启动仿真变得相对简单。

**关联笔记:** [[Buildroot 使用指南]]

## 2. 环境准备

1.  **Buildroot 构建产物:** 您需要先使用 Buildroot 成功构建一个目标系统。确保 `output/images/` 目录下包含了所需的镜像文件（内核、根文件系统、可能的设备树文件）。
2.  **安装 QEMU:** 您需要在主机系统上安装 QEMU。安装的包取决于您要仿真的目标架构。
    *   **仿真 ARM:** `sudo apt install qemu-system-arm`
    *   **仿真 AArch64 (ARM64):** `sudo apt install qemu-system-aarch64`
    *   **仿真 x86:** `sudo apt install qemu-system-x86`
    *   **仿真 MIPS:** `sudo apt install qemu-system-mips`
    *   *(根据需要安装对应架构的 `qemu-system-*`)*

## 3. 识别 Buildroot 输出文件

进行 QEMU 仿真通常需要以下 Buildroot 生成的文件（位于 `output/images/` 目录）：

*   **内核镜像:** 例如 `zImage` (ARM), `Image` (ARM64), `bzImage` (x86/x86_64)。
*   **根文件系统镜像:** 例如 `rootfs.ext2`, `rootfs.ext4`, `rootfs.cpio`。文件系统类型在 Buildroot 配置中指定 (`Filesystem images --->`)。
*   **设备树二进制文件 (.dtb):** 对于许多 ARM 和 AArch64 平台是必需的，用于向内核描述硬件信息。文件名通常与目标板卡相关，例如 `vexpress-v2p-ca9.dtb`。
*   **引导加载程序 (可选):** 虽然 QEMU 可以直接加载内核 (`-kernel` 选项)，但在某些复杂场景或需要测试 Bootloader 时，也可以配置 QEMU 加载 U-Boot 等引导程序。

## 4. 使用 Buildroot 提供的 QEMU 配置

最简单的方法是使用 Buildroot 内置的 QEMU `defconfig` 文件。这些配置已经预设好了适合 QEMU 仿真的内核、文件系统和启动参数。

**步骤:**

1.  **选择 QEMU defconfig:** 在 Buildroot 根目录运行 `make list-defconfigs | grep qemu` 查看可用的 QEMU 配置。
    *   例如，选择 ARM Versatile Express (Cortex-A9):
        ```bash
        make qemu_arm_vexpress_defconfig
        ```
    *   或者，选择 AArch64 virt board (Cortex-A57):
        ```bash
        make qemu_aarch64_virt_defconfig
        ```
    *   或者，选择 x86_64:
        ```bash
        make qemu_x86_64_defconfig
        ```
2.  **(可选) 自定义配置:** 运行 `make menuconfig` 添加您需要的软件包或进行其他修改。
3.  **构建:**
    ```bash
    make -j$(nproc)
    ```
4.  **运行仿真:** Buildroot 为这些 QEMU 配置生成了一个方便的启动脚本 `output/images/start-qemu.sh`。直接运行它即可启动仿真：
    ```bash
    ./output/images/start-qemu.sh
    ```

这个脚本包含了运行 QEMU 所需的所有参数。

## 5. 手动运行 QEMU (理解参数)

如果您没有使用 QEMU defconfig，或者想更深入地理解 QEMU 的工作方式，可以手动构建 QEMU 命令。基本结构如下：

```bash
qemu-system-<arch> [options]
```

以下是一些常用选项的解释：

- `-M <machine>`: 指定要模拟的机器/板卡类型。例如 `vexpress-a9` (ARM), `virt` (AArch64/RISC-V), `pc` (x86)。可以通过 `qemu-system-<arch> -M help` 查看支持的类型。
- `-cpu <cpu_type>`: 指定模拟的 CPU 型号。例如 `cortex-a9`, `cortex-a57`, `host` (使用主机 CPU 特性，主要用于 x86)。
- `-kernel <kernel_image>`: 指定要加载的 Linux 内核镜像文件路径。例如 `-kernel output/images/zImage`。
- `-dtb <dtb_file>`: 指定设备树二进制文件路径。例如 `-dtb output/images/vexpress-v2p-ca9.dtb`。
- `-drive file=<rootfs_image>,format=<format>,if=<interface>`: 指定根文件系统镜像。
    - `file=`: 镜像文件路径，例如 `output/images/rootfs.ext4`。
    - `format=`: 镜像格式 (qcow2, raw 等)。对于 `.ext2`/`.ext4` 通常使用 `raw`。
    - `if=`: 模拟的磁盘接口类型。常用 `sd` (SD 卡), `virtio` (高性能虚拟化接口), `ide`, `scsi`, `none` (配合 `-device` 使用)。
- `-append "<kernel_cmdline>"`: 向内核传递命令行参数。**非常重要！** 至少需要指定：
    - `root=/dev/XXX`: 根文件系统的设备节点。这取决于 `-drive` 的 `if=` 参数：
        - `if=sd`: 通常是 `/dev/sda` 或 `/dev/mmcblk0`。
        - `if=virtio`: 通常是 `/dev/vda`。
        - `if=ide`: 通常是 `/dev/hda`。
    - `console=ttyXXX`: 指定控制台输出设备。
        - ARM Versatile Express: `ttyAMA0`
        - ARM/AArch64 virt board: `ttyAMA0`
        - x86: `ttyS0`
    - 其他参数如 `rw` (读写挂载), `earlyprintk` (早期内核打印) 等。
- `-nographic`: 禁用图形输出，将串行控制台重定向到当前终端。通常与 `-serial stdio` 结合使用（但后者常为默认）。
- `-serial <device>`: 重定向串口。`stdio` 表示重定向到标准输入输出。
- `-netdev user,id=net0`: 配置一个用户模式的网络设备 (NAT)，允许虚拟机访问主机和外部网络。`id=net0` 是标识符。
- `-device <driver>,netdev=net0`: 将上面定义的网络设备连接到虚拟机内的模拟网卡。
    - ARM vexpress: `-device smc91c111,netdev=net0`
    - virtio (推荐): `-device virtio-net-pci,netdev=net0` (或 `-device virtio-net-device,netdev=net0` 取决于板卡)
- `-m <size>`: 指定虚拟机的内存大小，例如 `-m 512M` 或 `-m 1G`。

**示例 (手动运行 ARM vexpress-a9):**

假设 Buildroot 使用 `qemu_arm_vexpress_defconfig` 构建完成。

```bash
qemu-system-arm \
    -M vexpress-a9 \
    -kernel output/images/zImage \
    -dtb output/images/vexpress-v2p-ca9.dtb \
    -drive file=output/images/rootfs.ext2,format=raw,if=sd \
    -append "root=/dev/mmcblk0 rw console=ttyAMA0" \
    -netdev user,id=mynet0 \
    -device smc91c111,netdev=mynet0 \
    -nographic
```

**示例 (手动运行 AArch64 virt):**

假设 Buildroot 使用 `qemu_aarch64_virt_defconfig` 构建完成。

```bash
qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a57 \
    -kernel output/images/Image \
    -append "root=/dev/vda rw console=ttyAMA0" \
    -drive file=output/images/rootfs.ext4,format=raw,if=virtio \
    -netdev user,id=mynet0 \
    -device virtio-net-pci,netdev=mynet0 \
    -nographic \
    -m 1G # 分配 1GB 内存
```

## 6. 运行与交互

- 执行 `start-qemu.sh` 脚本或您构建的手动命令。
- 您将在终端看到 Linux 内核的启动日志。
- 启动完成后，通常会看到登录提示符 (`login:`)。
- 输入用户名 `root`。密码通常为空（除非您在 Buildroot 配置中设置了密码 `System configuration -> Root password`）。
- 现在您就在 QEMU 模拟的 Linux 系统中了，可以执行命令。
- **退出 QEMU:**
    - 如果使用了 `-nographic`，通常按 `Ctrl+A` 然后按 `X`。
    - 或者，在模拟的 Linux 系统中执行 `poweroff` 或 `reboot` 命令。
    - 如果 QEMU 窗口卡住，可以尝试 `Ctrl+C` (可能不会干净关闭)。

## 7. 高级主题与技巧

- **网络:** 用户模式网络 (`-netdev user`) 最简单，但虚拟机无法直接从外部访问。更高级的网络配置（如 `tap` 或 `bridge`）允许虚拟机像网络中的独立机器一样工作，但配置更复杂。
- **文件共享:**
    - **VirtFS (9p):** 使用 `-virtfs local,path=/path/on/host,mount_tag=host_share,security_model=passthrough` 将主机目录共享给虚拟机。在虚拟机内需要挂载：`mount -t 9p -o trans=virtio host_share /mnt/host` (需要内核支持 9p)。
    - **NFS:** 在主机上设置 NFS 服务器，在虚拟机内挂载。
    - **网络复制:** 使用 `scp` 或 `rsync` 通过网络传输文件（需要配置网络和 SSH）。
- **调试:**
    - **内核调试:** 在 QEMU 命令中添加 `-s -S`。`-S` 使 QEMU 在启动时暂停，等待 GDB 连接。`-s` 是 `-gdb tcp::1234` 的简写，在 1234 端口启动 GDB stub。然后在主机上运行对应架构的 `gdb` (例如 `gdb-multiarch` 或 Buildroot 构建的 `output/host/bin/<arch>-linux-gdb`)，连接到 QEMU：`target remote :1234`。
    - **应用调试:** 在 Buildroot 中选择 `gdbserver` 包，在虚拟机中运行 `gdbserver :2345 /path/to/your/app`，然后在主机上用 GDB 连接：`target remote <vm_ip>:2345`。

## 8. 故障排除

- **Kernel Panic - not syncing: VFS: Unable to mount root fs...:**
    - 检查 `-append` 中的 `root=/dev/XXX` 是否正确匹配了 `-drive` 的 `if=` 类型。
    - 检查根文件系统镜像 (`rootfs.extX`) 是否生成正确且未损坏。
    - 确保内核配置中包含了所需的文件系统驱动 (e.g., EXT4) 和磁盘接口驱动 (e.g., VIRTIO_BLK, MMC)。
- **无控制台输出:**
    - 检查 `-append` 中的 `console=ttyXXX` 是否适用于您模拟的 `-M <machine>`。
    - 确保使用了 `-nographic` 或正确的 `-serial` 重定向。
- **QEMU 报错退出:** 仔细阅读 QEMU 的错误信息，通常会指示哪个参数有问题或缺少文件。
- **查看 Buildroot 文档:** Buildroot 源码中的 `board/qemu/<arch>-<board>/readme.txt` 文件通常包含针对该特定 QEMU 配置的详细启动说明。

## 9. 总结

QEMU 是 Buildroot 开发流程中的宝贵工具，它提供了一个便捷、低成本的方式来测试和迭代嵌入式 Linux 系统。通过理解 Buildroot 的输出和 QEMU 的常用参数，您可以有效地在仿真环境中进行开发和调试工作。利用 Buildroot 内置的 QEMU defconfig 和 `start-qemu.sh` 脚本是快速上手的最佳途径。

```
这个笔记详细介绍了如何使用 QEMU 来仿真 Buildroot 构建的系统，包括使用 Buildroot 提供的便捷脚本和手动配置 QEMU 命令的方法，并涵盖了常用选项、交互方式、高级技巧和故障排除。希望对您有所帮助
```
