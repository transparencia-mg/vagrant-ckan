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
# Install inside virtual environment
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
# CKAN clone installation
git clone https://github.com/ckan/ckan.git ckan_source
cd ckan_source/
git checkout ckan-2.10.1
pip install -r requirements.txt
python setup.py install
# CKAN config file
sudo mkdir -p /etc/ckan/default
sudo chown -R `whoami` /etc/ckan/
ckan generate config /etc/ckan/default/ckan.ini

echo "-----------------------------------------------"
echo "Postgres configuration."
echo "-----------------------------------------------"
sudo service postgresql start
sudo -u postgres psql -c "CREATE USER ckan_default WITH PASSWORD 'ckan_default';"
sudo -u postgres psql -c "CREATE DATABASE ckan_default WITH OWNER = 'ckan_default' ENCODING 'utf-8'"

echo "-----------------------------------------------"
echo "Setup solr."
echo "-----------------------------------------------"
wget https://www.apache.org/dyn/closer.lua/solr/solr/9.1.0/solr-9.1.0.tgz?action=download
tar -xvzf 'solr-9.1.0.tgz?action=download'
./solr-9.1.0/bin/solr start
./solr-9.1.0/bin/solr create -c ckan
# Test if it's running
wget http://localhost:8983/solr
cp /home/vagrant/ckan_source/ckan/config/solr/schema.xml solr-9.1.0/server/solr/ckan/conf/managed-schema.xml

echo "-----------------------------------------------"
echo "Start redis."
echo "-----------------------------------------------"
sudo service redis-server start

echo "-----------------------------------------------"
echo "Configure db on ckan.ini and create tables."
echo "-----------------------------------------------"
ckanFile=/etc/ckan/default/ckan.ini
lineNumber=$(grep --line-number "sqlalchemy.url" $ckanFile  | cut -f1 -d:)
replacedLine="sqlalchemy.url = postgresql://ckan_default:ckan_default@localhost/ckan_default"
replacedLine=${replacedLine//\//\\\/}
sed -i $lineNumber's/.*/'"$replacedLine"'/'  $ckanFile
ckan -c /etc/ckan/default/ckan.ini db init

echo "-----------------------------------------------"
echo "The environment has been installed."
echo "-----------------------------------------------"
echo
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo
exit 0
