import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:cbor/cbor.dart';
import 'package:uav_mobile_controller/services/instruments_data.dart';

class UavMqttClient {
  final client = MqttServerClient('test.mosquitto.org', '');
  // final client = MqttServerClient('217.182.74.253', '');
  late InstrumentsData instruments;
  var pongCount = 0; // Pong counter
  final pubTopic = 'uav/instruments';
  final topic = 'test/lol'; // Not a wildcard topic

  final MAP_INDEX = {
    'HEADING': '0',
    'ROLL': '1',
    'PITCH': '2',
    'THROTTLE_1': '3',
    'THROTTLE_2': '4',
    'THROTTLE_3': '5',
    'THROTTLE_4': '6',
    'ALTITUDE': '7',
    'VERTICAL_SPEED': '8'
  };

  UavMqttClient({required this.instruments});

  Future<int> Start() async {
    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('MQTT::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    try {
      // await client.connect("scir", "scir");
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('MQTT::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('MQTT::socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT::Mosquitto client connected');
    } else {
      print(
          'MQTT::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    print('MQTT::Subscribing to the test/lol topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToString(recMess.payload.message);

      if (c[0].topic == 'uav/instruments') {
        try {
          final payload =
              Stream.fromIterable(recMess.payload.message.map((x) => [x]));
          final decoded = await payload.transform(cbor.decoder).single;
          final decodedMap = decoded.toObject() as Map;
          instruments.setHeading(decodedMap[MAP_INDEX['HEADING']]);
          instruments.setRoll(decodedMap[MAP_INDEX['ROLL']]);
          instruments.setPitch(decodedMap[MAP_INDEX['PITCH']]);
          instruments.setThrottle1(decodedMap[MAP_INDEX['THROTTLE_1']]);
          instruments.setThrottle2(decodedMap[MAP_INDEX['THROTTLE_2']]);
          instruments.setThrottle3(decodedMap[MAP_INDEX['THROTTLE_3']]);
          instruments.setThrottle4(decodedMap[MAP_INDEX['THROTTLE_4']]);
          instruments.setAltitude(decodedMap[MAP_INDEX['ALTITUDE']]);
          print(decodedMap[MAP_INDEX['ROLL']]);
          instruments.setVerticalSpeed(decodedMap[MAP_INDEX['VERTICAL_SPEED']]);
        } on FormatException catch (e) {
          print('MQTT::parsing data exception - $e');
        }
      }
    });

    client.published!.listen((MqttPublishMessage message) {
      print(
          'MQTT::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });

    final builder = MqttClientPayloadBuilder();
    print('EXAMPLE PREAPARING MESSAGE ${builder.payload!}');

    print('MQTT::Subscribing to the uav/instruments topic');
    client.subscribe(pubTopic, MqttQos.atLeastOnce);

    return 0;
  }

  Future<int> stop() async {
    print('MQTT::Unsubscribing');
    client.unsubscribe(topic);
    client.unsubscribe(pubTopic);

    client.disconnect();
    print('MQTT::Exiting normally');
    return 0;
  }

  Future<int> restart() async {
    await stop();
    return Start();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('MQTT::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('MQTT::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('MQTT::OnDisconnected callback is solicited, this is correct');
    } else {
      print(
          'MQTT::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
      // restart();
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'MQTT::OnConnected client callback - Client connection was successful');
  }

  /// Pong callback
  void pong() {
    print('MQTT::Ping response client callback invoked');
    pongCount++;
  }
}
