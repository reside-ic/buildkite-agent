#!/usr/bin/env bash
set -eu

## Login to vault with token
vault login -method=github

AS_AGENT="sudo -u buildkite-agent -H"

## Read docker info from vault and login
DOCKER_USERNAME=`vault read -field=username secret/vimc-robot/dockerhub`
vault read -field=password secret/vimc-robot/dockerhub | \
  $AS_AGENT docker login -u $DOCKER_USERNAME --password-stdin

## Read buildkite agent token from vault and write into cfg
BUILDKITE_AGENT_TOKEN=`vault read -field=token secret/buildkite/agent`
sudo sed -i "s/xxx/${BUILDKITE_AGENT_TOKEN}/g" /etc/buildkite-agent/buildkite-agent.cfg

# This is easier to do by
AGENT_SSH=~buildkite-agent/.ssh

mkdir -p $AGENT_SSH
vault read -field=public secret/vimc-robot/ssh > $AGENT_SSH/id_rsa.pub
vault read -field=private secret/vimc-robot/ssh > $AGENT_SSH/id_rsa
chmod 600 $AGENT_SSH/id_rsa
touch $AGENT_SSH/known_hosts
if ! grep -q '^github.com' $AGENT_SSH/known_hosts; then
    ssh-keyscan github.com >> $AGENT_SSH/known_hosts
fi

chown -R buildkite-agent.buildkite-agent $AGENT_SSH

# NOTE: this is a fake email address for our robot account:
$AS_AGENT git config --global user.email "rich.fitzjohn+vimc@gmail.com"
$AS_AGENT git config --global user.name "vimc-robot"
$AS_AGENT git config --global push.default simple

## Startup agent
sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent
