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
    _labelFontSize = 7;
    _containerPadding = 1;
    _pitchValue = 0.0;
    _rollValue = 0.0;

    final Widget _widget = Scaffold(
      backgroundColor: Colors.grey,
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(50),
        crossAxisSpacing: 00,
        mainAxisSpacing: 0,
        crossAxisCount: 4,
        children: <Widget>[
          // Compass
          Container(
            padding: EdgeInsets.all(_containerPadding),
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
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
                  //       markerOffset:  : _markerOffset,
                  //       offsetUnit: GaugeSizeUnit.factor,
                  //       markerType: MarkerType.triangle,
                  //       markerHeight: _markerHeight,
                  //       markerWidth: _markerWidth)
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
                  //                  _annotationTextSize),
                  //       ))
                  // ]
                )
              ],
            ),
          ),
          // Altimeter indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: false,
                  radiusFactor: 1,
                  canRotateLabels: false,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  // onLabelCreated: _handleAxisLabelCreated,
                  startAngle: 270,
                  endAngle: 270,
                  labelOffset: 0.05,
                  maximum: 10,
                  minimum: 0,
                  interval: 1,
                  minorTicksPerInterval: 4,
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
                        value: 2,
                        needleEndWidth: 7,
                        needleLength: 0.4,
                        needleColor: Color(0xFFFFFF00),
                        knobStyle: KnobStyle(
                          knobRadius: 8,
                          color: Color.fromARGB(255, 0, 0, 0),
                          borderColor: Color.fromARGB(255, 255, 255, 255),
                          borderWidth: 1,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 6,
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderColor: Color.fromARGB(255, 255, 255, 255),
                            borderWidth: 1,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 20)),
                    NeedlePointer(
                        value: 0,
                        needleEndWidth: 3,
                        needleLength: 0.6,
                        needleColor: Color(0xFFFFFF00),
                        knobStyle: KnobStyle(
                          knobRadius: 5,
                          color: Color.fromARGB(255, 0, 0, 0),
                          borderColor: Color.fromARGB(255, 255, 255, 255),
                          borderWidth: 1,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 3,
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderColor: Color.fromARGB(255, 255, 255, 255),
                            borderWidth: 1,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 20)),
                    NeedlePointer(
                      value: 6,
                      needleEndWidth: 1,
                      needleStartWidth: 1,
                      needleLength: 0.7,
                      needleColor: Color(0xFFFFFF00),
                      // knobStyle: KnobStyle(
                      //   knobRadius: 5,
                      //   color: Color.fromARGB(255, 0, 0, 0),
                      //   borderColor: Color.fromARGB(255, 255, 255, 255),
                      //   borderWidth: 1,
                      //   sizeUnit: GaugeSizeUnit.logicalPixel,
                      // ),
                      // tailStyle: TailStyle(
                      //     width: 3,
                      //     color: Color.fromARGB(255, 0, 0, 0),
                      //     borderColor: Color.fromARGB(255, 255, 255, 255),
                      //     borderWidth: 1,
                      //     lengthUnit: GaugeSizeUnit.logicalPixel,
                      //     length: 20)
                    ),
                    MarkerPointer(
                        value: 6,
                        elevation: 4,
                        markerWidth: 9,
                        markerHeight: 7,
                        color: const Color(0xFFFFFF00),
                        offsetUnit: GaugeSizeUnit.factor,
                        // markerType: _markerType,
                        markerOffset: 0.27)
                  ],
                ),
              ],
            ),
          ),
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              // title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: true,
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
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              // title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: true,
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
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
          // Attitude indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  radiusFactor: 1,
                  canRotateLabels: true,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  // onLabelCreated: _handleAxisLabelCreated,
                  startAngle: 180 - _rollValue,
                  endAngle: 180 - _rollValue,
                  labelOffset: 0.05,
                  maximum: 270,
                  minimum: -90,
                  showLastLabel: true,
                  interval: 90,
                  minorTicksPerInterval: 0,
                  // ranges: <GaugeRange>[
                  //   GaugeRange(
                  //       startValue: -90,
                  //       endValue: 90,
                  //       color: Color.fromARGB(255, 0x00, 0xbf, 0xff),
                  //       sizeUnit: GaugeSizeUnit.factor,
                  //       rangeOffset: 0.06,
                  //       startWidth: 0.2,
                  //       endWidth: 0.2),
                  //   GaugeRange(
                  //     startValue: 90,
                  //     endValue: 270,
                  //     rangeOffset: 0.28,
                  //     sizeUnit: GaugeSizeUnit.factor,
                  //     color: const Color(0xFF355C7D),
                  //     startWidth: 0.2,
                  //     endWidth: 0.2,
                  //   )
                  // ],
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
                      const AssetImage('images/attitude_indicator_back.png'),
                  pointers: <GaugePointer>[
                    MarkerPointer(
                        value: 0,
                        color: const Color(0xFFDF5F2D),
                        enableAnimation: false,
                        // animationDuration: 1200,
                        markerOffset: 91 + _pitchValue / 2,
                        offsetUnit: GaugeSizeUnit.logicalPixel,
                        // markerType: MarkerType.triangle,
                        markerType: MarkerType.image,
                        imageUrl: 'images/attitude_indicator_pointer.png',
                        markerHeight: 100,
                        markerWidth: 100)
                  ],
                )
              ],
            ),
          ),
          // Vertical speed indicator
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: true,
                  radiusFactor: 1,
                  canRotateLabels: false,
                  tickOffset: 0.32,
                  offsetUnit: GaugeSizeUnit.factor,
                  // onLabelCreated: _handleAxisLabelCreated,
                  startAngle: 90,
                  endAngle: 270,
                  labelOffset: 0.05,
                  maximum: 0.5,
                  minimum: -0.5,
                  interval: 0.5,
                  minorTicksPerInterval: 15,
                  axisLabelStyle: GaugeTextStyle(
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              // title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: true,
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
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
          // Throttle
          Container(
            padding: EdgeInsets.all(_containerPadding),
            child: SfRadialGauge(
              // title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                  showAxisLine: false,
                  showLastLabel: true,
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
                      color: const Color(0xFF949494), fontSize: _labelFontSize),
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
          color: const Color(0xFFFFFF00), fontSize: _labelFontSize);
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
        //     fontSize:  _labelFontSize);
      } else {
        args.labelStyle = GaugeTextStyle(
            color: const Color(0xFFFFFFFF), fontSize: _labelFontSize);
      }
    }
  }

  double _compassValue = 0.0;
  double _pitchValue = 0.0;
  double _rollValue = 0.0;

  double _annotationTextSize = 22;
  double _positionFactor = 0.025;
  double _markerHeight = 10;
  double _markerWidth = 15;
  double _markerOffset = 0.71;
  double _labelFontSize = 2;
  double _containerPadding = 1;
}
