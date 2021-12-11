#!/bin/bash
tar -pczvf package.tar.gz --exclude=".github/*" --exclude=".env" --exclude="LICENSE" --exclude="README.md" --exclude=".gitignore" /app/
echo "host is ${HOST_DELIVERY}"
echo ${KEY_DELIVERY} | base64 -d > key.pem
chmod 600 key.pem
mkdir ~/.ssh/
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo "i am $(whoami)"
ssh-keyscan -H ${HOST_DELIVERY} > ~/.ssh/known_hosts
echo "known host is"
cat ~/.ssh/known_hosts
echo "---- ${PATH_DELIVERY}"
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} "mkdir -p ${PATH_DELIVERY}/"
scp -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts package.tar.gz ${USER_DELIVERY}@${HOST_DELIVERY}:${PATH_DELIVERY}/
ssh -i key.pem -o UserKnownHostsFile=~/.ssh/known_hosts ${USER_DELIVERY}@${HOST_DELIVERY} "cd ${PATH_DELIVERY}/ && tar -xvf ${PATH_DELIVERY}/package.tar.gz && rm -f ${PATH_DELIVERY}/package.tar.gz"
rm package.tar.gz key.pem