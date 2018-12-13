#!/bin/sh

# RethinkDB Linux Installation Script
#   by RethinkDB
#   Globalized by TRPGDA (Prixyn)


if [ -f /etc/lsb-release ]; then
  # Debian, Ubuntu & Raspbian
  if [[ $(cat /etc/issue) = *Ubuntu* ]]; then
    echo "⯈ Installing RethinkDB for Ubuntu"
    source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y rethinkdb
  elif [[ $(cat /etc/os-release) = *Raspbian* ]]; then
		# Gotta build from source.
  	echo "⯈ Installing RethinkDB for Raspbian"
		sudo apt-get install g++ protobuf-compiler libprotobuf-dev \
                     libboost-dev curl m4 wget libssl-dev
		wget https://download.rethinkdb.com/dist/rethinkdb-2.3.6.tgz
		tar xf rethinkdb-2.3.6.tgz
		cd rethinkdb-2.3.6
		./configure --with-system-malloc --allow-fetch
		make ALLOW_WARNINGS=1
		sudo make install ALLOW_WARNINGS=1
  else
    echo "⯈ Installing RethinkDB for Debian"
    echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y rethinkdb
  fi
elif [ -f /etc/redhat-release ]; then
	case $RELEASE in
		"Red Hat Enterprise Linux release 7."*|"CentOS Linux release 7."*|"Scientific Linux release 7."*)
			# RHEL/CentOS 7
    	echo "⯈ Installing RethinkDB for RHEL/CentOS 7"
    	sudo wget http://download.rethinkdb.com/centos/7/"$(uname -m)"/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
    sudo yum -y update
    sudo yum -y install rethinkdb
			;;
		"Red Hat Enterprise Linux release 6."*|"CentOS release 6."*|"Scientific Linux release 6."*)
			# RHEL/CentOS 6
    	echo "⯈ Installing RethinkDB for CentOS 6"
    	sudo wget https://download.rethinkdb.com/centos/6/"$(uname -m)"/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
    sudo yum -y update
    sudo yum -y install rethinkdb
			;;
		"Fedora release "*)
			sudo wget https://download.rethinkdb.com/centos/6/`uname -m`/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
			sudo yum -y update
			sudo yum -y install rethinkdb
		;;
		*)
			# Unsupported RHEL Version
			echo "RHEL Version not supported!"
			;;
		esac
elif [ -f /etc/system-release ]; then
	# Amazon Linux
    echo "⯈ Installing RethinkDB for Amazon Linux"
    sudo wget http://download.rethinkdb.com/centos/7/"$(uname -m)"/rethinkdb.repo -O /etc/yum.repos.d/rethinkdb.repo
    sudo yum -y update
    sudo yum -y install rethinkdb
    echo "Installed!"
elif [ -f "/etc/arch-release" ]; then
	# Arch Linux
   echo "⯈ Installing RethinkDB for Arch Linux"
	pacman -S rethinkdb
else
  echo "Linux Distribution not supported!"
  exit
fi
