import paho.mqtt.client as mqtt  # import the client1
import time
############


def on_message(client, userdata, message):
    print("message received ", str(message.payload.decode("utf-8")))
    print("message topic=", message.topic)
    print("message qos=", message.qos)
    print("message retain flag=", message.retain)


########################################
# broker_address = "146.59.34.38"
broker_address = "test.mosquitto.org"
# broker_address = "vps-f22dc0ba.vps.ovh.net"
print("creating new instance")
client = mqtt.Client("P1")  # create new instance
client.on_message = on_message  # attach function to callback
print("connecting to broker")
client.connect(broker_address)  # connect to broker
client.loop_start()  # start the loop
# client.loop_forever()
while True:
    print("Subscribing to topic", "Dart/Mqtt_client/testtopic")
    client.subscribe("Dart/Mqtt_client/testtopic")
    print("Publishing message to topic", "Dart/Mqtt_client/testtopic")
    client.publish("Dart/Mqtt_client/testtopic", 270.0)
    time.sleep(5)  # wait
# client.loop_stop()  # stop the loop
