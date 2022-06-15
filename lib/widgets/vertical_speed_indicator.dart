import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VerticalSpeedIndicator extends StatelessWidget {
  const VerticalSpeedIndicator({
    Key? key,
    required this.value,
    this.labelFontSize = 7.0,
    this.labelOffset = 0.0,
  }) : super(key: key);

  final double labelFontSize;
  final double labelOffset;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          showLastLabel: true,
          radiusFactor: 1,
          canRotateLabels: false,
          tickOffset: 0.32,
          offsetUnit: GaugeSizeUnit.factor,
          startAngle: 90,
          endAngle: 270,
          labelOffset: labelOffset,
          maximum: 0.5,
          minimum: -0.5,
          interval: 0.5,
          minorTicksPerInterval: 15,
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
          annotations: const <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 270,
                verticalAlignment: GaugeAlignment.far,
                positionFactor: 0.33,
                widget: Text('VERTICAL SPEED',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Times',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 6)))
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
                value: value,
                animationDuration: 100,
                animationType: AnimationType.linear,
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
