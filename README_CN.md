# FFmpeg One Click Installer （FFmpeg一键安装）- Linux

此脚本能够一键在各种 Linux 发行版/架构上安装 FFmpeg。

## 注意(CentOS)

- 因为依赖等及官方停止维护等原因，暂不支持CentOS/RHEL/Fedora的编译安装。但极速安装仍然可用
- 对于Debian/Ubuntu/Raspbian及衍生系统，推荐使用编译安装。

## 特点

- 支持多种 Linux 发行版和架构
- 提供极速安装和源代码编译安装两种安装方法
- 支持多语言（英文和中文）
- 安装前后自动垃圾清理

## 要求

- 系统的 root 访问权限`sudo`
- 网络连接-能够连接到`github`或`jsdelivr`

## 安装

使用以下一行命令安装 FFmpeg，该命令会下载脚本并执行，提供交互式安装过程：

```bash
sudo bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/ZL-Asica/FFmpeg-One-Click-Installer@main/zla-install-ffmpeg.sh)"
```

## 使用

安装完成后，可以直接运行 `ffmpeg` 来访问其功能。如果遇到任何问题，请在 [GitHub 问题页面](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues)报告。

![CN-zla-ffmpeg](https://s2.loli.net/2024/02/14/HPlkfCXb1AZOJTS.png)

## FFmpeg使用教程

[可以查看我的博客文章有比较清晰的教学](https://www.zla.pub/ffmpeg)
