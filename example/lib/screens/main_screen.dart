import 'package:flutter/material.dart';

import './shared_data_first_screen.dart';
import './shared_data_second_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced containers demo (Home page)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                'This apps shows how to use the ListProvided\n'
                'to share information between pages.\n'
                '\n'
                'You can navigate to either of the page to see how information\n'
                'are shared using enhanced_containers',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SharedDataFirstScreen.route),
                child: const Text('First shared data page')),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SharedDataSecondScreen.route),
                child: const Text('Second shared data page')),
          ],
        ),
      ),
    );
  }
}
