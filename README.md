# Instalando instância CKAN no Windows com Vagrant

Instalações de instâncias do CKAN em sistema operacional Windows podem apresentar diversos erros.
A própria [documentação](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html#environment) para instalação utilizando `docker-compose` foi realizada/testada utilizando-se máquina Ubuntu 16.04 LTS, sendo a utilização de máquinas virtuais recomendada na mesma.

> This tutorial was tested on Ubuntu 16.04 LTS. The hosts can be local environments or cloud VMs. It is assumed that the user has direct access (via terminal / ssh) to the systems and root permissions.

Neste sentido, este repositório tem como objetivo facilitar a criação de uma instância do CKAN utilizando-se:

- Vagrant e VirtualBox para criação da máquina virtual linux.
- Docker e Docker Compose para efetivar a instalação da instância CKAN na máquina virtual criada.

# Instalação e configuração

As dependências de sistema desse projeto são:

- [VirtualBox](https://www.virtualbox.org/); e
- [Vagrant](https://www.vagrantup.com/), [vagrant-env](https://github.com/gosuri/vagrant-env), e em alguns casos [vagrant-proxyconf](https://github.com/tmatilai/vagrant-proxyconf)

Se seu acesso à internet for via proxy instale o plugin `vagrant-proxyconf`:

```bash
$ vagrant plugin install vagrant-proxyconf
```

Crie as variáveis de ambiente `VAGRANT_HTTP_PROXY` `VAGRANT_HTTPS_PROXY` com o valor `http://<user>:<password>@<host>:<port>` (substituindo as variáveis entre `<>`). 
Certifique-se também que as variáveis `http_proxy` e `https_proxy` estão criadas com o mesmo valor (em caixa baixa). 
Enquanto as primeiras permitem conectividade para a VM, as últimas permitem conectividade para o próprio Vagrant.

Depois disso clone o repositório e execute a inicialização:

```bash
$ git clone https://github.com/transparencia-mg/vagrant-ckan.git
$ cd vagrant-ckan
$ vagrant up
```

Caso alguma melhoria seja incluída nos arquivos `Vagrantfile` ou `setup/provision_chan.sh` necessário rodar `vagrant up --provision` para atualizar a máquina já criada via `vagrant up`

A primeira execução demora alguns minutos. Você pode logar na máquina virtual `ckan` com `vagrant ssh ckan`

# Comandos Vagrant:

echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"

