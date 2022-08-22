import 'package:flutter/material.dart';
import 'package:native_states/widgets/gauge/imc_gauge_grafic_set.dart';
import 'package:native_states/widgets/input_fields_widget.dart';

class MedidorImcTemplate extends StatefulWidget {
  const MedidorImcTemplate({Key? key}) : super(key: key);

  @override
  State<MedidorImcTemplate> createState() => _MedidorImcTemplateState();
}

class _MedidorImcTemplateState extends State<MedidorImcTemplate> {
  var pesoEC = TextEditingController();
  var alturaEC = TextEditingController();

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
        title: const Text('Template'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImcGaugeGraficSet(imc: 0),
              const SizedBox(
                height: 40,
              ),
              InputFields(
                label: 'Peso',
                input: pesoEC,
              ),
              InputFields(
                label: 'Altura',
                input: alturaEC,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
