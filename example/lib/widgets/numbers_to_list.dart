import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/my_random_item.dart';
import '../providers/list_of_my_random_item.dart';

class NumbersToList extends StatefulWidget {
  const NumbersToList({
    super.key,
    required this.allowNewNumbers,
  });

  final bool allowNewNumbers;

  @override
  State<NumbersToList> createState() => _NumbersToListState();
}

class _NumbersToListState extends State<NumbersToList> {
  final _controller = TextEditingController();

  void _addNumber() {
    if (_controller.text == '') _controller.text = '0';

    // We get a Provider of the List, so it can be fill as pleased. Notice that
    // the [notifyListeners] is automatically called.
    final itemsAsList = Provider.of<ListOfMyRandomItem>(context, listen: false);
    itemsAsList.add(MyRandomItem(
        title: 'Not named', value: double.parse(_controller.text)));

    _controller.text = '';
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We get a Consumer (or Provider) of the List, so it can be read as pleased
    return Consumer<ListOfMyRandomItem>(builder: (context, itemsAsList, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTitle(widget.allowNewNumbers),
          if (widget.allowNewNumbers) ..._buildAddingNumberSection(),
          ..._buildShowNumbers(itemsAsList),
        ],
      );
    });
  }

  Widget _buildTitle(bool allowNewNumbers) {
    return Text(
      allowNewNumbers
          ? 'You can add a number to the following list, and it should be '
              'reflected in the provider'
          : 'You can see the added numbers to the list',
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
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

  List<Widget> _buildShowNumbers(ListOfMyRandomItem itemsAsList) {
    return [
      const SizedBox(height: 10),
      Text(
        'The numbers are:',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      ...itemsAsList.map((e) => Text(
            e.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    ];
  }
}
