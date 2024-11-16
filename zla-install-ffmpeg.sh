#!/usr/bin/env bash
#
# Auto install FFmpeg with multi-language support
# Supports x86 and ARM architectures
# Author: ZL Asica


# Define color codes for output
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
pink=$(tput setaf 5)
cyan=$(tput setaf 6)
plain=$(tput sgr0)

DOWNLOAD_TOOL=""
# Base URL for downloading modules
REPO_URL="https://www.github.com/ZL-Asica/FFmpeg-One-Click-Installer"
BASE_URL="https://raw.githubusercontent.com/ZL-Asica/FFmpeg-One-Click-Installer/main"

# check download tool
if command -v curl &>/dev/null; then
    DOWNLOAD_TOOL="curl -sSL"
elif command -v wget &>/dev/null; then
    DOWNLOAD_TOOL="wget -qO-"
else
    echo -e "${red}Error: curl or wget is required to proceed. Please install one of them.${plain}"
    exit 1
fi

# languages.sh file
LANGUAGES_FILE=${BASE_URL}/languages.sh
$DOWNLOAD_TOOL $LANGUAGES_FILE > /tmp/languages.sh || {
    echo -e "${red}Error: Failed to download languages.sh. Check your internet connection.${plain}"
    exit 1
}
source /tmp/languages.sh || {
    echo -e "${red}Error: Failed to load languages.${plain}"
    exit 1
}
trap "rm -f /tmp/languages.sh" EXIT

# Function to display error messages and exit
error_exit() {
    local msg_key="$1"
    echo -e "${red}${messages[${lang}_$msg_key]}${plain}" >&2
    echo -e "${red}${messages[${lang}_exiting]}${plain}" >&2
    exit 1
}

# Function to handle package manager operations
# $1: action (install, remove, update)
# $2: package name
package_manager() {
    if [[ -z "$pkg_manager" ]]; then
        error_exit "error_pkg_manager_not_detected"
    fi

    local action="$1"
    shift
    local packages="$*"

    if [[ "$pkg_manager" == "apt" ]]; then
        sudo apt "$action" $packages -y || error_exit "error_${action}_$packages"
    elif [[ "$pkg_manager" == "yum" ]]; then
        sudo yum "$action" $packages -y || error_exit "error_${action}_$packages"
    else
        error_exit "error_unsupported_package_manager"
    fi
}

# Detect system version and architecture
detect_system() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        error_exit "macOS is not supported, please use Homebrew to install FFmpeg."
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        release="$ID"
    else
        error_exit "error_unsupported"
    fi

    arch=$(uname -m)
    if [[ "$arch" != "x86_64" && "$arch" != "aarch64" && "$arch" != "arm64" ]]; then
        error_exit "error_unsupported"
    fi

    # Check package manager
    if command -v apt &>/dev/null; then
        pkg_manager="apt"
        install_cmd="sudo apt install -y"
    elif command -v yum &>/dev/null; then
        pkg_manager="yum"
        install_cmd="sudo yum install -y"
    else
        error_exit "error_unsupported"
    fi

    echo -e "\n${blue}${messages[${lang}_detected_system]} $release $VERSION_ID ($arch)\n${plain}"
}

# Function to install FFmpeg using package manager
install_ffmpeg_package() {
    echo -e "${cyan}${messages[${lang}_qinstall_ffmpeg]}${plain}"

    # Update package lists
    echo -e "${cyan}Updating package lists...${plain}"
    if ! package_manager "update" ""; then
        echo -e "${red}Failed to update package lists. Please check your network or repository settings.${plain}"
        exit 1
    fi

    # Handle yum-specific dependencies
    if [[ "$pkg_manager" == "yum" ]]; then
        echo -e "${cyan}Installing EPEL release...${plain}"
        if ! package_manager "install" "epel-release"; then
            echo -e "${red}Failed to install EPEL release. Please check your network or repository settings.${plain}"
            exit 1
        fi

        echo -e "${cyan}Installing RPM Fusion repository...${plain}"
        if ! package_manager "install" "https://download1.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm"; then
            echo -e "${red}Failed to install RPM Fusion repository. Please check your network or repository settings.${plain}"
            exit 1
        fi
    fi

    # Install FFmpeg
    echo -e "${cyan}Installing FFmpeg...${plain}"
    if ! package_manager "install" "ffmpeg"; then
        echo -e "${red}Failed to install FFmpeg. Please check your repository settings or try source compilation.${plain}"
        exit 1
    fi

    # Validate FFmpeg installation
    if ! command -v ffmpeg &>/dev/null; then
        echo -e "${red}${messages[${lang}_installation_failed]}${plain}"
        exit 1
    fi

    echo -e "${green}${messages[${lang}_ffmpeg_installed]}${plain}"
}


