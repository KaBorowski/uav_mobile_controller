import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:uav_mobile_controller/services/mqtt.dart';
import 'package:uav_mobile_controller/services/instruments_data.dart';

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

  @override
  void initState() {
    super.initState();
    mqttClient = UavMqttClient(instruments: _instruments);
    mqttClient.Start();
    timer = Timer.periodic(const Duration(milliseconds: 100), _updateData);
  }

  void _updateData(Timer timer) {
    setState(() {
      _compassValue = _instruments.GetCompassValue();
      // _compassValue = _instruments.GetThrottleValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    _annotationTextSize = 22;
    _markerOffset = 0.71;
    _positionFactor = 0.025;
    _markerHeight = 10;
    _markerWidth = 15;
    _labelFontSize = 11;

    final Widget _widget = Scaffold(
      backgroundColor: Colors.grey,
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  radiusFactor: 1,
                  canRotateLabels: true,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  onLabelCreated: _handleAxisLabelCreated,
                  startAngle: -_compassValue - 90,
                  endAngle: -_compassValue - 90,
                  labelOffset: 0.05,
                  maximum: 360,
                  minimum: 0,
                  interval: 30,
                  minorTicksPerInterval: 4,
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494),
                      fontSize: isCardView ? 10 : _labelFontSize),
                  minorTickStyle: const MinorTickStyle(
                      color: Color(0xFF616161),
                      thickness: 1.6,
                      length: 0.058,
                      lengthUnit: GaugeSizeUnit.factor),
                  majorTickStyle: const MajorTickStyle(
                      color: Color(0xFF949494),
                      thickness: 2.3,
                      length: 0.087,
                      lengthUnit: GaugeSizeUnit.factor),
                  backgroundImage:
                      const AssetImage('images/dark_theme_gauge_plane.png'),
                  // pointers: <GaugePointer>[
                  //   MarkerPointer(
                  //       value: _compassValue,
                  //       color: const Color(0xFFDF5F2D),
                  //       enableAnimation: true,
                  //       animationDuration: 1200,
                  //       markerOffset: isCardView ? 0.69 : _markerOffset,
                  //       offsetUnit: GaugeSizeUnit.factor,
                  //       markerType: MarkerType.triangle,
                  //       markerHeight: isCardView ? 8 : _markerHeight,
                  //       markerWidth: isCardView ? 8 : _markerWidth)
                  // ],
                  // annotations: <GaugeAnnotation>[
                  //   GaugeAnnotation(
                  //       angle: 270,
                  //       positionFactor: _positionFactor,
                  //       widget: Text(
                  //         _compassValue.toInt().toString(),
                  //         style: TextStyle(
                  //             color: const Color(0xFFDF5F2D),
                  //             fontWeight: FontWeight.bold,
                  //             fontSize:
                  //                 isCardView ? 16 : _annotationTextSize),
                  //       ))
                  // ]
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: SfRadialGauge(
              // title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  radiusFactor: 1,
                  canRotateLabels: true,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  // onLabelCreated: _handleAxisLabelCreated,
                  startAngle: 270,
                  endAngle: 230,
                  labelOffset: 0.05,
                  maximum: 100,
                  minimum: 0,
                  interval: 10,
                  minorTicksPerInterval: 4,
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494),
                      fontSize: isCardView ? 10 : _labelFontSize),
                  minorTickStyle: const MinorTickStyle(
                      color: Color(0xFF616161),
                      thickness: 1.6,
                      length: 0.058,
                      lengthUnit: GaugeSizeUnit.factor),
                  majorTickStyle: const MajorTickStyle(
                      color: Color(0xFF949494),
                      thickness: 2.3,
                      length: 0.087,
                      lengthUnit: GaugeSizeUnit.factor),
                  backgroundImage:
                      const AssetImage('images/dark_theme_gauge.png'),
                  pointers: const <GaugePointer>[
                    NeedlePointer(
                        value: 20,
                        needleEndWidth: 3,
                        needleLength: 0.6,
                        needleColor: Color(0xFFFFFF00),
                        knobStyle: KnobStyle(
                          knobRadius: 8,
                          color: Color(0xFFFFFF00),
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 3,
                            color: Color(0xFFFFFF00),
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 20))
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  radiusFactor: 1,
                  canRotateLabels: true,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  onLabelCreated: _handleAxisLabelCreated,
                  startAngle: 270,
                  endAngle: 270,
                  labelOffset: 0.05,
                  maximum: 360,
                  minimum: 0,
                  interval: 30,
                  minorTicksPerInterval: 4,
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494),
                      fontSize: isCardView ? 10 : _labelFontSize),
                  minorTickStyle: const MinorTickStyle(
                      color: Color(0xFF616161),
                      thickness: 1.6,
                      length: 0.058,
                      lengthUnit: GaugeSizeUnit.factor),
                  majorTickStyle: const MajorTickStyle(
                      color: Color(0xFF949494),
                      thickness: 2.3,
                      length: 0.087,
                      lengthUnit: GaugeSizeUnit.factor),
                  backgroundImage:
                      const AssetImage('images/dark_theme_gauge.png'),
                  pointers: <GaugePointer>[
                    MarkerPointer(
                        value: _compassValue,
                        color: const Color(0xFFDF5F2D),
                        enableAnimation: true,
                        animationDuration: 1200,
                        markerOffset: 0.9,
                        offsetUnit: GaugeSizeUnit.factor,
                        // markerType: MarkerType.triangle,
                        markerType: MarkerType.image,
                        imageUrl: 'images/test_compass.png',
                        markerHeight: 100,
                        markerWidth: 100)
                  ],
                  // annotations: <GaugeAnnotation>[
                  //   GaugeAnnotation(
                  //       angle: 270,
                  //       positionFactor: _positionFactor,
                  //       widget: Text(
                  //         _compassValue.toInt().toString(),
                  //         style: TextStyle(
                  //             color: const Color(0xFFDF5F2D),
                  //             fontWeight: FontWeight.bold,
                  //             fontSize:
                  //                 isCardView ? 16 : _annotationTextSize),
                  //       ))
                  // ]
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[400],
            child: const Text('Who scream'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[500],
            child: const Text('Revolution is coming...'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[600],
            child: const Text('Revolution, they...'),
          ),
        ],
      ),
    );

    return _widget;
  }

  /// Handled callback for change numeric value to compass directional letter.
  void _handleAxisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '360') {
      args.text = '';
    } else {
      args.labelStyle = GaugeTextStyle(
          color: const Color(0xFFFFFF00),
          fontSize: isCardView ? 10 : _labelFontSize);
      if (args.text == '0') {
        args.text = 'N';
      } else if (args.text == '180') {
        args.text = 'S';
      } else if (args.text == '270') {
        args.text = 'W';
      } else if (args.text == '90') {
        args.text = 'E';
        //     color: const Color(0xFFDF5F2D),
        // args.labelStyle = GaugeTextStyle(
        //     fontSize: isCardView ? 10 : _labelFontSize);
      } else {
        args.labelStyle = GaugeTextStyle(
            color: const Color(0xFFFFFFFF),
            fontSize: isCardView ? 10 : _labelFontSize);
      }
    }
  }

  double _compassValue = 0.0;

  double _annotationTextSize = 22;
  double _positionFactor = 0.025;
  double _markerHeight = 10;
  double _markerWidth = 15;
  double _markerOffset = 0.71;
  double _labelFontSize = 5;
  bool isCardView = false;
}
