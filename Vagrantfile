# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # enable vagrant-env plugin
  # install with `vagrant plugin install vagrant-env`
  config.env.enable

  config.vm.define "ckan" do |ckan|
    ckan.vm.box = "ubuntu/focal64"
    ckan.vm.provision "shell", privileged: false, path: "setup/provision_ckan.sh", env: {VAGRANT_HTTP_PROXY:ENV['VAGRANT_HTTP_PROXY'], VAGRANT_HTTPS_PROXY:ENV['VAGRANT_HTTPS_PROXY']}
    ckan.vm.provision "shell", inline: 'echo ". /usr/lib/ckan/default/bin/activate && cd ~/" > ~/.profile', privileged: false
  end

end
