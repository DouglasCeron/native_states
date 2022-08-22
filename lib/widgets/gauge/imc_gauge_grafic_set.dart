import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gauge_model.dart';

class ImcGaugeGraficSet extends StatelessWidget {
  final double imc;
  const ImcGaugeGraficSet({required this.imc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGaugeModel(
              color: Colors.blue,
              start: 12.5,
              end: 18.5,
              label: 'MAGREZA',
            ),
            ImcGaugeModel(
              color: Colors.green,
              start: 18.5,
              end: 24.5,
              label: 'NORMAL',
            ),
            ImcGaugeModel(
              color: Colors.yellow[600]!,
              start: 24.5,
              end: 29.9,
              label: 'SOBRE PESO',
            ),
            ImcGaugeModel(
              color: Colors.red[500]!,
              start: 29.9,
              end: 39.5,
              label: 'OBESO',
            ),
            ImcGaugeModel(
              color: Colors.red[900]!,
              start: 39.5,
              end: 49.5,
              label: 'OBESO',
            ),
          ],
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            ),
          ],
        ),
      ],
    );
  }
}
