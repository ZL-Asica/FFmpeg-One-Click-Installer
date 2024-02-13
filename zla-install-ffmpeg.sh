#!/usr/bin/env bash
#
# Auto install FFmpeg with multi-language support
# System Required: CentOS, Ubuntu, Debian, Fedora, Arch Linux, Deepin, Mint, Raspbian, RHEL
# Supports both x86 and ARM architectures
# Copyright (C) 2019-2024 ZL Asica

# Define color codes for output
red='\033[0;31m'
cyan='\033[1;36m'
plain='\033[0m'

# Multi-language messages, enhanced for comprehensiveness
declare -A messages
# English messages
messages[en_error_root]="Error: This script must be run as root!"
messages[en_error_unsupported]="Error: Unsupported system. This script only supports CentOS, Ubuntu, Debian, and derivatives."
messages[en_install_dependencies]="Installing necessary dependencies for compiling FFmpeg..."
messages[en_compiling_ffmpeg]="Compiling FFmpeg from source..."
messages[en_cleaning_up]="Cleaning up..."
messages[en_ffmpeg_installed]="FFmpeg installation complete."
messages[en_invalid_option]="Error: Invalid option selected."
messages[en_detected_system]="Detected system:"
messages[en_welcome]="Welcome to ZL Asica FFmpeg Auto Installer for Linux\nBlog: https://www.zl-asica.com/\nContact: zl@zla.moe"
messages[en_installation_failed]="Error: FFmpeg installation failed. Please check your system and dependencies."
# Chinese messages
messages[zh_error_root]="错误: 此脚本必须以root账户运行!"
messages[zh_error_unsupported]="错误: 不支持的系统。此脚本仅支持 CentOS, Ubuntu, Debian 及其衍生版。"
messages[zh_install_dependencies]="正在安装编译 FFmpeg 所需的依赖..."
messages[zh_compiling_ffmpeg]="正在从源代码编译 FFmpeg..."
messages[zh_cleaning_up]="正在清理..."
messages[zh_ffmpeg_installed]="FFmpeg 安装完成。"
messages[zh_invalid_option]="错误: 选择了无效的选项。"
messages[zh_detected_system]="检测到的系统:"
messages[zh_welcome]="欢迎使用ZL Asica的FFmpeg Linux自动安装脚本\n博客: https://www.zl-asica.com/\n联系: zl@zla.moe"
messages[zh_installation_failed]="错误: FFmpeg 安装失败。请检查你的系统和依赖项。"

# Function to display error messages and exit
error_exit() {
    local msg_key="$1"
    echo -e "${red}${messages[${lang}_$msg_key]}${plain}" >&2
    echo -e "${red}If you encounter any issues, please report them at: https://github.com/ZL-Asica/one-key-ffmpeg/issues\n如果遇到任何问题，请在以下链接报告问题: https://github.com/ZL-Asica/one-key-ffmpeg/issues${plain}" >&2
    exit 1
}

# Ensure the script is run as root
[[ $EUID -ne 0 ]] && error_exit "error_root"

# Select language
echo "\n\nZL Asica FFmpeg Auto Installer\nhttps://github.com/ZL-Asica/one-key-ffmpeg\n" # Default welcome message
echo "Select a language / 选择语言:"
echo "1) English"
echo "2) 中文"
read -p "Select an option / 选择一个选项 (1-2): " lang_choice

lang="en" # Default to English

case $lang_choice in
    1) lang="en";;
    2) lang="zh";;
    *) echo "${messages[en_invalid_option]}" && exit 1;; # Default error message in English
esac

# Welcome message in selected language
echo -e "${messages[${lang}_welcome]}\n"

# Detect system version and architecture
detect_system() {
    . /etc/os-release
    case "$ID" in
        centos|rhel|fedora|debian|ubuntu|raspbian) release="$ID";;
        *) error_exit "error_unsupported";;
    esac
    arch=$(uname -m)
    # Check for ARM architecture
    [[ "$arch" != "x86_64" && "$arch" != "aarch64" ]] && error_exit "error_unsupported"
}

# Function to install FFmpeg using package manager
install_ffmpeg_package() {
    echo "Attempting quick installation using package manager..."
    case "$release" in
        centos|rhel|fedora)
            yum install epel-release -y && yum install ffmpeg ffmpeg-devel -y
            ;;
        debian|ubuntu|raspbian)
            apt update && apt install ffmpeg -y
            ;;
        *)
            error_exit "error_unsupported"
            ;;
    esac
    # Check if FFmpeg is installed
    if ! command -v ffmpeg &>/dev/null; then
        error_exit "installation_failed"
    fi
    echo -e "${messages[${lang}_ffmpeg_installed]}"
}

# Install dependencies for compiling FFmpeg from source
install_dependencies() {
    echo "${messages[${lang}_install_dependencies]}"
    case "$release" in
        centos|rhel|fedora)
            yum groupinstall "Development Tools" -y
            yum install nasm yasm libx264-devel libx265-devel libfdk-aac-devel libvpx-devel libopus-devel -y
            ;;
        debian|ubuntu|raspbian)
            apt update
            apt install build-essential nasm yasm libx264-dev libx265-dev libfdk-aac-dev libvpx-dev libopus-dev -y
            ;;
        *)
            error_exit "error_unsupported"
            ;;
    esac
}

# Compile FFmpeg from source
compile_ffmpeg() {
    echo "${messages[${lang}_compiling_ffmpeg]}"
    cd /usr/local/src || exit
    if ! git clone --depth 1 https://git.ffmpeg.org/ffmpeg.git ffmpeg; then
        echo "${messages[${lang}_installation_failed]}"
        exit 1
    fi
    cd ffmpeg || exit
    ./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libfdk-aac --enable-libvpx --enable-libopus
    if ! make -j"$(nproc)"; then
        echo "${messages[${lang}_installation_failed]}"
        exit 1
    fi
    make install
    hash -r
    # remove source code
    rm -rf /usr/local/src/ffmpeg
}

# Clean up unnecessary files and packages
clean_up() {
    echo "${messages[${lang}_cleaning_up]}"
    case "$release" in
        centos|rhel|fedora)
            yum groupremove "Development Tools" -y
            yum remove epel-release -y
            ;;
        debian|ubuntu|raspbian)
            apt remove build-essential -y
            ;;
        *)
            error_exit "error_unsupported"
            ;;
    esac
}

# Main installation process
main() {
    detect_system
    echo "${messages[${lang}_detected_system]} $ID $VERSION_ID ($arch)"
    echo -e "Choose installation method / 选择安装方式:\n1) Quick install / 快速安装\n2) Compile from source / 从源代码编译"
    read -p "Select an option / 选择一个选项 (1-2): " method
    case $method in
        1) install_ffmpeg_package;;
        2) install_dependencies && compile_ffmpeg && clean_up;;
        *) error_exit "error_invalid_option";;
    esac

    echo -e "${cyan}${messages[${lang}_ffmpeg_installed]}${plain}"
}