# Install dependencies for compiling FFmpeg from source
install_dependencies() {
    echo -e "${cyan}${messages[${lang}_install_dependencies]}${plain}"
    package_manager "update" ""
    package_manager "install" "build-essential nasm yasm libx264-dev libx265-dev libfdk-aac-dev libvpx-dev libopus-dev"
}

# Compile FFmpeg from source
compile_ffmpeg() {
    echo -e "${green}${messages[${lang}_compiling_ffmpeg]}${plain}"
    cd /usr/local/src || error_exit "error_cd_failed"
    rm -rf ffmpeg

    # Clone source code
    echo -e "${cyan}Cloning FFmpeg source code...${plain}"
    if ! git clone --depth 1 https://git.ffmpeg.org/ffmpeg.git ffmpeg; then
        error_exit "error_clone_failed"
    fi

    cd ffmpeg || error_exit "error_cd_failed"

    # Configure FFmpeg
    echo -e "${cyan}Configuring FFmpeg...${plain}"
    if ! ./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libfdk-aac --enable-libvpx --enable-libopus --enable-nonfree; then
        error_exit "error_configure_failed"
    fi

    # Compile and install
    echo -e "${cyan}Compiling FFmpeg...${plain}"
    if ! make -j"$(nproc)"; then
        error_exit "error_make_failed"
    fi

    echo -e "${cyan}Installing FFmpeg...${plain}"
    if ! sudo make install; then
        error_exit "error_install_failed"
    fi

    # Clean up source
    echo -e "${cyan}Cleaning up FFmpeg source...${plain}"
    cd .. && rm -rf ffmpeg
    echo -e "${green}FFmpeg compiled and installed successfully.${plain}"
}

# Clean up unnecessary files and packages
clean_up() {
    echo "${messages[${lang}_cleaning_up]}"
    if [[ "$pkg_manager" == "yum" ]]; then
        package_manager "remove" "epel-release"
        yum groupremove "Development Tools" -y || echo -e "${red}Failed to remove Development Tools.${plain}"
    elif [[ "$pkg_manager" == "apt" ]]; then
        package_manager "remove" "build-essential"
    fi
}

# Check if FFmpeg is already installed and its version
remove_existing_ffmpeg() {
    if command -v ffmpeg &>/dev/null; then
        local installed_version
        installed_version=$(ffmpeg -version | head -n1 | grep -oP '(?<=ffmpeg version )[^ ]+')

        echo -e "${blue}Found FFmpeg version: ${installed_version}${plain}"
        read -p "${green}${messages[${lang}_pre_install_ask_update]}${plain}" update_choice
        update_choice=${update_choice:-n}

        if [[ $update_choice =~ ^[Yy]$ ]]; then
            echo -e "${cyan}Removing existing FFmpeg version...${plain}"

            package_manager "remove" "ffmpeg"
            [[ "$pkg_manager" == "yum" ]] && package_manager "remove" "ffmpeg-devel"

            # Remove FFmpeg binary files
            for path in /usr/local/bin/ffmpeg /usr/bin/ffmpeg; do
                if [ -f "$path" ]; then
                    sudo rm -f "$path" || echo -e "${red}Failed to remove: $path${plain}"
                    echo -e "${blue}Removed: $path${plain}"
                fi
            done

            echo -e "${green}Existing FFmpeg removed successfully.${plain}"
        else
            echo -e "${red}${messages[${lang}_pre_install_not_update]}${plain}"
            exit 0
        fi
    fi
}



main() {
    detect_system
    
    # Check if FFmpeg is already installed and ask the user if they want to update it
    remove_existing_ffmpeg

    if [[ "$pkg_manager" == "yum" ]]; then
        # For CentOS/RHEL/Fedora, confirm installation before proceeding
        echo -e "${cyan}${messages[${lang}_pre_install_yum]}${plain}"
        read -p "${green}${messages[${lang}_pre_install_yum_ask]}(y/n): ${plain}" confirm_install
        confirm_install=${confirm_install:-n}

        if [[ $confirm_install =~ ^[Yy]$ ]]; then
            install_ffmpeg_package
        else
            echo -e "${blue}${messages[${lang}_cancelled]}${plain}"
            exit 0
        fi
    else
        # For other systems, allow user to choose installation method
        echo -e "${green}${messages[${lang}_pre_install]}${plain}"
        read -p "${green}${messages[${lang}_pre_install_method]}${plain}" method
        method=${method:-1}

        case $method in
            1)
                install_ffmpeg_package
                ;;
            2)
                install_dependencies && compile_ffmpeg
                ;;
            *)
                echo -e "${red}${messages[${lang}_invalid_option]}${plain}"
                exit 1
                ;;
        esac
        clean_up
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
echo -e "${pink}FFmpeg One Click Installer （FFmpeg一键安装）- Linux${plain}"
echo -e "${pink}Author: ZL Asica${plain}"
echo -e "${pink}GitHub: ${REPO_URL}${plain}"

select_language
# Start the installation process
main
