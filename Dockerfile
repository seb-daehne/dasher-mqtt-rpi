FROM arm32v6/alpine:3.9
LABEL maintainer "Sebastian Daehne <daehne@rshc.de>"

ADD qemu-arm-static /usr/bin

RUN apk update && apk upgrade && apk add --no-cache python3 py3-yaml 
RUN pip3 install paho-mqtt scapy 
ADD dasher.py /dasher.py

CMD ["python3", "/dasher.py"]
