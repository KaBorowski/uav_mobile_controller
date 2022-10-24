import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:uav_mobile_controller/services/mqtt.dart';
import 'package:uav_mobile_controller/services/instruments_data.dart';
import 'heading_indicator.dart';
import 'altimeter_indicator.dart';
import 'attitude_indicator.dart';
import 'vertical_speed_indicator.dart';
import 'throttle_indicator.dart';

class FlightInstrumentsPage extends StatefulWidget {
  const FlightInstrumentsPage({Key? key}) : super(key: key);

  @override
  _FlightInstrumentsState createState() => _FlightInstrumentsState();
}

class _FlightInstrumentsState extends State<FlightInstrumentsPage> {
  final _instruments = InstrumentsData();
  late UavMqttClient mqttClient;
  late Timer timer;

  _FlightInstrumentsState();

  Future<bool> _onWillPop() async {
    await mqttClient.stop();
    timer.cancel();
    return true;
  }

  @override
  void initState() {
    super.initState();
    mqttClient = UavMqttClient(instruments: _instruments);
    mqttClient.Start();
    timer = Timer.periodic(const Duration(milliseconds: 100), _updateData);
  }

  void _updateData(Timer timer) {
    setState(() {
      _heading = _instruments.getHeading();
      _roll = _instruments.getRoll();
      _pitch = _instruments.getPitch();
      _throttle1 = _instruments.getThrottle1();
      _throttle2 = _instruments.getThrottle2();
      _throttle3 = _instruments.getThrottle3();
      _throttle4 = _instruments.getThrottle4();
      _altitude = _instruments.getAltitude();
      _verticalSpeed = _instruments.getVerticalSpeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    _labelFontSize = 7;
    _containerPadding = 0;

    final Widget _widget = Scaffold(
      backgroundColor: Colors.grey,
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 4,
        children: <Widget>[
          // Compass
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: HeadingIndicator(
                compassValue: _heading, labelFontSize: _labelFontSize),
          ),
          // Altimeter indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: AltimeterIndicator(
              value: _altitude,
              labelFontSize: _labelFontSize,
            ),
          ),
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: ThrottleIndicator(
              value: _throttle1,
              labelFontSize: _labelFontSize,
              id: 1,
            ),
          ),
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: ThrottleIndicator(
                value: _throttle2, labelFontSize: _labelFontSize, id: 2),
          ),
          // Attitude indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: AttitudeIndicator(
              rollValue: _roll,
              pitchValue: _pitch,
              labelFontSize: _labelFontSize,
            ),
          ),
          // Vertical speed indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: VerticalSpeedIndicator(
                value: _verticalSpeed, labelFontSize: _labelFontSize),
          ),
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: ThrottleIndicator(
                value: _throttle3, labelFontSize: _labelFontSize, id: 3),
          ),
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/gauge_background.png'), scale: 1),
            ),
            child: ThrottleIndicator(
                value: _throttle4, labelFontSize: _labelFontSize, id: 4),
          ),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: _widget,
    );

    // return _widget;
  }

  double _heading = 0.0;
  double _pitch = 0.0;
  double _roll = 0.0;
  double _throttle1 = 0.0;
  double _throttle2 = 0.0;
  double _throttle3 = 0.0;
  double _throttle4 = 0.0;
  double _altitude = 0.0;
  double _verticalSpeed = 0.0;

  double _labelFontSize = 2;
  double _containerPadding = 1;
}
