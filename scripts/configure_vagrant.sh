#!/usr/bin/env bash

if [ -z $VAULT_ADDR ]; then
    echo "Set vault address env var"
    exit 1
fi

if [ -z $VAULT_TOKEN ]; then
    echo "Set vault address env var"
    exit 1
fi

## Login to vault with token
vault login

## Read docker info from vault


## Read buildkite agent stuff from vault and write into 
sed -i "s/xxx/  /g" /etc/buildkite-agent/buildkite-agent.cfg

## Startup agent

sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent