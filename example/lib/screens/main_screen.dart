import 'package:flutter/material.dart';

import './shared_data_first_screen.dart';
import './shared_data_second_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced containers demo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  'This apps shows how to use the [ListProvided] to share'
                  'information between pages.\n'
                  '\n'
                  'The modify page collect and allows to modify the enhanced '
                  'providers while the second only collects.\n'
                  '\n'
                  'Please note that [FirebaseProvided] is used the same way with '
                  'as the [ListProvided], with the slight difference that one must '
                  'provide the path in the database to store the information in '
                  'the constructor. An example is giving to the user but not'
                  'implemented (as one needs to configure Firebase before hand)',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, SharedDataFirstScreen.route),
                    child: const Text('Modify the providers')),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, SharedDataSecondScreen.route),
                    child: const Text('Show the providers')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
