from scapy.all import * # for sniffing for the ARP packets
import os
import yaml
import paho.mqtt.client as mqtt
from time import sleep
import pprint

# read the config
config = yaml.load(open('config.yaml'))

# mqtt server
print("mqtt server: ", config['mqtt']['host'], ":", config['mqtt']['port']) 


def arp_display(pkt):
    if (ARP in pkt):
        if (pkt[ARP].op == 1):
            for mac, dest in config['buttons'].items():
                if (pkt[ARP].hwsrc == mac):
                    client = mqtt.Client("co2")
                    client.connect(config['mqtt']['host'], config['mqtt']['port'])
                    print("found: ", dest, "- report active")
                    client.publish(dest, 'active')
                    sleep(2)
                    print(dest, "- report inactive")
                    client.publish(dest, 'inactive')
                    client.disconnect()
    


# start listeing
print(sniff(prn=arp_display, filter="arp", store=0, count=0))