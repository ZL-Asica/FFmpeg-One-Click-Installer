#!/usr/bin/env bash
#
# Auto install FFmpeg with multi-language support
# System Required: CentOS, Ubuntu, Debian, Fedora, Arch Linux, Deepin, Mint, Raspbian, RHEL
# Supports both x86 and ARM architectures
# Copyright (C) 2019-2024 ZL Asica

# Define color codes for output
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
pink=$(tput setaf 5)
cyan=$(tput setaf 6)
plain=$(tput sgr0)

# Multi-language messages, enhanced for comprehensiveness
declare -A messages
# English messages
messages[en_error_root]="Error: This script must be run as root!"
messages[en_error_unsupported]="Error: Unsupported system. This script only supports CentOS, Ubuntu, Debian, and derivatives."
messages[en_pre_install_already_installed]="FFmpeg is already installed. Installed version: "
messages[en_pre_install_ask_update]="Do you want to update FFmpeg? (y/n): "
messages[en_pre_install_not_update]="Keeping the installed version and exiting."
messages[en_pre_install]="Choose installation method:\n1) Quick install\n2) Compile from source"
messages[en_pre_install_method]="Select an option (1-2): "
messages[en_pre_install_centos]="Detected CentOS/RHEL/Fedora. Proceeding with quick installation method.\nCompiling from source is not supported on this OS."
messages[en_pre_install_centos_ask]="Do you want to install using the quick method (since compiling from source is not supported)? (y/n): "
messages[en_install_dependencies]="Installing necessary dependencies for compiling FFmpeg..."
messages[en_qinstall_ffmpeg]="Attempting quick installation using package manager..."
messages[en_compiling_ffmpeg]="Compiling FFmpeg from source..."
messages[en_compiling_ffmpeg_prompt]="We are checking the system and compiling FFmpeg from source. This process may take a while. \nPlease be patient. May take around 5-10 minutes depending on your system's performance."
messages[en_cleaning_up]="Cleaning up..."
messages[en_ffmpeg_installed]="FFmpeg installation complete."
messages[en_invalid_option]="Error: Invalid option selected."
messages[en_detected_system]="Detected system:"
messages[en_welcome]="Welcome to ZL Asica FFmpeg Auto Installer for Linux\nBlog: https://www.zl-asica.com/\nContact: zl@zla.moe"
messages[en_installation_failed]="Error: FFmpeg installation failed. Please check your system and dependencies.\nReport issues at: https://github.com/ZL-Asica/one-key-ffmpeg/issues"
# Chinese messages
messages[zh_error_root]="错误: 此脚本必须以root账户运行!"
messages[zh_error_unsupported]="错误: 不支持的系统。此脚本仅支持 CentOS, Ubuntu, Debian 及其衍生版。"
messages[zh_pre_install_already_installed]="FFmpeg 已安装。已安装版本: "
messages[zh_pre_install_ask_update]="是否要更新 FFmpeg? (y/n): "
messages[zh_pre_install_not_update]="保留已安装的版本并退出。"
messages[zh_pre_install]="选择安装方式:\n1) 极速安装\n2) 从源代码编译"
messages[zh_pre_install_method]="选择一个选项 (1-2): "
messages[zh_pre_install_centos]="检测到 CentOS/RHEL/Fedora。正在使用极速安装方法。\n不支持在此系统上从源代码编译。"
messages[zh_pre_install_centos_ask]="是否要使用极速安装方法 (因为不支持从源代码编译)? (y/n): "
messages[zh_install_dependencies]="正在安装编译 FFmpeg 所需的依赖..."
messages[zh_qinstall_ffmpeg]="正在尝试使用包管理器进行快速安装..."
messages[zh_compiling_ffmpeg]="正在从源代码编译 FFmpeg..."
messages[zh_compiling_ffmpeg_prompt]="我们正在检查系统并从源代码编译 FFmpeg。此过程可能需要一些时间，请耐心等待。\n根据您的系统性能，可能需要5-10分钟。"
messages[zh_cleaning_up]="正在清理..."
messages[zh_ffmpeg_installed]="FFmpeg 安装完成。"
messages[zh_invalid_option]="错误: 选择了无效的选项。"
messages[zh_detected_system]="检测到的系统:"
messages[zh_welcome]="欢迎使用ZL Asica的FFmpeg Linux自动安装脚本\n博客: https://www.zl-asica.com/\n联系: zl@zla.moe"
messages[zh_installation_failed]="错误: FFmpeg 安装失败。请检查你的系统和依赖项。\n请在以下链接报告问题: https://github.com/ZL-Asica/one-key-ffmpeg/issues"
# Japanese messages
messages[jp_error_root]="エラー: このスクリプトはrootで実行する必要があります！"
messages[jp_error_unsupported]="エラー: システムがサポートされていません。このスクリプトはCentOS、Ubuntu、Debianおよびその派生版のみをサポートしています。"
messages[jp_pre_install_already_installed]="FFmpegはすでにインストールされています。インストールされたバージョン: "
messages[jp_pre_install_ask_update]="FFmpegを更新しますか？ (y/n): "
messages[jp_pre_install_not_update]="インストールされたバージョンを保持して終了します。"
messages[jp_pre_install]="インストール方法を選択してください:\n1) クイックインストール\n2) ソースからコンパイル"
messages[jp_pre_install_method]="オプションを選択してください (1-2): "
messages[jp_pre_install_centos]="CentOS/RHEL/Fedoraが検出されました。クイックインストール方法を使用して続行します。\nこのOSではソースからのコンパイルはサポートされていません。"
messages[jp_pre_install_centos_ask]="クイックインストール方法を使用しますか (ソースからのコンパイルはサポートされていないため)? (y/n): "
messages[jp_install_dependencies]="FFmpegをコンパイルするための必要な依存関係をインストールしています..."
messages[jp_qinstall_ffmpeg]="パッケージマネージャを使用してクイックインストールを試みています..."
messages[jp_compiling_ffmpeg]="ソースからFFmpegをコンパイルしています..."
messages[jp_compiling_ffmpeg_prompt]="システムをチェックし、ソースからFFmpegをコンパイルしています。このプロセスには時間がかかる場合があります。\nお待ちください。システムのパフォーマンスに応じて、5〜10分かかる場合があります。"
messages[jp_cleaning_up]="クリーンアップ中..."
messages[jp_ffmpeg_installed]="FFmpegのインストールが完了しました。"
messages[jp_invalid_option]="エラー: 無効なオプションが選択されました。"
messages[jp_detected_system]="検出されたシステム:"
messages[jp_welcome]="Linux用ZL Asica FFmpeg自動インストーラーへようこそ\nブログ: https://www.zl-asica.com/\nお問い合わせ: zl@zla.moe"
messages[jp_installation_failed]="エラー: FFmpegのインストールに失敗しました。システムと依存関係を確認してください。\n問題を報告する: https://github.com/ZL-Asica/one-key-ffmpeg/issues"

