import paho.mqtt.client as mqtt  # import the client1
broker_address = "test.mosquitto.org"
# broker_address="iot.eclipse.org" #use external broker
client = mqtt.Client("P4")  # create new instance
client.connect(broker_address)  # connect to broker
client.publish("Dart/Mqtt_client/testtopic", 90.0)  # publish
print('done')
