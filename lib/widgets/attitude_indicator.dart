import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AttitudeIndicator extends StatelessWidget {
  const AttitudeIndicator({
    Key? key,
    required this.rollValue,
    required this.pitchValue,
    this.labelFontSize = 7.0,
    this.labelOffset = 0.0,
  }) : super(key: key);

  final double labelFontSize;
  final double labelOffset;
  final double rollValue;
  final double pitchValue;

  final double markerHeight = 170.0;
  final double markerWidth = 170.0;
  final double markerOffset = 0.94;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          radiusFactor: 1,
          canRotateLabels: true,
          tickOffset: 0.32,
          offsetUnit: GaugeSizeUnit.factor,
          startAngle: 180,
          endAngle: 180,
          labelOffset: labelOffset,
          maximum: 270,
          minimum: -90,
          showLastLabel: true,
          interval: 90,
          minorTicksPerInterval: 0,
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
          backgroundImage: const AssetImage('images/dark_theme_empty.png'),
          pointers: <GaugePointer>[
            MarkerPointer(
                value: rollValue,
                animationDuration: 100,
                animationType: AnimationType.linear,
                enableAnimation: true,
                color: const Color(0xFFDF5F2D),
                // enableAnimation: false,
                markerOffset: markerOffset,
                offsetUnit: GaugeSizeUnit.factor,
                markerType: MarkerType.image,
                imageUrl: 'images/attitude_inner_back.png',
                markerHeight: markerHeight,
                markerWidth: markerWidth),
            MarkerPointer(
                value: rollValue,
                animationDuration: 100,
                animationType: AnimationType.linear,
                enableAnimation: true,
                color: const Color(0xFFDF5F2D),
                // enableAnimation: false,
                markerOffset: markerOffset + pitchValue / 150.0,
                offsetUnit: GaugeSizeUnit.factor,
                markerType: MarkerType.image,
                imageUrl: 'images/attitude_inner_pointer.png',
                markerHeight: markerHeight,
                markerWidth: markerWidth),
            MarkerPointer(
                value: rollValue,
                animationDuration: 100,
                animationType: AnimationType.linear,
                color: const Color(0xFFDF5F2D),
                enableAnimation: true,
                markerOffset: markerOffset,
                offsetUnit: GaugeSizeUnit.factor,
                markerType: MarkerType.image,
                imageUrl: 'images/attitude_outer_pointer.png',
                markerHeight: markerHeight,
                markerWidth: markerWidth),
            MarkerPointer(
              value: 0.0,
              // enableAnimation: false,
              markerOffset: markerOffset,
              offsetUnit: GaugeSizeUnit.factor,
              markerType: MarkerType.image,
              imageUrl: 'images/attitude_const_pointer.png',
              markerHeight: markerHeight,
              markerWidth: markerWidth,
            ),
            const MarkerPointer(
                value: 0.0,
                elevation: 4,
                markerWidth: 12,
                markerHeight: 10,
                color: Color(0xFFFFFF00),
                offsetUnit: GaugeSizeUnit.factor,
                markerOffset: 0.25)
          ],
        )
      ],
    );
  }
}
