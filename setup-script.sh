#!/bin/bash

WORKING_DIR=$(pwd)

main() {
    echo "==================== START OF SCRIPT ===================="
    echo ""
    
    apt_update_utils
    programs_cmus
    programs_node_js
    programs_pandoc
    programs_python3
    programs_todo
    programs_unix_pass
    programs_vim
    programs_youtube_dl
    programs_zsh
    programs_manual

    echo ""
    echo "==================== END OF SCRIPT ===================="
}

apt_update_utils() {
    echo ">>> [APT and utils] Configuration started..."

    echo ">>> [APT and utils] Updating apt, cache, and install upgrades..."
    apt update -y && apt upgrade -y
    apt install git wget build-essential htop -y
    
    echo ">>> [APT and utils] Setting Git variables..."
    git config --global user.email "johnnymatthews@protonmail.com"
    git config --global user.name "johnnymatthews"

    echo ">>> [APT and utils] Creating SSH keypair..."
    ssh-keygen -t rsa -b 4096 -C "johnnymatthews@protonmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
    echo ">>> [APT and utils] Copying config files..."
    cp ./bashrc ~/.bashrc
    cp ./hyper.js ~/.hyper.js
    cp ./vimrc ~/.vimrc
    cp ./zshrc ~/.zshrc

    echo ">>> [APT and utils] Removing Nano..."
    apt remove nano -y

    echo ">>> [APT and utils] Configuration complete."
}

programs_cmus() {
    echo ">>> [Cmus] Install started..."

    echo ">>> [Cmus] Installing Cmus..."
    apt install cmus -y

    echo ">>> [Cmus] Creating Cmus update script..."
    mkdir -p ~/.config/cmus
    echo "$cmus_update_script" > ~/.config/cmus/update-library.sh
    chmod +x ~/.config/cmus/update-library.sh

    echo ">>> [Cmus] Binding update script to U key..."
    cmus-remote --raw ":bind -f common u shell ~/.config/cmus/update-library.sh"

    echo ">>> [Cmus] Install complete."
}

programs_hyper() {
    echo ">>> [Hyper] Install started..."

    echo ">>> [Hyper] Downloading Hyper..."
    wget -O hyper.deb https://releases.hyper.is/download/deb

    echo ">>> [Hyper] Installing Hyper..."
    apt install ./hyper.deb -y

    echo ">>> [Hyper] Removing .deb file..."
    rm ./hyper.deb

    echo ">>> [Hyper] Install complete."
}

programs_node_js() {
	echo ">>> [Node.js] Install started..."

	echo ">>> [Node.js] Installing Node.js and NPM"
	apt install nodejs npm -y

	echo ">>> [Node.js] Install complete."
}

programs_pandoc() {
    echo ">>> [Pandoc] Install started..."

    echo ">>> [Pandoc] Installing Pandoc and WKHTMLtoPDF..."
    apt install pandoc wkhtmltopdf  -y
    
    echo ">>> [Pandoc] Install complete."
}

programs_python3() {
    echo ">>> [Python3] Install started..."

    echo ">>> [Python3] Installing Python3..."
    apt-get install python-is-python3 -y

    echo ">>> [Python3] Removing Python2..."
    apt-get autoremove --purge

    echo ">>> [Python3] Install complete."
}

programs_todo() {
    echo ">>> [Todo-txt] Install started..."

    echo ">>> [Todo-txt] Download todo-txt..."
    wget https://github.com/todotxt/todo.txt-cli/releases/download/v2.12.0/todo.txt_cli-2.12.0.tar.gz
    tar xvzf todo.txt_cli-2.12.0.tar.gz
    rm todo.txt_cli-2.12.0.tar.gz

    echo ">>> [Todo-txt] Move executable to /usr/local/bin/"
    cd todo.txt_cli-2.12.0
    cp todo.sh /usr/local/bin
     
    
    echo ">>> [Todo-txt] Install complete."
}

programs_unix_pass() {
    echo ">>> [Unix Pass] Install started..."

    echo ">>> [Unix Pass] Installing Unix Pass..."
    apt install pass -y

    echo ">>> [Unix Pass] Installing Pass OTP..."
    apt install pass-extension-otp oathtool zbar-tools -y

    echo ">>> [Unix Pass] Installing Pass Update..."
    git clone https://github.com/roddhjav/pass-update/ ~/Downloads/pass-update
    cd ~/Downloads/pass-update
    make install
    cd $WORKING_DIR

    echo ">>> [Unix Pass] Install complete."
}

programs_vim() {
    echo ">>> [Vim] Install started..."

    echo ">>> [Vim] Installing Vim..."
    apt install vim -y
    
    echo ">>> [Vim] Install complete."
}

programs_youtube_dl() {
    echo ">>> [Youtube-dl] Install started..."

    curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    chmod a+rx /usr/local/bin/youtube-dl

    echo ">>> [Youtube-dl] Install complete."
}

programs_zsh() {
    echo ">>> [Zsh] Install started..."

    echo ">>> [Zsh] Installing Zsh..."
    apt install zsh

    echo ">>> [Zsh] Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo ">>> [Zsh] Install complete."
}

programs_manual() {
    echo "---------- Programs to manually install ----------
These programs have to be installed manually, unfortunately. This function just echos out the steps for each program.
--------------------------------------------------
    [Zoom]
        1. Download the latest installer from the [Zoom releases page](https://zoom.us/download?os=linux).
        2. Install Zoom using: sudo apt install ~/Download/zoom_amd64.deb
        3. Edit ~/.config/zoomus.conf and change autoScale=true to false.
        4. Done!
        "
}

# Large variables.

read -r -d '' cmus_update_script << EOM
#!/bin/bash
cmus-remote -C clear
cmus-remote -C "add ~/Music"
cmus-remote -C "update-cache -f"
EOM

