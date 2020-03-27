#!/bin/bash -eux

apt-get -y update && apt-get -y upgrade

apt-get -y install curl
apt-get -y install software-properties-common

apt-get -y update