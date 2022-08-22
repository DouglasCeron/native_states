import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:native_states/gerenciadores/change_notifier/imc_change_notifier_controller.dart';
import 'package:native_states/widgets/gauge/imc_gauge_grafic_set.dart';
import 'package:native_states/widgets/input_fields_widget.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  var pesoEC = TextEditingController();
  var alturaEC = TextEditingController();
  var controller = ChangeNotifierController();

  var formkey = GlobalKey<FormState>();

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
        title: const Text('ChangeNotifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, child) {
                    return ImcGaugeGraficSet(
                      imc: controller.imc,
                    );
                  },
                ),
                const SizedBox(height: 40),
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

                      controller.calculoImc(peso: peso, altura: altura);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
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
