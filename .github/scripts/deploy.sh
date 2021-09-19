#!/bin/bash
tar -pczvf package.tar.gz --exclude=".github/*" --exclude=".env" --exclude="LICENSE" --exclude="README.md" --exclude=".gitignore" --exclude="script/*" ./*
echo "host is ${HOST_DELIVERY}"
echo ${KEY_DELIVERY} | base64 -d > key.pem
chmod 600 key.pem
mkdir ~/.ssh/
ssh-keyscan -H ec2-54-93-59-82.eu-central-1.compute.amazonaws.com > ~/.ssh/known_hosts
ssh -i key.pem ${USER_DELIVERY}@${HOST_DELIVERY} 'mkdir -p ~/minecraft'
scp -i key.pem package.tar.gz ${USER_DELIVERY}@${HOST_DELIVERY}:~/minecraft/
ssh -i key.pem ${USER_DELIVERY}@${HOST_DELIVERY} 'cd minecraft && tar -xvf ~/minecraft/package.tar.gz && rm -f ~/minecraft/package.tar.gz'
rm package.tar.gz key.pem