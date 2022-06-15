import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uav_mobile_controller/services/instruments_data.dart';
import 'package:cbor/cbor.dart';

class UavMqttClient {
  // final client = MqttServerClient('test.mosquitto.org', '');
  final client = MqttServerClient('217.182.74.253', '');
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

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 20;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password and clean session,
    /// an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect("scir", "scir");
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    /// Ok, lets try a subscription
    print('EXAMPLE::Subscribing to the test/lol topic');
    client.subscribe(topic, MqttQos.atMostOnce);

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToString(recMess.payload.message);
      // final pt =
      //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      /// The above may seem a little convoluted for users only interested in the
      /// payload, some users however may be interested in the received publish message,
      /// lets not constrain ourselves yet until the package has been in the wild
      /// for a while.
      /// The payload is a byte buffer, this will be specific to the topic
      // print(
      //     'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      // print('');
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
          print('EXAMPLE::parsing data exception - $e');
        }
      }
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    client.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });

    /// Lets publish to our topic
    /// Use the payload builder rather than a raw buffer
    /// Our known topic to publish to
    final builder = MqttClientPayloadBuilder();
    // builder.addString('Hello from mqtt_client');
    // builder.addDouble(90.0);
    // builder.addInt(90);
    print('EXAMPLE PREAPARING MESSAGE ${builder.payload!}');

    /// Subscribe to it
    print('EXAMPLE::Subscribing to the uav/instruments topic');
    client.subscribe(pubTopic, MqttQos.atLeastOnce);

    // /// Publish it
    // print('EXAMPLE::Publishing our topic');
    // client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

    /// Ok, we will now sleep a while, in this gap you will see ping request/response
    /// messages being exchanged by the keep alive mechanism.

    return 0;
  }

  Future<int> stop() async {
    // print('EXAMPLE::Sleeping....');
    // await MqttUtilities.asyncSleep(600);

    /// Finally, unsubscribe and exit gracefully
    print('EXAMPLE::Unsubscribing');
    client.unsubscribe(topic);
    client.unsubscribe(pubTopic);

    /// Wait for the unsubscribe message from the broker if you wish.
    // await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    client.disconnect();
    print('EXAMPLE::Exiting normally');
    return 0;
  }

  Future<int> restart() async {
    await stop();
    return Start();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    } else {
      print(
          'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
      // restart();
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was successful');
  }

  /// Pong callback
  void pong() {
    // instruments.SetCompassValue(180.0);
    print('EXAMPLE::Ping response client callback invoked');
    pongCount++;
  }
}
