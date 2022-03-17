import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRange extends GaugeRange {
  ImcGaugeRange({Key? key, //!criando um construtor
    required Color color,
    required double start,
    required double end,
    required String label,
  }) : super(key: key, //! passando para o meu super a classe em si
            startValue: start,
            endValue: end,
            color: color,
            label: label,
            sizeUnit: GaugeSizeUnit.factor,
            labelStyle: const GaugeTextStyle(fontFamily: 'Times', fontSize: 12),
            startWidth: 0.65, //! define a largura do gráfico
            endWidth: 0.65);
}
