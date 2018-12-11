#FROM alpine:latest
FROM heroku/heroku:18
RUN mkdir -m 777 /chisel
 
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

CMD /entrypoint.sh

FROM ubuntu:18.10
ENV VER=1.2.4
RUN apt-get update &&\
    apt-get -y install curl &&\
    mkdir -m 777 /chisel &&\
    cd /chisel &&\
    curl -L -o chisel.gz http://github.com/jpillora/chisel/releases/download/$VER/chisel_linux_amd64.gz &&\
    gzip -d chisel.gz &&\
    chmod +x chisel
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
ENTRYPOINT  /entrypoint.sh 
#CMD ["/chisel/chisel","--port","8080","--log"]
EXPOSE 8080
