## Dasher-Mqtt docker image for raspberry pi

mqtt-dasher: https://github.com/stjohnjohnson/mqtt-dasher

config via configmap - written to /mqtt-dasher/config



```
mqtt:
    # Specify your MQTT Broker's hostname or IP address here
    host: hostname
    port: 1883
    #leave empty if none
    username:
    password:
    # Preface for the topics $PREFACE/$TOPIC
    preface: dash

buttons:
    ac:12:33:44:55:66: dash/dashbuttonname1
    ac:12:33:44:55:67: dash/dashbuttonname2
```


kubernetes deployment.yaml
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name:  dasher-mqtt
  labels:
    name:  dasher-mqtt
spec:
  template:
    metadata:
      labels:
        name:  dasher-mqtt
    spec:
      containers:
      - image:  sebd/dasher-mqtt-rpi
        name:  dasher-mqtt
        volumeMounts:
        - mountPath: /mqtt-dasher/config.yaml
          name: dasher-mqtt-config
          subPath: config.yaml
      volumes:
        - name: config
          configMap:
            name: dasher-mqtt
```

