#!/bin/bash
tar -pczvf mods.tar.gz ./mods/*
echo "host is ${HOST_DELIVERY}"
echo ${KEY_DELIVERY} | base64 -d > key.pem
chmod 600 key.pem
mkdir ~/.ssh/
ssh-keyscan -H ${HOST_DELIVERY} > ~/.ssh/known_hosts
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} 'mkdir -p ~/minecraft/mods/'
scp -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts mods.tar.gz ${USER_DELIVERY}@${HOST_DELIVERY}:~/minecraft/
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} 'cd minecraft/mods && tar -xvf ~/minecraft/mods.tar.gz && rm -f ~/minecraft/mods.tar.gz'
rm -f mods.tar.gz key.pem