import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/my_random_item.dart';
import '../providers/map_of_my_random_item.dart';

class NumbersToMap extends StatefulWidget {
  const NumbersToMap({
    Key? key,
    required this.allowNewNumbers,
  }) : super(key: key);

  final bool allowNewNumbers;

  @override
  State<NumbersToMap> createState() => _NumbersToMapState();
}

class _NumbersToMapState extends State<NumbersToMap> {
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
    // We get a Consumer (or Provider) of the Map, so it can be read as pleased
    return Consumer<MapOfMyRandomItem>(builder: (context, itemsAsMap, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(widget.allowNewNumbers),
          if (widget.allowNewNumbers) ..._buildAddingNumberSection(),
          ..._buildShowNumbers(itemsAsMap),
        ],
      );
    });
  }

  Widget _buildTitle(bool allowNewNumbers) {
    return Flexible(
      child: Text(
        allowNewNumbers
            ? 'You can add a number to the following map, and it should be '
                'reflected in the provider'
            : 'You can see the added numbers to the map',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> _buildAddingNumberSection() {
    return [
      SizedBox(
        width: 175,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter a number',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
            TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
                text: newValue.text.replaceAll(',', '.'),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      ElevatedButton(onPressed: _addNumber, child: const Text('Submit')),
    ];
  }

  List<Widget> _buildShowNumbers(MapOfMyRandomItem itemsAsMap) {
    final List<Widget> listToShow = [];
    for (final key in itemsAsMap.keys) {
      listToShow.add(Text(
        '\'$key\': ${itemsAsMap[key].toString()}',
        style: Theme.of(context).textTheme.bodyText1,
      ));
    }

    return [
      const SizedBox(height: 10),
      Text(
        'The numbers are:',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      ...listToShow,
    ];
  }
}
