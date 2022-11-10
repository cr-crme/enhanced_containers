import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './shared_data_second_screen.dart';
import '../models/my_random_item.dart';
import '../providers/list_of_my_random_item.dart';
import '../providers/map_of_my_random_item.dart';

/// Here is an example on how to actually call and fill the [ListProvided] and
/// [MapProvided]. See repectively [_AddNumbersToList] and [_AddNumbersToMap].

class SharedDataFirstScreen extends StatelessWidget {
  const SharedDataFirstScreen({super.key});

  static const String route = '/shared-data-first-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced containers demo (Page 1)')),
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
                          context, SharedDataSecondScreen.route),
                      child: const Text('Second shared data page')),
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
  final _controller = TextEditingController();

  void _addNumber() {
    if (_controller.text == '') _controller.text = '0';

    // We get a Provider of the List, so it can be fill as pleased. Notice that
    // the [notifyListeners] is automatically called
    final itemsAsList = Provider.of<ListOfMyRandomItem>(context, listen: false);
    itemsAsList.add(MyRandomItem('Not named', double.parse(_controller.text)));

    _controller.text = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // We get a consumer (or Provider) of the List, so it can be read as pleased
    return Consumer<ListOfMyRandomItem>(builder: (context, itemsAsList, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              'You can add a number to the following list,\n'
              'and it should be reflected in the second page',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 175,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter a number',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) => newValue.copyWith(
                          text: newValue.text.replaceAll(',', '.'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: _addNumber, child: const Text('Submit')),
            ],
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
  final _controller = TextEditingController();

  static int _counter = 0;

  void _addNumber() {
    if (_controller.text == '') _controller.text = '0';

    // We get a Provider of the Map, so it can be fill as pleased. Notice that
    // the [notifyListeners] is automatically called
    final itemsAsMap = Provider.of<MapOfMyRandomItem>(context, listen: false);
    itemsAsMap[_counter.toString()] =
        MyRandomItem('Not named', double.parse(_controller.text));

    _controller.text = '';
    _counter++;
    setState(() {});
  }

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
            'You can add a number to the following map,\n'
            'and it should be reflected in the second page',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 175,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter a number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll(',', '.'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(onPressed: _addNumber, child: const Text('Submit')),
          ],
        ),
        ...listToShow,
      ],
    );
  }
}
