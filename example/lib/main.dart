import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:enhanced_containers_example/providers/list_of_my_random_item.dart';
import 'package:enhanced_containers_example/providers/map_of_my_random_item.dart';
import 'package:enhanced_containers_example/screens/main_screen.dart';
import 'package:enhanced_containers_example/screens/shared_data_first_screen.dart';
import 'package:enhanced_containers_example/screens/shared_data_second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ListOfMyRandomItem()),
          ChangeNotifierProvider(create: (context) => MapOfMyRandomItem()),
        ],
        child: MaterialApp(
          title: 'Enhanced containers demo',
          initialRoute: MainScreen.route,
          routes: {
            MainScreen.route: (context) => const MainScreen(),
            SharedDataFirstScreen.route: (context) =>
                const SharedDataFirstScreen(),
            SharedDataSecondScreen.route: (context) =>
                const SharedDataSecondScreen(),
          },
        ));
  }
}
