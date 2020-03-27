# buildkite-agent

Buildkite agent setup

## Build

Build image using

`packer build packer-config.json`

This outputs vagrant box file to `builds/virtualbox-ubuntu1804.box`

Run up the VM using

`vagrant up`

If the box image is replaced with a new build, remember to remove the imported box with `vagrant destroy && vagrant box remove builds/virtualbox-ubuntu1804.box`

## Setup VM

We need to add some further setup to the VM TODO: script it

* Add your agent-token, you can get this from buildkite via
```
sed -i "s/xxx/INSERT-YOUR-AGENT-TOKEN-HERE/g" /etc/buildkite-agent/buildkite-agent.cfg
```
* Login to docker & vault

* Start the agent
```
sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent
```