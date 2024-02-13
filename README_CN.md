# ZL Asica的一键FFmpeg 自动安装脚本

此脚本能够一键在各种 Linux 发行版/架构上安装 FFmpeg。

## 特点

- 支持多种 Linux 发行版
- 自动检测系统和架构
- 提供快速安装和源代码编译两种安装方法
- 支持多语言（英文和中文）

## 要求

- 系统的 root 访问权限
- 网络连接

## 安装

使用以下一行命令安装 FFmpeg，该命令会下载脚本并执行，提供交互式安装过程：

```bash
sudo bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/ZL-Asica/one-key-ffmpeg@master/zla-install-ffmpeg.sh)"
```

## 使用

安装完成后，可以直接运行 `ffmpeg` 来访问其功能。如果遇到任何问题，请在 [GitHub 问题页面](https://github.com/ZL-Asica/one-key-ffmpeg/issues)报告。

## FFmpeg使用教程

[可以查看我的博客文章有比较清晰的教学](https://www.zla.pub/ffmpeg)
