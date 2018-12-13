#!/bin/sh

# RethinkDB Linux Installation Script
#   by RethinkDB
#   Globalized by TRPGDA (Prixyn)


if [ -f /etc/lsb-release ]; then
  # Debian/Ubuntu
  if [[ $(cat /etc/issue) = *Ubuntu* ]]; then
    echo "⯈ Installing RethinkDB for Ubuntu"
    source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y rethinkdb
  else
    echo "⯈ Installing RethinkDB for Debian"
    echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y rethinkdb
  fi
elif cat /etc/issue*; then
  # CentOS/RedHat
  if [[ $(rpm -q --queryformat '%{VERSION}' centos-release) = *6* ]]; then
    # CentOS 6
    echo "⯈ Installing RethinkDB for CentOS 6"
    sudo wget https://download.rethinkdb.com/centos/6/"$(uname -m)"/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
    sudo yum update
    sudo yum install -y rethinkdb
  else
    # RHEL/CentOS 7
    echo "⯈ Installing RethinkDB for RHEL and RHEL-base Distributions."
    sudo wget http://download.rethinkdb.com/centos/7/"$(uname -m)"/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
    sudo yum update
    sudo yum install -y rethinkdb
  fi
elif [ -f "/etc/arch-release" ]; then
	# Arch Linux
   echo "⯈ Installing RethinkDB for Arch Linux"
	pacman -S rethinkdb
else
  echo "Linux Distribution not Supported!"
  exit
fi
