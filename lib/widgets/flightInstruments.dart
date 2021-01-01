import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FlightInstrumentsPage extends StatefulWidget {
  const FlightInstrumentsPage({Key? key}) : super(key: key);

  @override
  _FlightInstrumentsState createState() => _FlightInstrumentsState();
}

class _FlightInstrumentsState extends State<FlightInstrumentsPage> {
  _FlightInstrumentsState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _annotationTextSize = 22;
    _markerOffset = 0.71;
    _positionFactor = 0.025;
    _markerHeight = 10;
    _markerWidth = 15;
    _labelFontSize = 11;
    final Widget _widget = SfRadialGauge(
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
            backgroundImage: const AssetImage('images/dark_theme_gauge.png'),
            pointers: <GaugePointer>[
              MarkerPointer(
                  value: 90,
                  color: const Color(0xFFDF5F2D),
                  enableAnimation: true,
                  animationDuration: 1200,
                  markerOffset: isCardView ? 0.69 : _markerOffset,
                  offsetUnit: GaugeSizeUnit.factor,
                  markerType: MarkerType.triangle,
                  markerHeight: isCardView ? 8 : _markerHeight,
                  markerWidth: isCardView ? 8 : _markerWidth)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 270,
                  positionFactor: _positionFactor,
                  widget: Text(
                    '90',
                    style: TextStyle(
                        color: const Color(0xFFDF5F2D),
                        fontWeight: FontWeight.bold,
                        fontSize: isCardView ? 16 : _annotationTextSize),
                  ))
            ])
      ],
    );
    return _widget;
  }

  /// Handled callback for change numeric value to compass directional letter.
  void _handleAxisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '90') {
      args.text = 'E';
      args.labelStyle = GaugeTextStyle(
          color: const Color(0xFFDF5F2D),
          fontSize: isCardView ? 10 : _labelFontSize);
    } else if (args.text == '360') {
      args.text = '';
    } else {
      if (args.text == '0') {
        args.text = 'N';
      } else if (args.text == '180') {
        args.text = 'S';
      } else if (args.text == '270') {
        args.text = 'W';
      }

      args.labelStyle = GaugeTextStyle(
          color: const Color(0xFFFFFFFF),
          fontSize: isCardView ? 10 : _labelFontSize);
    }
  }

  double _annotationTextSize = 22;
  double _positionFactor = 0.025;
  double _markerHeight = 10;
  double _markerWidth = 15;
  double _markerOffset = 0.71;
  double _labelFontSize = 10;
  bool isCardView = false;

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //         body: Center(
  //             child: SfRadialGauge(axes: <RadialAxis>[
  //       RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
  //         GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
  //         GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
  //         GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
  //       ], pointers: const <GaugePointer>[
  //         NeedlePointer(value: 90)
  //       ], annotations: const <GaugeAnnotation>[
  //         GaugeAnnotation(
  //             widget: Text('90.0',
  //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
  //             angle: 90,
  //             positionFactor: 0.5)
  //       ])
  //     ]))),
  //   );
  // }
}
