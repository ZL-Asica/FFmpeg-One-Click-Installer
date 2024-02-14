# FFmpeg One Click Installer （FFmpeg一键安装）- Linux

[中文README请点击这里](https://github.com/ZL-Asica/one-key-ffmpeg/blob/master/README_CN.md)

This script provides an automated way to install FFmpeg on various Linux distributions and architectures.

## Notice(CentOS)

- Temporarily not support compile installation for CentOS/RHEL/Fedora due to dependencies issues. However, "Quick install" still usable.
- For Debian/Ubuntu/Raspbian/etc., recommend to use compile installation instead of "Quick install".

## Features

- Supports multiple Linux distributions and architectures.
- Offers both quick and source compilation installation methods.
- Multi-language support (English and Chinese).
- Auto cleanup before and after installation.

## Requirements

- Root access to the system `sudo`
- Internet connection to `github`

## Installation

To install FFmpeg using this script, you can use the following one-liner command. This command downloads the script and executes it, offering you an interactive installation process:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ZL-Asica/one-key-ffmpeg/master/zla-install-ffmpeg.sh)"
```

## Usage

After installation, you can simply run `ffmpeg` to access its features. If you encounter any issues, please report them on the [GitHub issues page](https://github.com/ZL-Asica/one-key-ffmpeg/issues).

![EN-zla-ffmpeg](https://s2.loli.net/2024/02/14/Jn3Vo5DHFi4UaTe.png)
![JP-zla-ffmpeg](https://s2.loli.net/2024/02/14/jaUxPhmT4trIkB2.png)

## FFmpeg Tutorial

[Tutorial on my blog - in Chinese](https://www.zla.pub/ffmpeg)
