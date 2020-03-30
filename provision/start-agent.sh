#!/usr/bin/env bash
set -e

## Login to vault with token
vault login -method=github

## Read docker info from vault and login
DOCKER_USERNAME=`vault read -field=username secret/vimc-robot/dockerhub`
vault read -field=password secret/vimc-robot/dockerhub | \
  sudo -u buildkite-agent -H docker login -u $DOCKER_USERNAME --password-stdin

## Read buildkite agent token from vault and write into cfg
BUILDKITE_AGENT_TOKEN=`vault read -field=token secret/buildkite/agent`
sudo sed -i "s/xxx/${BUILDKITE_AGENT_TOKEN}/g" /etc/buildkite-agent/buildkite-agent.cfg

## Startup agent
sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent