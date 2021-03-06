#!/usr/bin/env bash
set -e
HERE=$(dirname $(dirname $(realpath $0)))
VAULT_CONFIG=$HERE/vault_config

export VMHOST_NAME=$(hostname)
export VAULT_ADDR='https://vault.dide.ic.ac.uk:8200'
if [ "$VAULT_AUTH_GITHUB_TOKEN" = "" ]; then
    echo -n "Please provide your GitHub personal access token for the vault: "
    read -s token
    echo ""
    export VAULT_AUTH_GITHUB_TOKEN=${token}
fi

echo "Writing vault token to $VAULT_CONFIG"
env | grep -E '^(VAULT_ADDR|VAULT_AUTH_GITHUB_TOKEN|VMHOST_NAME)' > $VAULT_CONFIG