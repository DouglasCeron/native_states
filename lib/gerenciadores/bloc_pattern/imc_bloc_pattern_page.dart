import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:native_states/gerenciadores/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:native_states/widgets/gauge/imc_gauge_grafic_set.dart';
import 'package:native_states/widgets/input_fields_widget.dart';

import 'imc_state.dart';

class BlocPatternPage extends StatefulWidget {
  const BlocPatternPage({Key? key}) : super(key: key);

  @override
  State<BlocPatternPage> createState() => _BlocPatternPageState();
}

class _BlocPatternPageState extends State<BlocPatternPage> {
  var pesoEC = TextEditingController();
  var alturaEC = TextEditingController();
  var controller = BlocPatternController();
  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var imc = snapshot.data?.imc ?? 0;
                    return ImcGaugeGraficSet(imc: imc);
                  },
                ),
                const SizedBox(height: 40),
                StreamBuilder(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var dataValue = snapshot.data;
                    if (dataValue is ImcStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (dataValue is ImcStateError) {
                      return Center(child: Text(dataValue.message));
                    }
                    return const SizedBox.shrink();
                  },
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
