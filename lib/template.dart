import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_manager/widgets/imc_gauge.dart';


class ImcSetstatePage extends StatefulWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  @override
  void dispose(){
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc SetState'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
             ImcGauge(imc: 0),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pesoEC,
                keyboardType: TextInputType.number,// faz abrir só o teclado numérico
                decoration: const InputDecoration(labelText: 'Peso'),
                inputFormatters: [// foi adicionado nas dependencias
                  CurrencyTextInputFormatter(
                    locale: 'pt_BR', // coloca a virgula ao invés do ponto
                    symbol: '', // retirar o simbolo do Br
                    turnOffGrouping: true, // retira o ponto de separação do milhar
                    decimalDigits: 2, //numeros de digitos permitido
                  )
                ],
              ),
               TextFormField(
                 controller: alturaEC,
                keyboardType: TextInputType.number,// faz abrir só o teclado numérico
                decoration: const InputDecoration(labelText: 'Altura'),
                inputFormatters: [// foi adicionado nas dependencias
                  CurrencyTextInputFormatter(
                    locale: 'pt_BR', // coloca a virgula ao invés do ponto
                    symbol: '', // retirar o simbolo do Br
                    turnOffGrouping: true, // retira o ponto de separação do milhar
                    decimalDigits: 2, //numeros de digitos permitido
                  )
                ],
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){}, child: const Text('Calcular IMC'),),
            ],
          ),
        ),
      ),
    );
  }
}
