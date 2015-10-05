#!/bin/bash

# Updates
# apt-get -y update
# apt-get -y upgrade

apt-get -y install python3-pip
apt-get -y install tmux
apt-get -y install gdb gdb-multiarch
apt-get -y install unzip
apt-get -y install foremost

# QEMU with MIPS/ARM - http://reverseengineering.stackexchange.com/questions/8829/cross-debugging-for-mips-elf-with-qemu-toolchain
apt-get -y install qemu qemu-user qemu-user-static
apt-get -y install 'binfmt*'
apt-get -y install libc6-armhf-armel-cross
apt-get -y install debian-keyring
apt-get -y install debian-archive-keyring
apt-get -y install emdebian-archive-keyring
tee /etc/apt/sources.list.d/emdebian.list << EOF
deb http://mirrors.mit.edu/debian squeeze main
deb http://www.emdebian.org/debian squeeze main
EOF
apt-get -y install libc6-mipsel-cross
apt-get -y install libc6-arm-cross
mkdir /etc/qemu-binfmt
ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel 
ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm
rm /etc/apt/sources.list.d/emdebian.list
# apt-get update

# Install Binjitsu
apt-get -y install python2.7 python-pip python-dev git
pip install --upgrade git+https://github.com/binjitsu/binjitsu.git

mkdir tools
cd tools

# Install pwndbg
git clone https://github.com/zachriggle/pwndbg
echo "source $PWD/pwndbg/gdbinit.py" >> ~/.gdbinit

# Capstone for pwndbg
git clone https://github.com/aquynh/capstone
cd capstone
git checkout -t origin/next
sudo ./make.sh install
cd bindings/python
sudo python3 setup.py install # Ubuntu 14.04+, GDB uses Python3

# pycparser for pwndbg
pip3 install pycparser # Use pip3 for Python3

# Install radare2
git clone https://github.com/radare/radare2
cd radare2
./sys/install.sh

# Install binwalk
cd /home/vagrant/tools
git clone https://github.com/devttys0/binwalk
cd binwalk
sudo python setup.py install

# Install Firmware-Mod-Kit
apt-get -y install git build-essential zlib1g-dev liblzma-dev python-magic
cd /home/vagrant/tools
wget https://firmware-mod-kit.googlecode.com/files/fmk_099.tar.gz
tar xvf fmk_099.tar.gz
rm fmk_099.tar.gz
cd fmk_099/src
./configure
make

# Personal config
cd /home/vagrant/tools
git clone https://github.com/thebarbershopper/environment
cd environment
cp -r . /home/vagrant

# Uninstall capstone
sudo pip2 uninstall capstone -y

# Install correct capstone
cd /home/vagrant/tools/capstone/bindings/python
sudo python setup.py install
