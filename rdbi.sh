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
    sudo apt-get install rethinkdb
  else
    echo "⯈ Installing RethinkDB for Debian"
    echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
    wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install rethinkdb
  fi
else
  echo "Linux Distribution not Supported!"
  exit
fi
