from tokenize import Double
from numpy import double
import paho.mqtt.client as mqtt
from random import randrange, uniform
import time
from cbor2 import dumps

# mqttBroker = "217.182.74.253"
mqttBroker = "test.mosquitto.org"
# mqttBroker = "5.196.95.208"

client = mqtt.Client("Drone")
# client.username_pw_set("scir", "scir")
client.connect(mqttBroker)
topic = 'uav/instruments'

heading = 0.0
roll = 0.0
pitch = 0.0
throttle_1 = 0.0
throttle_2 = 0.0
throttle_3 = 0.0
throttle_4 = 0.0
altitude = 0.0
vertical_speed = 0.0

throttle_up = True
vertical_speed_up = True
roll_up = True
pitch_up = True

MAP_INDEX = {'HEADING': '0', 'ROLL': '1', 'PITCH': '2', 'THROTTLE_1': '3',
             'THROTTLE_2': '4', 'THROTTLE_3': '5', 'THROTTLE_4': '6', 'ALTITUDE': '7', 'VERTICAL_SPEED': '8'}


def get_heading() -> double:
    global heading
    tmp = heading
    if tmp > 360.0:
        tmp = 0.0
    tmp += 0.5
    return tmp


def get_throttle() -> double:
    global throttle_1
    global throttle_up

    tmp = throttle_1
    if tmp > 100.0:
        throttle_up = False
    elif tmp < 0.0:
        throttle_up = True

    if throttle_up:
        tmp += 0.5
    else:
        tmp -= 0.5
    return tmp


def get_vertical_speed() -> double:
    global vertical_speed
    global vertical_speed_up

    tmp = vertical_speed
    if tmp > 0.5:
        vertical_speed_up = False
    elif tmp < -0.5:
        vertical_speed_up = True

    if vertical_speed_up:
        tmp += 0.01
    else:
        tmp -= 0.01
    return tmp


def get_roll() -> double:
    global roll
    global roll_up

    tmp = roll
    if tmp > 45.0:
        roll_up = False
    elif tmp < -45.5:
        roll_up = True

    if roll_up:
        tmp += 0.5
    else:
        tmp -= 0.5
    return tmp


def get_pitch() -> double:
    global pitch
    global pitch_up

    tmp = pitch
    if tmp > 25.0:
        pitch_up = False
    elif tmp < -25.0:
        pitch_up = True

    if pitch_up:
        tmp += 0.5
    else:
        tmp -= 0.5
    return tmp


def get_altitude() -> double:
    global altitude
    tmp = altitude
    tmp += 10.0
    return tmp


while True:
    heading = get_heading()
    throttle_1 = get_throttle()
    throttle_2 = get_throttle()
    throttle_3 = get_throttle()
    throttle_4 = get_throttle()
    vertical_speed = get_vertical_speed()
    altitude = get_altitude()
    roll = get_roll()
    pitch = get_pitch()

    data_map = {MAP_INDEX['HEADING']: heading,
                MAP_INDEX['ROLL']: roll,
                MAP_INDEX['PITCH']: pitch,
                MAP_INDEX['THROTTLE_1']: throttle_1,
                MAP_INDEX['THROTTLE_2']: throttle_2,
                MAP_INDEX['THROTTLE_3']: throttle_3,
                MAP_INDEX['THROTTLE_4']: throttle_4,
                MAP_INDEX['ALTITUDE']: altitude,
                MAP_INDEX['VERTICAL_SPEED']: vertical_speed}
    data = dumps(data_map)
    print(data.hex())
    client.publish(topic, data)
    print("Just published " + str(data) + " to topic " + topic)
    time.sleep(0.1)
