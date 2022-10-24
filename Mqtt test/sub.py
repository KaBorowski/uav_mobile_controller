import paho.mqtt.client as mqtt
import time


def on_message(client, userdata, message):
    print("received message: ", str(message.payload.decode("utf-8")))


mqttBroker = "test.mosquitto.org"

client = mqtt.Client("Smartphone")
client.connect(mqttBroker)
topic = 'uav/instruments'

client.subscribe(topic)
client.on_message = on_message
client.loop_forever()

# client.loop_start()
# time.sleep(30)
# client.loop_stop()
