import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './shared_data_first_screen.dart';
import '../providers/list_of_my_random_item.dart';
import '../providers/map_of_my_random_item.dart';

class SharedDataSecondScreen extends StatelessWidget {
  const SharedDataSecondScreen({super.key});

  static const String route = '/shared-data-second-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced containers demo (Page 2)')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Navigate throughout the app',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Home page')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, SharedDataFirstScreen.route),
                      child: const Text('First shared data page')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _AddNumbersToList(),
                  SizedBox(width: 40),
                  _AddNumbersToMap(),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddNumbersToList extends StatefulWidget {
  const _AddNumbersToList({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddNumbersToList> createState() => _AddNumbersToListState();
}

class _AddNumbersToListState extends State<_AddNumbersToList> {
  @override
  Widget build(BuildContext context) {
    // We get a consumer (or Provider) of the List, so it can be read as pleased
    return Consumer<ListOfMyRandomItem>(
        builder: (context, itemsAsList, static) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              'You can see the added numbers\nfrom the list on Page 1',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          ...itemsAsList
              .map((e) => Text(
                    e.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ))
              .toList(),
        ],
      );
    });
  }
}

class _AddNumbersToMap extends StatefulWidget {
  const _AddNumbersToMap({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddNumbersToMap> createState() => _AddNumbersToMapState();
}

class _AddNumbersToMapState extends State<_AddNumbersToMap> {
  @override
  Widget build(BuildContext context) {
    // We get a Provider (or Consumer) of the Map, so it can be read as pleased
    final itemsAsMap = Provider.of<MapOfMyRandomItem>(context, listen: false);
    final List<Widget> listToShow = [];
    for (final key in itemsAsMap.keys) {
      listToShow.add(Text(
        '\'$key\': ${itemsAsMap[key].toString()}',
        style: Theme.of(context).textTheme.bodyText1,
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            'You can see the added numbers\nfrom the map on Page 1',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        ...listToShow,
      ],
    );
  }
}
