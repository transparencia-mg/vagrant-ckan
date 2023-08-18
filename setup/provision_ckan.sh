#!/bin/bash

echo "-----------------------------------------------"
echo "Initial setup.  This may take a few minutes ..."
echo "-----------------------------------------------"

echo "-----------------------------------------------"
echo "Installing linux packages."
echo "-----------------------------------------------"
sudo apt-get update
sudo apt-get install -y python3-dev \
                   postgresql \
                   libpq-dev \
                   python3-pip \
                   python3-venv \
                   git-core \
                   openjdk-8-jdk \
                   redis-server \
                   graphviz

echo "-----------------------------------------------"
echo "Java update."
echo "-----------------------------------------------"
sudo apt-get update
sudo apt-get install -y default-jdk
sudo apt-get update
sudo apt-get install -y default-jre

echo "-----------------------------------------------"
echo "Install CKAN into a Python virtual environment."
echo "-----------------------------------------------"
mkdir -p ~/ckan/lib
sudo ln -s ~/ckan/lib /usr/lib/ckan
mkdir -p ~/ckan/etc
sudo ln -s ~/ckan/etc /etc/ckan
sudo mkdir -p /usr/lib/ckan/default
sudo chown `whoami` /usr/lib/ckan/default
python3 -m venv /usr/lib/ckan/default
. /usr/lib/ckan/default/bin/activate
pip install setuptools==44.1.0
pip install --upgrade pip
git clone https://github.com/ckan/ckan.git ckan_source
cd ckan_source/
git checkout ckan-2.10.1
pip install -r requirements.txt
python setup.py install

echo "The environment has been installed."
echo
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo
exit 0
