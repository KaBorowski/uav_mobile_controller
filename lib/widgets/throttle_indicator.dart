import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ThrottleIndicator extends StatelessWidget {
  const ThrottleIndicator({
    Key? key,
    required this.value,
    this.labelFontSize = 7.0,
  }) : super(key: key);

  final double labelFontSize;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
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
                value: value,
                needleEndWidth: 3,
                needleLength: 0.6,
                needleColor: const Color(0xFFFFFF00),
                knobStyle: const KnobStyle(
                  knobRadius: 8,
                  color: Color(0xFFFFFF00),
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                ),
                tailStyle: const TailStyle(
                    width: 3,
                    color: Color(0xFFFFFF00),
                    lengthUnit: GaugeSizeUnit.logicalPixel,
                    length: 20))
          ],
        ),
      ],
    );
  }
}
