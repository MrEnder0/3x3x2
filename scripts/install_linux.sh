if [ -x "$(command -v apt-get)" ]; then
    echo "Package manager identified as apt-get. You may have to enter sudo password or enter su mode to continue. Also you may be prompted with a message from choosenim put either y or n."
    PACKAGE_MANAGER="apt-get"
elif [ -x "$(command -v pacman)" ]; then
    echo "Package manager identified as pacman. You may have to enter sudo password or enter su mode to continue. Also you may be prompted with a message from choosenim put either y or n."
    PACKAGE_MANAGER="pacman"
elif [ -x "$(command -v apk)" ]; then
    echo "Package manager identified as apk. You may have to enter sudo password or enter su mode to continue. Also you may be prompted with a message from choosenim put either y or n."
    PACKAGE_MANAGER="apk"
else
    echo "We cant identify your package manager, we currently support apt and pacman package managers, if your system does use one of these please report this bug."
    exit 1
fi

if [[ $PACKAGE_MANAGER == "apt" ]]; then
    sudo apt update
    sudo apt install git

    echo "Installing Nim... (0/5)"
    curl https://nim-lang.org/choosenim/init.sh -o choosenim
    chmod +x choosenim
    ./choosenim
    export PATH=/home/$USER/.nimble/bin:$PATH

    echo "Installing dependencies... (1/5)"
    nimble install docopt -y
    nimble install yaml -y

    echo "Compiling Grid9... (2/5)"
    git clone https://github.com/MrEnder0/Grid9
    cd Grid9/src
    mv main.nim grid9.nim
    nim c -d:release grid9

    echo "Installing Grid9... (3/5)"
    sudo chmod 777 grid9
    sudo mv grid9 /usr/bin/
    sudo mkdir /usr/share/Grid9/

    echo "Installing Examples... (4/5)"
    sudo mkdir /usr/share/Grid9/examples
    cd examples
    sudo mv -- * /usr/share/Grid9/examples
    cd ..

    echo "Installing documentation... (5/5)"
    sudo mkdir /usr/share/Grid9/documentation
    cd documentation
    sudo mv -- * /usr/share/Grid9/documentation
    cd ..

elif [[ $PACKAGE_MANAGER == "pacman" ]]; then
    sudo pacman -Syyu
    sudo pacman -S git

    echo "Installing Nim... (0/5)"
    curl https://nim-lang.org/choosenim/init.sh -o choosenim
    chmod +x choosenim
    ./choosenim
    export PATH=/home/$USER/.nimble/bin:$PATH

    echo "Installing dependencies... (1/5)"
    nimble install docopt -y
    nimble install yaml -y

    echo "Compiling Grid9... (2/5)"
    git clone https://github.com/MrEnder0/Grid9
    cd Grid9/src
    mv main.nim grid9.nim
    nim c -d:release grid9

    echo "Installing Grid9... (3/5)"
    sudo chmod 777 grid9
    sudo mv grid9 /usr/bin/
    sudo mkdir /usr/share/Grid9/

    echo "Installing Examples... (4/5)"
    sudo mkdir /usr/share/Grid9/examples
    cd examples
    sudo mv -- * /usr/share/Grid9/examples
    cd ..

    echo "Installing documentation... (5/5)"
    sudo mkdir /usr/share/Grid9/documentation
    cd documentation
    sudo mv -- * /usr/share/Grid9/documentation
    cd ..

elif [[ $PACKAGE_MANAGER == "apk" ]]; then
    apk update
    apk add git

    echo "Installing Nim... (0/5)"
    apk add nim
    apk add nimble

    echo "Installing dependencies... (1/5)"
    nimble install docopt -y
    nimble install yaml -y

    echo "Compiling Grid9... (2/5)"
    git clone https://github.com/MrEnder0/Grid9
    cd Grid9/src
    mv main.nim grid9.nim
    nim c -d:release grid9

    echo "Installing Grid9... (3/5)"
    chmod 777 grid9
    mv grid9 /usr/bin/
    mkdir /usr/share/Grid9/

    echo "Installing Examples... (4/5)"
    mkdir /usr/share/Grid9/examples
    cd examples
    mv -- * /usr/share/Grid9/examples
    cd ..

    echo "Installing documentation... (5/5)"
    mkdir /usr/share/Grid9/documentation
    cd documentation
    mv -- * /usr/share/Grid9/documentation
    cd ..
fi
echo "Installation complete!"
