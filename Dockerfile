FROM openjdk:8u312-jre-slim-buster as installer

ADD docker-entrypoint.sh /app/docker-entrypoint.sh
ADD forge-1.12.2-installer.jar /app/
WORKDIR /app
RUN apt update  && \
    apt install -y libfreetype6
RUN java -jar forge-1.12.2-installer.jar --installServer && \
    rm forge-1.12.2-installer* && \
    mv forge-1.12.2-*.jar forge.jar
FROM openjdk:8u312-jre-slim-buster
COPY --from=installer /app/ /app/
WORKDIR /app
ADD eula.txt eula.txt
ADD mods/* mods/
ADD server.properties server.properties
ADD ./.github/scripts/* /scripts/
ADD run.sh /app/
RUN apt update -y && apt install -y ssh

#cmd sleep 10000000000
ENTRYPOINT ["./docker-entrypoint.sh"]