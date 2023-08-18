#!/bin/bash

echo "Initial setup.  This may take a few minutes ..."

echo "Installing linux packages."
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

echo "Java update"
sudo apt-get update
sudo apt-get install -y default-jdk
sudo apt-get update
sudo apt-get install -y default-jre

echo "The environment has been installed."
echo
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo
exit 0
