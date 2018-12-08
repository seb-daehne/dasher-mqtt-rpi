FROM arm32v6/alpine:3.8
LABEL maintainer "Sebastian Daehne <daehne@rshc.de>"

ADD qemu-arm-static /usr/bin

RUN apk update && apk add --no-cache libpcap libpcap-dev git python make gcc g++ nodejs npm
RUN adduser -D -h /home/node node

USER node
RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV USER=node
RUN npm install -g mqtt-dasher

USER root
ADD run.sh /
CMD ["/run.sh"]
