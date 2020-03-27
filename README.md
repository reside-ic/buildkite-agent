# buildkite-agent

Buildkite agent setup

## Build

Build image using

`packer build packer-config.json`

This outputs vagrant box file to `builds/virtualbox-ubuntu1804.box`

Run up the VM using

`vagrant up`

If the box image is replaced with a new build, remember to remove the imported box with `vagrant destroy && vagrant box remove builds/virtualbox-ubuntu1804.box`