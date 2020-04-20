#!/bin/bash

curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.2-amd64.deb
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb

echo "# - Filebeat and metricbeat downloaded"
#sleep 1

sudo dpkg -i *.deb

echo "# - change and copy the configs from ./config/ after chaning password"
echo "# - run \"sudo Xbeat modules enable system\"
echo "# - run \"sudo Xbeat setup\"
echo "# - run \"sudo /etc/init.d/Xbeat start\"