# Function to display error messages and exit
error_exit() {
    local msg_key="$1"
    echo -e "${red}${messages[${lang}_$msg_key]}${plain}" >&2
    echo -e "${red}If you encounter any issues, please report them at: https://github.com/ZL-Asica/one-key-ffmpeg/issues\n如果遇到任何问题，请在以下链接报告问题: https://github.com/ZL-Asica/one-key-ffmpeg/issues${plain}" >&2
    exit 1
}

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
            sudo yum update
            sudo yum install epel-release -y
            sudo yum install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm -y
            sudo yum update
            sudo yum install ffmpeg ffmpeg-devel -y
            ;;
        debian|ubuntu|raspbian)
            sudo apt update && sudo apt install ffmpeg -y
            ;;
        *)
            error_exit "error_unsupported"
            ;;
    esac
    # Check if FFmpeg is installed
    if ! command -v ffmpeg &>/dev/null; then
        echo -e "${red}${messages[${lang}_installation_failed]}${plain}"
        exit 1
    fi
}

# Install dependencies for compiling FFmpeg from source
install_dependencies() {
    echo -e "${cyan}${messages[${lang}_install_dependencies]}${plain}"
        apt update
        apt install build-essential nasm yasm libx264-dev libx265-dev libfdk-aac-dev libvpx-dev libopus-dev -y
}

