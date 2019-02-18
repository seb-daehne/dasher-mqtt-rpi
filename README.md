## Dash button to mqtt docker image for raspberry pi

I tried to use the npm-module dasher-mqtt at first - but that wouldnt install so I switched to python


config via configmap - written to /config.yaml


```
apiVersion: v1
kind: ConfigMap
metadata:
  name: dasher-mqtt-config
  labels:
    app: dasher-mqtt
data:
  config.yaml: |+i   
        mqtt:
            # Specify your MQTT Broker's hostname or IP address here
            host: hostname
            port: 1883
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
      hostNetwork: true
      containers:
      - image:  sebd/dasher-mqtt-rpi
        name:  dasher-mqtt
        volumeMounts:
        - mountPath: /config.yaml
          name: dasher-mqtt-config
          subPath: config.yaml
        securityContext:
          capabilities:
            add: ["NET_ADMIN"]    
        tty: true
      volumes:
        - name: dasher-mqtt-config
          configMap:
            name: dasher-mqtt-config
```

