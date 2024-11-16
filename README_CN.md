# FFmpeg 一键安装脚本 - Linux

[English README](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/blob/main/README.md)

[![Bash][bash-badge]][bash-link]  
[![GitHub][github-badge]](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer)

该脚本提供了一种自动化方式，用于在各种 Linux 发行版和架构上安装 FFmpeg，支持简单的交互式操作和强大的错误处理。

## ✨ 功能特点

- **广泛的发行版支持**：兼容主流 Linux 发行版，包括 CentOS、Ubuntu、Debian、RHEL、Fedora 及其衍生版本。
- **多架构兼容**：支持 x86_64 和 ARM (aarch64, arm64) 架构。
- **灵活的安装方式**：支持快速安装（通过包管理器）和源码编译安装两种方式，满足不同需求。
- **多语言界面**：当前支持英语和中文。
- **自动清理**：确保安装前后环境整洁，移除无用的临时文件。

## 📋 使用要求

- 系统需拥有 **root 权限**（`sudo`）。
- 网络连接，用于下载依赖和脚本模块。

## 🚀 安装方法

运行以下一键命令，启动交互式安装过程：

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ZL-Asica/FFmpeg-One-Click-Installer/main/zla-install-ffmpeg.sh)"
```

或通过 `wget`：

```bash
sudo bash -c "$(wget -O- https://raw.githubusercontent.com/ZL-Asica/FFmpeg-One-Click-Installer/main/zla-install-ffmpeg.sh)"
```

## ⚠️ CentOS/RHEL/Fedora 用户注意事项

- **不支持编译安装**：由于依赖限制，CentOS/RHEL/Fedora 系统不支持源码编译安装。当前仅支持通过 `yum` 的快速安装方式。
- **Debian/Ubuntu 推荐**：在 Debian/Ubuntu/Raspbian 系统上，建议选择源码编译安装，以获得更高的兼容性和自定义支持。

## 🛠️ 使用方法

安装完成后，可以直接运行以下命令验证 FFmpeg 是否安装成功：

```bash
ffmpeg -version
```

如果遇到问题，请在 [GitHub Issues 页面](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues) 提交报告。

## 🌐 截图展示

**中文版本界面**
![ZH-zla-ffmpeg][demo-zh]

**英文版本界面**  
![EN-zla-ffmpeg][demo-en]

**日文版本界面**  
![JP-zla-ffmpeg][demo-jp]

## 📖 FFmpeg 教程

更多 FFmpeg 使用教程，请参考 [我的博客教程](https://www.zla.pub/ffmpeg)。

[bash-badge]: https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=fff
[bash-link]: https://www.gnu.org/software/bash/
[demo-en]: https://s2.loli.net/2024/11/17/4MGwOe3jVirmPUN.webp
[demo-jp]: https://s2.loli.net/2024/11/17/OYE7KxZXQHSbve3.webp
[demo-zh]: https://s2.loli.net/2024/11/17/7atgHceAs83MzZF.webp
[github-badge]: https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white