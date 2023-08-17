#!/bin/bash

echo "Initial setup.  This may take a few minutes ..."
apt-get update

apt-get install -y build-essential \
				   ca-certificates \
			       curl \
			       gnupg \
			       lsb-release

echo "Installing python..."
apt-get install -y python3 python3-venv python3-dev libpq-dev
pip install --upgrade pip
pip install wheel


echo "The environment has been installed."
echo
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo
exit 0