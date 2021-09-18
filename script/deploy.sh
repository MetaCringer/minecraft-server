#!/bin/bash
tar -pczvf package.tar.gz --exclude=".github/*" --exclude=".env" --exclude="LICENSE" --exclude="README.md" --exclude=".gitignore" --exclude="scripts/*" ./*
echo ${KEY_DELIVERY} | base64 -d > key.pem
ssh -i key.pem ec2-user@${HOST_DELIVERY} 'mkdir -p ~/minecraft'
scp -i key.pem package.tar.gz ec2-user@${HOST_DELIVERY}:~/minecraft/
ssh -i key.pem ec2-user@${HOST_DELIVERY} 'cd minecraft && tar -xvf ~/minecraft/package.tar.gz && rm -f ~/minecraft/package.tar.gz'
rm package.tar.gz key.pem