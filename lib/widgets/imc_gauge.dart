import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gauge_range.dart';

class ImcGauge extends StatelessWidget {

  final double imc; //! receber no componente váriavel final imc

   const ImcGauge({Key? key, required this.imc}) : super(key: key); //!variavel nomeada imc

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge( //! este elemento cria o gráfico
      axes: [
        RadialAxis(
          showLabels: false, //apaga os campos do gráfico
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,  //valor inicial do potenciometro
          maximum: 47.9,  //valor final
          ranges: [ //! dividindo em 5 partes
            ImcGaugeRange(
              color: Colors.blue,
              start: 12.5,
              end: 18.5,
              label: 'MAGREZA',
            ),
            ImcGaugeRange(
              color: Colors.green,
              start: 18.6,
              end: 24.9,
              label: 'NORMAL',
            ),
            ImcGaugeRange(
              color: Colors.yellow[600]!,
              start: 25,
              end: 29.9,
              label: 'SOBREPESO',
            ),
            ImcGaugeRange(
              color: Colors.red[500]!,
              start: 30,
              end: 39.9,
              label: 'OBESIDADE',
            ),
            ImcGaugeRange(
              color: Colors.red[900]!,
              start: 40,
              end: 47.9,
              label: 'OBESIDADE GRAVE',
            )
          ],
          pointers: [ //! adicionando o ponteiro
            NeedlePointer(
              // value: 15,
              value: imc,
              enableAnimation: true,
            ),
          ],
        ),
      ],
    );
  }
}
