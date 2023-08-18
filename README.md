# Installing CKAN using Vagrant

Installing CKAN instances on the Windows operating system can encounter various errors.
The [documentation](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html#environment) for installation using `docker-compose` was performed/tested using an Ubuntu 16.04 LTS machine, with the use of virtual machines recommended in the same.

> This tutorial was tested on Ubuntu 16.04 LTS. The hosts can be local environments or cloud VMs. It is assumed that the user has direct access (via terminal / ssh) to the systems and root permissions.

In this context, this repository aims to facilitate the creation of a CKAN instances using Vagrant.

# Installation and Configuration

The system dependencies for this project are:

- [VirtualBox](https://www.virtualbox.org/).
- [Vagrant](https://www.vagrantup.com/)[^1].
- [vagrant-env](https://github.com/gosuri/vagrant-env).
- In some cases [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf).

Install [vagrant-env](https://github.com/gosuri/vagrant-env)

```shell
vagrant plugin install vagrant-env
```

If your internet access is via proxy, install the `vagrant-proxyconf` plugin:

```bash
$ vagrant plugin install vagrant-proxyconf
```

Create the environment variables `VAGRANT_HTTP_PROXY` and `VAGRANT_HTTPS_PROXY` with the value `http://<user>:<password>@<host>:<port>` (replace the variables within `<>` with your specific values).
Also, make sure that the environment variables `http_proxy` and `https_proxy` are created with the same value of `http://<user>:<password>@<host>:<port>`.
While the former enables connectivity to the VM, the latter enables connectivity for Vagrant itself.

After that, clone the repository and execute the initialization:

```bash
$ git clone git@github.com:transparencia-mg/vagrant-ckan.git
$ cd vagrant-ckan
$ vagrant up
```

If any improvements are made to the `Vagrantfile` or `setup/provision_chan.sh` files, you need to run `vagrant up --provision` to update the already created machine using `vagrant up`.

The first execution takes a few minutes. You can log into the `ckan` virtual machine using `vagrant ssh ckan`.

# Vagrant Commands:

echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"

[^1]: [This post](https://my-base-knowledge.braico.me/1.0.0/texts/20230818_how_to_install_vagrant/?h=vagran) explains how to install vagrant and virtualbox on linux operating systems.
