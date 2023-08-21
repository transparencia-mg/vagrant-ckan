

#sudo mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak
#sudo ln -s /usr/lib/ckan/default/src/ckan/ckan/config/solr/schema.xml /etc/solr/conf/schema.xml
#sudo rm -rf /var/solr/data/ckan/conf/managed-schema
sudo cp /usr/lib/ckan/default/src/ckan/ckan/config/solr/schema.xml /var/solr/data/ckan/conf/managed-schema
chown -R solr:solr /var/solr
# Altera ckan.ini
ckanFile=/etc/ckan/default/ckan.ini
lineNumber=$(grep --line-number "solr_url" $ckanFile  | cut -f1 -d:)
replacedLine="solr_url = http://127.0.0.1:8983/solr/ckan/"
replacedLine=${replacedLine//\//\\\/}
sed -i $lineNumber's/.*/'"$replacedLine"'/'  $ckanFile

# wget https://www.apache.org/dyn/closer.lua/solr/solr/9.1.0/solr-9.1.0.tgz?action=download
# tar -xvzf 'solr-9.1.0.tgz?action=download'
# ./solr-9.1.0/bin/solr start
# ./solr-9.1.0/bin/solr create -c ckan
# # Test if it's running
# wget http://localhost:8983/solr
# cp /home/vagrant/ckan_source/ckan/config/solr/schema.xml solr-9.1.0/server/solr/ckan/conf/managed-schema.xml