# Compile FFmpeg from source
compile_ffmpeg() {
    echo -e "${green}${messages[${lang}_compiling_ffmpeg]}${plain}"
    cd /usr/local/src || exit
    rm -rf ffmpeg # Remove any existing source code
    if ! git clone --depth 1 https://git.ffmpeg.org/ffmpeg.git ffmpeg; then
        echo -e "${red}${messages[${lang}_installation_failed]}${plain}"
        exit 1
    fi
    cd ffmpeg || exiting
    echo -e "${green}${messages[${lang}_compiling_ffmpeg_prompt]}${plain}"
    ./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libfdk-aac --enable-libvpx --enable-libopus --enable-nonfree
    if [ $? -ne 0 ]; then
        echo -e "${red}${messages[${lang}_installation_failed]}${plain}"
        exit 1
    fi
    if ! make -j"$(nproc)"; then
        echo -e "${red}${messages[${lang}_installation_failed]}${plain}"
        exit 1
    fi
    make install
    hash -r
    # remove source code
    cd .. && rm -rf ffmpeg
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

# Check if FFmpeg is already installed and its version
remove_existing_ffmpeg() {
    echo -e "${cyan}Detecting existing FFmpeg installation...${plain}"
    if command -v ffmpeg &>/dev/null; then
        local installed_version=$(ffmpeg -version | head -n1 | grep -oP '(?<=ffmpeg version )[^ ]+')
        echo -e "${blue}Found FFmpeg version: ${installed_version}${plain}"
        read -p "${green}${messages[${lang}_pre_install_ask_update]}${plain}" update_choice
        if [[ $update_choice =~ ^[Yy]$ ]]; then
            echo -e "${cyan}Removing existing FFmpeg version...${plain}"
            # Try to remove FFmpeg using package manager first
            if command -v apt &>/dev/null; then
                sudo apt remove ffmpeg -y
            elif command -v yum &>/dev/null; then
                sudo yum remove ffmpeg ffmpeg-devel -y
            fi
            # Remove any remaining files if the package manager didn't remove them
            if [ -f /usr/local/bin/ffmpeg ]; then
                sudo rm /usr/local/bin/ffmpeg
            fi
            if [ -f /usr/bin/ffmpeg ]; then
                sudo rm /usr/bin/ffmpeg
            fi
            echo "Existing FFmpeg removed."
        else
            echo -e "${red}${messages[${lang}_pre_install_not_update]}${plain}"
            exit 0
        fi
    fi
}

# Main installation process
main() {
    detect_system
    echo -e "\n${blue}${messages[${lang}_detected_system]} $ID $VERSION_ID ($arch)\n${plain}"
    
    # Check if FFmpeg is already installed and ask the user if they want to update it
    remove_existing_ffmpeg
    
    # If the system is CentOS/RHEL/Fedora, use the quick installation method
    if [[ "$ID" == "centos" || "$ID" == "rhel" || "$ID" == "fedora" ]]; then
        echo -e "${cyan}${messages[${lang}_pre_install_centos]}${plain}"
        read -p "${green}${messages[${lang}_pre_install_centos_ask]}${plain}" install_choice
        if [[ $install_choice =~ ^[Yy]$ ]]; then
            echo -e "${cyan}${messages[${lang}_qinstall_ffmpeg]}${plain}"
        else
            echo -e "${blue}Thank you for using ZL Asica FFmpeg Auto Installer!${plain}"
            exit 0
        fi
        install_ffmpeg_package
    else
        # If the system is Ubuntu/Debian/Raspbian, ask the user to choose an installation method
        echo -e "${green}${messages[${lang}_pre_install]}${plain}"
        read -p "${green}${messages[${lang}_pre_install_method]}${plain}" method
        case $method in
            1)
                echo -e “${cyan}${messages[${lang}_qinstall_ffmpeg]}${plain}”
                install_ffmpeg_package
                ;;
            2)
                install_dependencies && compile_ffmpeg && clean_up
                ;;
            *)
                echo -e "${red}${messages[${lang}_invalid_option]}${plain}"
                exit 1
                ;;
        esac
    fi
    echo -e "${cyan}${messages[${lang}_ffmpeg_installed]}${plain}"
}

# ----------------------------------------------------------
# Start of the script
# ----------------------------------------------------------

# Move focus to the top of the terminal without clearing the screen
printf '\033c'

# Ensure the script is run as root
[[ $EUID -ne 0 ]] && error_exit "error_root"

# Select language
echo "" # New line for better readability
echo -e "${pink}"
cat << "EOF"
 ______          _        _           
|__  / |        / \   ___(_) ___ __ _ 
  / /| |       / _ \ / __| |/ __/ _` |
 / /_| |___   / ___ \\__ \ | (_| (_| |
/____|_____| /_/   \_\___/_|\___\__,_|                                     

EOF
echo -e "${pink}FFmpeg One Click Installer （FFmpeg一键安装）- Linux${plain}"
echo -e "${pink}https://github.com/ZL-Asica/FFmpeg-One-Click-Installer${plain}\n" # Default welcome message

echo -e "${green}Select a language / 选择语言 / 言語を選択${plain}"
echo -e "${green}\t1) English${plain}"
echo -e "${green}\t2) 中文${plain}"
echo -e "${green}\t3) 日本語${plain}"
read -p "${green}Select an option / 选择一个选项 / オプションを選択 (1/2/3): ${plain}" lang_choice

lang="en" # Default to English

case $lang_choice in
    1) lang="en";;
    2) lang="zh";;
    3) lang="jp";;
    *) echo -e "${red}${messages[en_invalid_option]}${plain}" && exit 1;; # Default error message in English
esac

# Welcome message in selected language
echo -e "${pink}\n${messages[${lang}_welcome]}\n${plain}"

# Start the installation process
main
