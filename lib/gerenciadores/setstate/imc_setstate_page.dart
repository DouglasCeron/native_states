import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:native_states/widgets/gauge/imc_gauge_grafic_set.dart';
import 'package:native_states/widgets/input_fields_widget.dart';

class SetSatePage extends StatefulWidget {
  const SetSatePage({Key? key}) : super(key: key);

  @override
  State<SetSatePage> createState() => _SetSatePageState();
}

class _SetSatePageState extends State<SetSatePage> {
  var pesoEC = TextEditingController();
  var alturaEC = TextEditingController();

  var formkey = GlobalKey<FormState>();

  double imc = 0;

  void _calculoImc({required double peso, required double altura}) async {
    setState(() {
      imc = 0;
    });

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      imc = peso / pow(altura, 2);
    });
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetStatePage'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ImcGaugeGraficSet(
                  imc: imc,
                ),
                const SizedBox(
                  height: 40,
                ),
                InputFields(
                  label: 'Peso',
                  input: pesoEC,
                ),
                InputFields(
                  label: 'altura',
                  input: alturaEC,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formkey.currentState?.validate() ?? false;
                      var message = 'Campos invalidos';
                      if (formValid) {
                        message = 'Campos Validos';
                        var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR',
                          decimalDigits: 2,
                        );
                        double peso = formatter.parse(pesoEC.text) as double;
                        double altura = formatter.parse(alturaEC.text) as double;
                        _calculoImc(peso: peso, altura: altura);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                    child: const Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
