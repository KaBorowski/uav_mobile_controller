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

    final Widget _widget = Scaffold(
      backgroundColor: Colors.white,
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
                          value: 60,
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
                            '60',
                            style: TextStyle(
                                color: const Color(0xFFDF5F2D),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    isCardView ? 16 : _annotationTextSize),
                          ))
                    ])
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: SfRadialGauge(
              title: GaugeTitle(text: "Throtle"),
              axes: <RadialAxis>[
                RadialAxis(
                    startAngle: 180,
                    endAngle: 360,
                    canScaleToFit: true,
                    showLastLabel: true,
                    interval: 20,
                    labelFormat: '{value}%',
                    labelsPosition: ElementsPosition.outside,
                    minorTickStyle: const MinorTickStyle(
                        length: 0.05, lengthUnit: GaugeSizeUnit.factor),
                    majorTickStyle: const MajorTickStyle(
                        length: 0.1, lengthUnit: GaugeSizeUnit.factor),
                    minorTicksPerInterval: 5,
                    pointers: const <GaugePointer>[
                      NeedlePointer(
                          value: 20,
                          needleEndWidth: 3,
                          needleLength: 0.6,
                          knobStyle: KnobStyle(
                            knobRadius: 8,
                            sizeUnit: GaugeSizeUnit.logicalPixel,
                          ),
                          tailStyle: TailStyle(
                              width: 3,
                              lengthUnit: GaugeSizeUnit.logicalPixel,
                              length: 20))
                    ],
                    axisLabelStyle: const GaugeTextStyle(
                        fontWeight: FontWeight.w300, fontSize: 8),
                    axisLineStyle: const AxisLineStyle(
                        thickness: 3, color: Color(0xFF00A8B5))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[300],
            child: const Text('Sound of screams but the'),
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

// SfRadialGauge(
//       axes: <RadialAxis>[
//         RadialAxis(
//             showAxisLine: false,
//             radiusFactor: 1,
//             canRotateLabels: true,
//             tickOffset: 0.32,
//             offsetUnit: GaugeSizeUnit.factor,
//             onLabelCreated: _handleAxisLabelCreated,
//             startAngle: 270,
//             endAngle: 270,
//             labelOffset: 0.05,
//             maximum: 360,
//             minimum: 0,
//             interval: 30,
//             minorTicksPerInterval: 4,
//             axisLabelStyle: GaugeTextStyle(
//                 color: const Color(0xFF949494),
//                 fontSize: isCardView ? 10 : _labelFontSize),
//             minorTickStyle: const MinorTickStyle(
//                 color: Color(0xFF616161),
//                 thickness: 1.6,
//                 length: 0.058,
//                 lengthUnit: GaugeSizeUnit.factor),
//             majorTickStyle: const MajorTickStyle(
//                 color: Color(0xFF949494),
//                 thickness: 2.3,
//                 length: 0.087,
//                 lengthUnit: GaugeSizeUnit.factor),
//             backgroundImage: const AssetImage('images/dark_theme_gauge.png'),
//             pointers: <GaugePointer>[
//               MarkerPointer(
//                   value: 90,
//                   color: const Color(0xFFDF5F2D),
//                   enableAnimation: true,
//                   animationDuration: 1200,
//                   markerOffset: isCardView ? 0.69 : _markerOffset,
//                   offsetUnit: GaugeSizeUnit.factor,
//                   markerType: MarkerType.triangle,
//                   markerHeight: isCardView ? 8 : _markerHeight,
//                   markerWidth: isCardView ? 8 : _markerWidth)
//             ],
//             annotations: <GaugeAnnotation>[
//               GaugeAnnotation(
//                   angle: 270,
//                   positionFactor: _positionFactor,
//                   widget: Text(
//                     '90',
//                     style: TextStyle(
//                         color: const Color(0xFFDF5F2D),
//                         fontWeight: FontWeight.bold,
//                         fontSize: isCardView ? 16 : _annotationTextSize),
//                   ))
//             ])
//       ],
//     );

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
  double _labelFontSize = 5;
  bool isCardView = false;
}
