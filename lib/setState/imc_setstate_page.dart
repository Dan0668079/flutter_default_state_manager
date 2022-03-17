import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcSetstatePage extends StatefulWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {

  //!criando o TextEditingController para recuperar os valores digitados no peso e altura
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  //! criando uma global key para validar o formulário
  final formkey = GlobalKey<FormState>();
  var imc = 0.0; //! criando a variavel de estado 0.0 pois quero que seja um doble e não quero declarar ele.

  
  // Método para Calcular o Imc
  //passando dois parametros obrigatórios //! peso e altura
  Future<void> _calcularIMC({required double peso, required double altura}) async {
    //! só para criar o efeito do ponteiro zerar e voltar o marcador
    setState(() {
      imc = 0; //retorna no 0
    });
    await Future.delayed(const Duration(seconds: 1),); //colocando o tempo para poder visualizar

//para atualizar qualquer váriavel qualquer estado preciso do//! método seState
    setState(() {
      imc = peso / pow(altura, 2); //? elevado pow o campo , o expoente
    });
  }

  @override
  //! como criamos os controles precisamos também encerrar usamos o dispose
  void dispose() {
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
        child: Form(
          key: formkey, //**validando foi criado uma global key linha 19 */
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ImcGauge(imc: imc), //!substuido o componentes pela classe ImcGauge
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
                  controller: alturaEC, //! usando o controller no meu formulário
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

                      _calcularIMC(peso: peso, altura: altura);
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
