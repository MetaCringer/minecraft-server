#!/bin/bash
cd mods && tar -pczvf ../mods.tar.gz ./* && cd ../
echo "host is ${HOST_DELIVERY}"
echo ${KEY_DELIVERY} | base64 -d > key.pem
chmod 600 key.pem
mkdir ~/.ssh/
ssh-keyscan -H ${HOST_DELIVERY} > ~/.ssh/known_hosts
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} "mkdir -p ${PATH_DELIVERY}/app/mods/"
scp -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts mods.tar.gz ${USER_DELIVERY}@${HOST_DELIVERY}:${PATH_DELIVERY}/
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} "cd ${PATH_DELIVERY}/mods && rm -rf ${PATH_DELIVERY}/app/mods/* && tar -xvf ${PATH_DELIVERY}/mods.tar.gz && rm -f ${PATH_DELIVERY}/mods.tar.gz"
rm -f mods.tar.gz key.pem