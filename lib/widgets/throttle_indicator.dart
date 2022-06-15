import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ThrottleIndicator extends StatelessWidget {
  const ThrottleIndicator({
    Key? key,
    required this.value,
    required this.id,
    this.labelFontSize = 7.0,
    this.labelOffset = 0.0,
  }) : super(key: key);

  final double labelFontSize;
  final double labelOffset;
  final double value;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          showLastLabel: true,
          radiusFactor: 1,
          canRotateLabels: true,
          tickOffset: 0.32,
          offsetUnit: GaugeSizeUnit.factor,
          startAngle: 270,
          endAngle: 230,
          labelOffset: labelOffset,
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
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 270,
                verticalAlignment: GaugeAlignment.far,
                positionFactor: 0.33,
                widget: Text('ENGINE $id',
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Times',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 6))),
            const GaugeAnnotation(
                angle: 90,
                verticalAlignment: GaugeAlignment.far,
                positionFactor: 0.42,
                widget: Text('RPM',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Times',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 6))),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
                value: value,
                animationDuration: 100,
                animationType: AnimationType.linear,
                enableAnimation: true,
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
