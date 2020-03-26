
#!/usr/bin/env bash
set -e

## Setup vault
## need to read buildkite agent token from vault

## Setup as an agent
echo "deb https://apt.buildkite.com/buildkite-agent stable main" | sudo tee /etc/apt/sources.list.d/buildkite-agent.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198
sudo apt-get update && sudo apt-get install -y buildkite-agent
 sed -i "s/xxx/INSERT-YOUR-AGENT-TOKEN-HERE/g" /etc/buildkite-agent/buildkite-agent.cfg


## Make sure docker available

## Add buildkite-agent to docker group

sudo usermod -aG docker buildkite-agent

## login docker?

## Make sure vault available

## Start the agent

sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent
