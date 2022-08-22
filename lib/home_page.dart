import 'package:flutter/material.dart';
import 'package:native_states/gerenciadores/change_notifier/imc_change_notifier_page.dart';
import 'package:native_states/gerenciadores/setstate/imc_setstate_page.dart';
import 'package:native_states/gerenciadores/value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(' Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _goToPage(context, SetSatePage()),
                child: const Text('SetState'),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, ValueNotifierPage()),
                child: const Text('Value Notifier'),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, ChangeNotifierPage()),
                child: const Text('Change Notifier'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Bloc PAtter (Stream)'),
              ),
            ],
          ),
        ));
  }
}
