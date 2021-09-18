#!/bin/bash
tar -pczvf package.tar.gz --exclude=".github/*" --exclude=".env" --exclude="LICENSE" --exclude="README.md" --exclude=".gitignore" --exclude="script/*" ./*
echo "host is ${secrets.HOST_DELIVERY}"
echo ${secrets.KEY_DELIVERY} | base64 -d > key.pem
ssh -i key.pem ${secrets.USER_DELIVERY}@${secrets.HOST_DELIVERY} 'mkdir -p ~/minecraft'
scp -i key.pem package.tar.gz ec2-user@${secrets.HOST_DELIVERY}:~/minecraft/
ssh -i key.pem ec2-user@${secrets.HOST_DELIVERY} 'cd minecraft && tar -xvf ~/minecraft/package.tar.gz && rm -f ~/minecraft/package.tar.gz'
rm package.tar.gz key.pem