#!/bin/bash

echo "-----------------------------------------------"
echo "Initial setup.  This may take a few minutes ..."
echo "-----------------------------------------------"

echo "-----------------------------------------------"
echo "Install the required packages."
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
pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.10.1#egg=ckan[requirements]'
deactivate
. /usr/lib/ckan/default/bin/activate

echo "-----------------------------------------------"
echo "Setup a PostgreSQL database."
echo "-----------------------------------------------"
sudo service postgresql start
sudo -u postgres psql -c "CREATE USER ckan_default WITH PASSWORD 'ckan_default';"
sudo -u postgres psql -c "CREATE DATABASE ckan_default WITH OWNER = 'ckan_default' ENCODING 'utf-8'"
sudo -u postgres psql -l

echo "-----------------------------------------------"
echo "Create a CKAN config file."
echo "-----------------------------------------------"
sudo mkdir -p /etc/ckan/default
sudo chown -R `whoami` /etc/ckan/
ckan generate config /etc/ckan/default/ckan.ini
# ckan.ini configuration
ckanFile=/etc/ckan/default/ckan.ini
# Change sqlalchemy.ur
lineNumber=$(grep --line-number "sqlalchemy.url" $ckanFile  | cut -f1 -d:)
replacedLine="sqlalchemy.url = postgresql://ckan_default:ckan_default@localhost/ckan_default"
replacedLine=${replacedLine//\//\\\/}
sed -i $lineNumber's/.*/'"$replacedLine"'/' $ckanFile
# solr_url
lineNumber=$(grep --line-number "solr_url" $ckanFile  | cut -f1 -d:)
replacedLine="solr_url = http://127.0.0.1:8983/solr/ckan/"
replacedLine=${replacedLine//\//\\\/}
sudo sed -i $lineNumber's/.*/'"$replacedLine"'/' $ckanFile


echo "-----------------------------------------------"
echo "Install and Setup solr."
echo "-----------------------------------------------"
sudo wget https://www.apache.org/dyn/closer.lua/lucene/solr/8.11.2/solr-8.11.2.tgz?action=download
sudo mv solr-8.11.2.tgz\?action\=download solr-8.11.2.tgz
sudo tar xzf solr-8.11.2.tgz solr-8.11.2/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-8.11.2.tgz
sudo service solr status
sudo -u solr /opt/solr/bin/solr create -c ckan
sudo -u solr wget -O /var/solr/data/ckan/conf/managed-schema https://raw.githubusercontent.com/ckan/ckan/dev-v2.10/ckan/config/solr/schema.xml
sudo service solr restart
wget http://localhost:8983/solr


echo "-----------------------------------------------"
echo "Start redis."
echo "-----------------------------------------------"
sudo service redis-server start

echo "-----------------------------------------------"
echo "Create database tables."
echo "-----------------------------------------------"
cd /usr/lib/ckan/default/src/ckan
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
