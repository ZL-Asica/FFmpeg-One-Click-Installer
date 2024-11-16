# FFmpeg One Click Installer - Linux

[中文](./README_CN.md)

[![Bash][bash-badge]][bash-link]
[![GitHub][github-badge]](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer)

This script provides an automated way to install FFmpeg on various Linux distributions and architectures with an easy-to-use interface and robust error handling.

## ✨ Features

- **Wide Distribution Support**: Compatible with major Linux distributions like CentOS, Ubuntu, Debian, RHEL, Fedora, and derivatives.
- **Multi-Architecture Compatibility**: Supports both x86_64 and ARM (aarch64, arm64) architectures.
- **Flexible Installation**: Choose between quick installation (via package manager) and compilation from source (for maximum control).
- **Multi-Language Interface**: Supports multiple languages, currently available in English and Chinese.
- **Automatic Cleanup**: Ensures a clean environment by removing unnecessary files after installation.

## 📋 Requirements

- Root privileges (`sudo`).
- Internet connection for downloading dependencies and script modules.

## 🚀 Installation

Run the following one-liner to install FFmpeg interactively:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ZL-Asica/FFmpeg-One-Click-Installer/main/zla-install-ffmpeg.sh)"
```

or through `wget`:
  
```bash
sudo bash -c "$(wget -O- https://raw.githubusercontent.com/ZL-Asica/FFmpeg-One-Click-Installer/main/zla-install-ffmpeg.sh)"
```

## ⚠️ Notice for CentOS/RHEL/Fedora Users

- **Compilation Installation Unavailable**: Due to dependency limitations, compiling FFmpeg from source is not supported on CentOS/RHEL/Fedora. Quick installation via `yum` is the only available method for these distributions.
- **Recommendation for Debian/Ubuntu**: It is recommended to use the compilation installation method for the best customization and compatibility on Debian/Ubuntu/Raspbian-based systems.

## 🛠️ Usage

Once the installation is complete, you can use FFmpeg directly by running the `ffmpeg` command. For example:

```bash
ffmpeg -version
```

If you encounter any issues, please report them on the [GitHub Issues page](https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues).

## 📖 FFmpeg Tutorial

For more advanced usage of FFmpeg, check out the [tutorial on my blog (in Chinese)](https://www.zla.pub/ffmpeg).

## 🌐 Screenshots

**English Version**  
![EN-zla-ffmpeg][demo-en]

**Japanese Version**  
![JP-zla-ffmpeg][demo-jp]

**Chinese Version**
![ZH-zla-ffmpeg][demo-zh]

[bash-badge]: https://img.shields.io/badge/Bash-4EAA25?logo=gnubash&logoColor=fff
[bash-link]: https://www.gnu.org/software/bash/
[demo-en]: https://s2.loli.net/2024/11/17/4MGwOe3jVirmPUN.webp
[demo-jp]: https://s2.loli.net/2024/11/17/OYE7KxZXQHSbve3.webp
[demo-zh]: https://s2.loli.net/2024/11/17/7atgHceAs83MzZF.webp
[github-badge]: https://img.shields.io/badge/GitHub-%23121011.svg?logo=github&logoColor=white
