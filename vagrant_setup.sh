#!/bin/bash

# Updates
apt-get -y update
apt-get -y upgrade

# CTF-Platform Dependencies
apt-get -y install python3-pip
apt-get -y install tmux

# Install Binjitsu
apt-get install python2.7 python-pip python-dev git
pip install --upgrade git+https://github.com/binjitsu/binjitsu.git

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
pip install pycparser # Use pip3 for Python3

# Personal config
cd ~
git clone https://github.com/thebarbershopper/environment

# Configure Environment
echo 'PATH=$PATH:/home/vagrant/scripts' >> /etc/profile
