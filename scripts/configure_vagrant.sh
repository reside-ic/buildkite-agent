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
DOCKER_USERNAME=`vault read -field=username /secret/docker`
vault read -field=password /secret/docker | \
  docker login -u $DOCKER_USERNAME --passwird-stdin



## Read buildkite agent stuff from vault and write into 
BUILDKITE_AGENT_TOKEN=`vault read -field=token /secret/buildkite/agent`
sed -i "s/xxx/${BUILDKITE_AGENT_TOKEN}/g" /etc/buildkite-agent/buildkite-agent.cfg

## Startup agent

sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent