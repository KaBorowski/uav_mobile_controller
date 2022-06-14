import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AltimeterIndicator extends StatelessWidget {
  const AltimeterIndicator({
    Key? key,
    required this.value,
    this.labelFontSize = 7.0,
  }) : super(key: key);

  final double labelFontSize;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          showLastLabel: false,
          radiusFactor: 1,
          canRotateLabels: false,
          tickOffset: 0.32,
          offsetUnit: GaugeSizeUnit.factor,
          // onLabelCreated: handleAxisLabelCreated,
          startAngle: 270,
          endAngle: 270,
          labelOffset: 0.05,
          maximum: 10,
          minimum: 0,
          interval: 1,
          minorTicksPerInterval: 4,
          axisLabelStyle: GaugeTextStyle(
              color: const Color(0xFF949494), fontSize: labelFontSize),
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
            NeedlePointer(
                value: value / 1000.0 % 10.0,
                needleEndWidth: 7,
                needleLength: 0.4,
                needleColor: const Color(0xFFFFFF00),
                knobStyle: const KnobStyle(
                  knobRadius: 8,
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderColor: Color.fromARGB(255, 255, 255, 255),
                  borderWidth: 1,
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                ),
                tailStyle: const TailStyle(
                    width: 6,
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderColor: Color.fromARGB(255, 255, 255, 255),
                    borderWidth: 1,
                    lengthUnit: GaugeSizeUnit.logicalPixel,
                    length: 20)),
            NeedlePointer(
                value: value / 100.0 % 10.0,
                needleEndWidth: 3,
                needleLength: 0.6,
                needleColor: Color(0xFFFFFF00),
                knobStyle: const KnobStyle(
                  knobRadius: 5,
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderColor: Color.fromARGB(255, 255, 255, 255),
                  borderWidth: 1,
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                ),
                tailStyle: const TailStyle(
                    width: 3,
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderColor: Color.fromARGB(255, 255, 255, 255),
                    borderWidth: 1,
                    lengthUnit: GaugeSizeUnit.logicalPixel,
                    length: 20)),
            NeedlePointer(
              value: value / 10000.0,
              needleEndWidth: 1,
              needleStartWidth: 1,
              needleLength: 0.7,
              needleColor: const Color(0xFFFFFF00),
            ),
            MarkerPointer(
                value: value / 10000.0,
                elevation: 4,
                markerWidth: 9,
                markerHeight: 7,
                color: const Color(0xFFFFFF00),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: 0.27)
          ],
        ),
      ],
    );
  }
}
