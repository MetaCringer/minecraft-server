FROM openjdk:8u312-jre-slim-buster as installer
WORKDIR /app
ADD docker-entrypoint.sh ./
ADD forge-1.12.2-installer.jar ./
ADD eula.txt ./
ADD mods ./
ADD server.properties ./
ADD ./.github/scripts/* /scripts/
ADD run.sh ./
RUN apt update -y && apt install -y ssh

#cmd sleep 10000000000
ENTRYPOINT ["./docker-entrypoint.sh"]