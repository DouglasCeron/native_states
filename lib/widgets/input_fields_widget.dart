import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  TextEditingController? input;
  String? label;
  InputFields({
    this.input,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'campo $label obrigatório';
        }
      },
      controller: input,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      inputFormatters: [
        CurrencyTextInputFormatter(
          turnOffGrouping: true,
          locale: 'pt_BR',
          symbol: '',
          decimalDigits: 2,
        ),
      ],
    );
  }
}
