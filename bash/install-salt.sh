#! /usr/bin/env bash
sudo add-apt-repository ppa:saltstack/salt
sudo apt-get update
sudo apt-get install salt-master salt-minion salt-ssh salt-cloud salt-doc
curl -L https://bootstrap.saltstack.com -o install_salt.sh
less ~/install_salt.sh
sudo sh install_salt.sh -P -M
curl -L https://bootstrap.saltstack.com -o install_salt.sh
less ~/install_salt.sh
sudo sh install_salt.sh -P -M git develop

