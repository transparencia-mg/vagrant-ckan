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

echo "Installing docker"
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
docker --version

echo "Installing docker-compose"
apt-get install -y docker-compose
docker-compose --version

echo "Installing ckan"
git clone https://github.com/ckan/ckan.git
cp ckan/contrib/docker/.env.template ckan/contrib/docker/.env
cd ckan && git checkout tags/ckan-2.9.6 && cd contrib/docker && docker-compose up -d --build

echo "The environment has been installed."
echo
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo
exit 0