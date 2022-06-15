import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HeadingIndicator extends StatelessWidget {
  const HeadingIndicator({
    Key? key,
    required this.compassValue,
    this.labelFontSize = 7.0,
    this.labelOffset = 0.0,
  }) : super(key: key);

  final double labelFontSize;
  final double labelOffset;
  final double compassValue;

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
          onLabelCreated: _handleAxisLabelCreated,
          startAngle: -compassValue - 90,
          endAngle: -compassValue - 90,
          labelOffset: labelOffset,
          maximum: 360,
          minimum: 0,
          interval: 30,
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
          backgroundImage:
              const AssetImage('images/dark_theme_gauge_plane.png'),
        )
      ],
    );
  }

  /// Handled callback for change numeric value to compass directional letter.
  void _handleAxisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '360') {
      args.text = '';
    } else {
      args.labelStyle = GaugeTextStyle(
          color: const Color(0xFFFFFF00), fontSize: labelFontSize);
      if (args.text == '0') {
        args.text = 'N';
      } else if (args.text == '180') {
        args.text = 'S';
      } else if (args.text == '270') {
        args.text = 'W';
      } else if (args.text == '90') {
        args.text = 'E';
      } else {
        args.labelStyle = GaugeTextStyle(
            color: const Color(0xFFFFFFFF), fontSize: labelFontSize);
      }
    }
  }
}
