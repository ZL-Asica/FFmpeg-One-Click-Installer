#!/usr/bin/env bash

declare -A messages

# Multilingual support
load_languages_messages() {
    # Associative array of messages
    messages=(
        [en_exiting]="Encountered an error. Exiting...\nIf you think this is a bug, please report it."
        [en_error_root]="Error: This script must be run as root!"
        [en_error_unsupported]="Error: Unsupported system. This script only supports CentOS, Ubuntu, Debian, and derivatives."
        [en_pre_install_already_installed]="FFmpeg is already installed. Installed version: "
        [en_pre_install_ask_update]="Do you want to update FFmpeg? (y/n): "
        [en_pre_install_not_update]="Keeping the installed version and exiting."
        [en_pre_install]="Choose installation method:\n1) Quick install\n2) Compile from source"
        [en_pre_install_method]="Select an option (1-2): "
        [en_pre_install_yum]="Detected CentOS/RHEL/Fedora. Proceeding with quick installation method.\nCompiling from source is not supported on this OS."
        [en_pre_install_yum_ask]="Do you want to install using the quick method (since compiling from source is not supported)? "
        [en_install_dependencies]="Installing necessary dependencies for compiling FFmpeg..."
        [en_qinstall_ffmpeg]="Attempting quick installation using package manager..."
        [en_compiling_ffmpeg]="Compiling FFmpeg from source..."
        [en_compiling_ffmpeg_prompt]="We are checking the system and compiling FFmpeg from source. This process may take a while. \nPlease be patient. May take around 5-10 minutes depending on your system's performance."
        [en_cleaning_up]="Cleaning up..."
        [en_ffmpeg_installed]="FFmpeg installation complete."
        [en_invalid_option]="Error: Invalid option selected."
        [en_detected_system]="Detected system:"
        [en_welcome]="Welcome to ZL Asica FFmpeg Auto Installer for Linux\nBlog: https://www.zla.pub/\nContact: zl@zla.app"
        [en_installation_failed]="Error: FFmpeg installation failed. Please check your system and dependencies.\nReport issues at: https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues"
        [en_cancelled]="Installation canceled. Thank you for using ZL Asica FFmpeg Auto Installer!"

        # Chinese messages
        [zh_exiting]="遇到错误。正在退出...\n如果您认为这是一个错误，请报告给我们。"
        [zh_error_root]="错误: 此脚本必须以root账户运行!"
        [zh_error_unsupported]="错误: 不支持的系统。此脚本仅支持 CentOS, Ubuntu, Debian 及其衍生版。"
        [zh_pre_install_already_installed]="FFmpeg 已安装。已安装版本: "
        [zh_pre_install_ask_update]="是否要更新 FFmpeg? (y/n): "
        [zh_pre_install_not_update]="保留已安装的版本并退出。"
        [zh_pre_install]="选择安装方式:\n1) 极速安装\n2) 从源代码编译"
        [zh_pre_install_method]="选择一个选项 (1-2): "
        [zh_pre_install_yum]="检测到 CentOS/RHEL/Fedora。正在使用极速安装方法。\n不支持在此系统上从源代码编译。"
        [zh_pre_install_yum_ask]="是否要使用极速安装方法 (因为不支持从源代码编译)? "
        [zh_install_dependencies]="正在安装编译 FFmpeg 所需的依赖..."
        [zh_qinstall_ffmpeg]="正在尝试使用包管理器进行快速安装..."
        [zh_compiling_ffmpeg]="正在从源代码编译 FFmpeg..."
        [zh_compiling_ffmpeg_prompt]="我们正在检查系统并从源代码编译 FFmpeg。此过程可能需要一些时间，请耐心等待。\n根据您的系统性能，可能需要5-10分钟。"
        [zh_cleaning_up]="正在清理..."
        [zh_ffmpeg_installed]="FFmpeg 安装完成。"
        [zh_invalid_option]="错误: 选择了无效的选项。"
        [zh_detected_system]="检测到的系统:"
        [zh_welcome]="欢迎使用ZL Asica的FFmpeg Linux自动安装脚本\n博客: https://www.zla.pub/\n联系: zl@zla.app"
        [zh_installation_failed]="错误: FFmpeg 安装失败。请检查你的系统和依赖项。\n请在以下链接报告问题: https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues"
        [zh_cancelled]="安装已取消。感谢使用ZL Asica的FFmpeg自动安装程序！"

        # Japanese messages
        [jp_exiting]="エラーが発生しました。終了しています...\nバグだと思われる場合は報告してください。"
        [jp_error_unsupported]="エラー: システムがサポートされていません。このスクリプトはCentOS、Ubuntu、Debianおよびその派生版のみをサポートしています。"
        [jp_pre_install_already_installed]="FFmpegはすでにインストールされています。インストールされたバージョン: "
        [jp_pre_install_ask_update]="FFmpegを更新しますか？ (y/n): "
        [jp_pre_install_not_update]="インストールされたバージョンを保持して終了します。"
        [jp_pre_install]="インストール方法を選択してください:\n1) クイックインストール\n2) ソースからコンパイル"
        [jp_pre_install_method]="オプションを選択してください (1-2): "
        [jp_pre_install_yum]="CentOS/RHEL/Fedoraが検出されました。クイックインストール方法を使用して続行します。\nこのOSではソースからのコンパイルはサポートされていません。"
        [jp_pre_install_yum_ask]="クイックインストール方法を使用しますか (ソースからのコンパイルはサポートされていないため)? "
        [jp_install_dependencies]="FFmpegをコンパイルするための必要な依存関係をインストールしています..."
        [jp_qinstall_ffmpeg]="パッケージマネージャを使用してクイックインストールを試みています..."
        [jp_compiling_ffmpeg]="ソースからFFmpegをコンパイルしています..."
        [jp_compiling_ffmpeg_prompt]="システムをチェックし、ソースからFFmpegをコンパイルしています。このプロセスには時間がかかる場合があります。\nお待ちください。システムのパフォーマンスに応じて、5〜10分かかる場合があります。"
        [jp_cleaning_up]="クリーンアップ中..."
        [jp_ffmpeg_installed]="FFmpegのインストールが完了しました。"
        [jp_invalid_option]="エラー: 無効なオプションが選択されました。"
        [jp_detected_system]="検出されたシステム:"
        [jp_welcome]="Linux用ZL Asica FFmpeg自動インストーラーへようこそ\nブログ: https://www.zla.pub/\nお問い合わせ: zl@zla.app"
        [jp_installation_failed]="エラー: FFmpegのインストールに失敗しました。システムと依存関係を確認してください。\n問題を報告する: https://github.com/ZL-Asica/FFmpeg-One-Click-Installer/issues"
        [jp_cancelled]="インストールがキャンセルされました。ZL Asica FFmpeg Auto Installerをご利用いただきありがとうございます！"
    )

    # Array of supported languages
    languages=("en" "zh" "jp" "exit")
}


# Function to choose lang
select_language() {
    load_languages_messages

    echo -e "${green}Select a language / 选择语言 / 言語を選択${plain}"
    for i in "${!languages[@]}"; do
        echo -e "${green}\t$i) ${languages[$i]}${plain}"
    done

    while true; do
        read -p "Select an option (0-$(( ${#languages[@]} - 1 ))) (default: 0): " lang_choice
        lang_choice=${lang_choice:-0}
        if [[ $lang_choice =~ ^[0-9]+$ ]] && [[ $lang_choice -ge 0 ]] && [[ $lang_choice -lt ${#languages[@]} ]]; then
            selected_language="${languages[$lang_choice]}"
            if [[ "$selected_language" == "exit" ]]; then
                echo -e "${blue}${messages[en_exiting]}${plain}"
                exit 0
            else
                lang="$selected_language"
                echo -e "${pink}\n${messages[${lang}_welcome]}\n${plain}"
                break
            fi
        else
            echo -e "${red}${messages[${lang}_invalid_option]}${plain}"
        fi
    done
}