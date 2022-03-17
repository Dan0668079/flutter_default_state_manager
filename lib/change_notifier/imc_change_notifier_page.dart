import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_manager/change_notifier/imc_change_notifier_controller.dart';
import 'package:flutter_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {
  final controller = ImcChangeNotifierController(); // criando a instancia dela
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formkey = GlobalKey<FormState>();
  //var imc = 0.0; //! criando a variavel de estado 0.0 pois quero que seja um doble e não quero declarar ele. OBS: não é mais preciso, neste caso foi criado no controller.

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build Tela");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc Change Notifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey, //**validando foi criado uma global key linha 19 */
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: controller,//! serve como ouvinte nas alterações
                    builder: (context, child) {
                      print("AnimatedBuilder");
                      return ImcGauge(imc: controller.imc);
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pesoEC, //! usando o controller no meu formulário
                  keyboardType: // faz abrir só o teclado numérico sem letras
                      TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    // foi adicionado nas dependencias
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR', // coloca a virgula ao invés do ponto
                      symbol: '', // retirar o simbolo do Br
                      turnOffGrouping:
                          true, // retira o ponto de separação do milhar
                      decimalDigits: 2, //numeros de digitos permitido
                    )
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso Obrigatório';
                    }
                  },
                ),
                TextFormField(
                  controller:
                      alturaEC, //! usando o controller no meu formulário
                  keyboardType:
                      TextInputType.number, // faz abrir só o teclado numérico
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    // foi adicionado nas dependencias
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR', // coloca a virgula ao invés do ponto
                      symbol: '', // retirar o simbolo do Br
                      turnOffGrouping:
                          true, // retira o ponto de separação do milhar
                      decimalDigits: 2, //numeros de digitos permitido
                    )
                  ],
                  //! adcionando o validator linha 19 e 47 para entender
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura Obrigatória';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formkey.currentState?.validate() ?? false;

                    if (formValid) {
                      //! o valor está vindo assim ex: 67,00 preciso converter para . usar pacote intl
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_Br', decimalDigits: 2);

                      // double peso = pesoEC.text;
                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;

                      controller.calcularIMC(peso: peso, altura: altura);

                      // _calcularIMC(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
