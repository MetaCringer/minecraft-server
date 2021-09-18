tar -pczvf package.tar.gz --exclude=".github/*" --exclude=".env" --exclude="LICENSE" --exclude="README.md" --exclude=".gitignore" --exclude="script/*" ./*
ssh -i ~/.ssh/metacringer.pem ec2-user@${HOST_DELIVERY} 'mkdir -p ~/minecraft'
scp -i ~/.ssh/metacringer.pem package.tar.gz ec2-user@${HOST_DELIVERY}:~/minecraft/
ssh -i ~/.ssh/metacringer.pem ec2-user@${HOST_DELIVERY} 'cd minecraft && tar -xvf ~/minecraft/package.tar.gz && rm -f ~/minecraft/package.tar.gz'
rm package.tar.gz