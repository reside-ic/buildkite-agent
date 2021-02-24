# buildkite-agent

Buildkite agent setup

This is archived as we've now switched to buildkite agents hosted on windows server. Setup can be found in [reside-hyperv-scripts](https://github.com/reside-ic/reside-hyperv-scripts) repo.


## Setup

You will need to have installed
* Packer - see https://packer.io/intro/getting-started/install.html
* Virtualbox - see [vimc/montagu-machine](https://github.com/vimc/montagu-machine/blob/master/provision/setup-vagrant)
* vagrant - see [vimc/montagu-machine](https://github.com/vimc/montagu-machine/blob/master/provision/setup-vagrant)
* vagrant-vbguest `vagrant plugin install vagrant-vbguest`

## Build

Build image using

`packer build packer-config.json`

This outputs vagrant box file to `builds/virtualbox-ubuntu1804.box`

Run up the VM using

`vagrant up`

If the box image is replaced with a new build, remember to remove the imported box with `vagrant destroy && vagrant box remove builds/virtualbox-ubuntu1804.box`

To build in development mode `packer build -on-error=ask packer-config.json` this will rollback build process to last successful step. You can then make changes to e.g. the scripts and try and run from that point again, essentially skipping the OS install step saving some time during development.

## Useful commands

* See status of agent - `sudo systemctl status buildkite-agent`

* See agent logs - `journalctl -f -u buildkite-agent`

* Stop a running agent - send stop signal from the buildkite website or destroy vagrant

* Print logs to screen on packer build `PACKER_LOG=1 packer build packer-config.json`
