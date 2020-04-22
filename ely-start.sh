#!/bin/bash


usage () {
	echo "# - usage: ./ely-start.sh import-host host-username (tag/branch name)"
	exit 1
}


#curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.2-amd64.deb
#curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb

echo "# - Filebeat and metricbeat downloaded"
#sleep 1

#[ -z $1 ] && IDHOST=$1 || read -r -p "# Which host to fetch id_rsa from? (sw01 is standard) " IDHOST

IDHOST=sw01
IDUSER=user
IDREMOTE=/home/$IDUSER/.ssh/
IDLOCAL=/home/$LOGNAME/.ssh/

echo "# - Checking if $IDLOCAL/id_rsa exists"
if [ ! -f "$IDLOCAL/id_rsa" ]; then
  echo "# - importing id_rsa"
  scp user@$IDHOST:$IDREMOTE/id_rsa $IDLOCAL/id_rsa
fi

echo "# - Checking if $IDLOCAL/id_rsa.pub exists"
if [ ! -f "$IDLOCAL/id_rsa.pub" ]; then
  echo "# - importing id_rsa.pub"
  scp user@$IDHOST:$IDREMOTE/id_rsa.pub $IDLOCAL/id_rsa.pub
fi

#scp user@$IDHOST:/home/user/.ssh/id_rsa.pub /home/user/.ssh/id_rsa.pub
#[ -f $HOME/.ssh/id_rsa ] && echo "$FILE exist" || echo "$FILE does not exist"

echo "# - Checking if $IDLOCAL/id_rsa and id_rsa.pub exists"
#if [[ -f "$IDLOCAL/id_rsa" && -f "$IDLOCAL/id_rsa.pub"]]; then
if [[ -f $IDLOCAL/id_rsa && -f $IDLOCAL/id_rsa.pub ]]; then
  eval "$(ssh-agent -s)"
  ssh-add $IDLOCAL/id_rsa
  #read -r -p "# - Want to display(echo) id_rsa.pub? (yes)" DISPLAYRSA
  echo "# - Displaying id_rsa.pub"
  cat $IDLOCAL/id_rsa.pub
  echo "# -"
  echo "# - add id_rsa.pub to github (log in -> settings -> SSH and GPG -> New ssh)"
else 
    echo "# - id_rsa and/or id_rsa.pub does not exist"
    echo "# - $ls -al $IDLOCAL"
    ls -al $IDLOCAL
    echo "# - Exiting."
    exit 1
fi

exit 1
sudo dpkg -i *.deb

echo "# - change and copy the configs from ./config/ after chaning password"
echo "# - run \"sudo Xbeat modules enable system\"
echo "# - run \"sudo Xbeat setup\"
echo "# - run \"sudo /etc/init.d/Xbeat start\"
