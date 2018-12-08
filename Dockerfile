FROM arm32v6/alpine:3.8
LABEL maintainer "Sebastian Daehne <daehne@rshc.de>"

ADD qemu-arm-static /usr/bin

RUN apk update && apk add --no-cache python3 
RUN pip3 install paho-mqtt scapy yaml
ADD dasher.py /dasher.py

CMD ["python3", "/dasher.py"]
