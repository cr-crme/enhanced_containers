import 'package:flutter/material.dart';

import './shared_data_second_screen.dart';
import '../widgets/numbers_to_list.dart';
import '../widgets/numbers_to_map.dart';

/// Here is an example on how to actually call and fill the [ListProvided] and
/// [MapProvided]. See repectively [_AddNumbersToList] and [_AddNumbersToMap].

class SharedDataFirstScreen extends StatelessWidget {
  const SharedDataFirstScreen({super.key});

  static const String route = '/shared-data-first-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifying the providers')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Navigate throughout the app',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Home page')),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, SharedDataSecondScreen.route),
                        child: const Text(
                          'Show the providers',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Flexible(child: NumbersToList(allowNewNumbers: true)),
                  SizedBox(width: 40),
                  Flexible(child: NumbersToMap(allowNewNumbers: true)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
