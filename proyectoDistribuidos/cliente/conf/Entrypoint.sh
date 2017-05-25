#!/bin/bash

until $(curl --output /dev/null --silent --head --fail http://mirror_1:8080)
do
  echo 'Esperando al mirror'     
  sleep 1
done
echo "Conectado"


echo "deb http://mirror_1:8080/ xenial main" > /etc/apt/sources.list
chmod 777 /tmp
apt-get clean
apt-get update -y
apt-get install python3 -y
apt-get install postgresql -y

httpd-foreground
