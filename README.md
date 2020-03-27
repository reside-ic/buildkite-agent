# buildkite-agent

Buildkite agent setup

## Build

Build image using

`packer build packer-config.json`

This outputs vagrant box file to `builds/virtualbox-ubuntu1804.box`

Run up the VM using

`vagrant up`

If the box image is replaced with a new build, remember to remove the imported box with `vagrant destroy && vagrant box remove builds/virtualbox-ubuntu1804.box`

To build in development mode `packer build -on-error=ask packer-config.json` this will rollback build process to last successful step. You can then make changes to e.g. the scripts and try and run from that point again, essentially skipping the OS install step saving some time during development.

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


## Useful commands

* See status of agent - `sudo systemctl status buildkite-agent`

* See agent logs - `journalctl -f -u buildkite-agent`

* Stop a running agent - send stop signal from the buildkite website

* Print logs to screen on packer build `PACKER_LOG=1 packer build packer-config.json`