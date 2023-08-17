# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # enable vagrant-env plugin
  # install with `vagrant plugin install vagrant-env`
  config.env.enable

  config.vm.define "ckan" do |ckan|
    ckan.vm.box = "ubuntu/bionic64"
    ckan.vm.provision "shell", path: "setup/provision_ckan.sh", env: {VAGRANT_HTTP_PROXY:ENV['VAGRANT_HTTP_PROXY'], VAGRANT_HTTPS_PROXY:ENV['VAGRANT_HTTPS_PROXY']}
  end

end
