import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/service/models/key_word.dart';
import 'package:snapgoals_v2/src/app_state.dart';

class FilterChipExample extends StatefulWidget {
  final List<KeyWord> keyWords;
  const FilterChipExample({super.key, required this.keyWords});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  //Set<Keywords>   final List<KeyWord> keyWords;
  late List<KeyWord> keyWords;

  @override
  void initState() {
    keyWords = widget.keyWords;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 5.0,
            children: keyWords.map((keyword) {
              return FilterChip(
                selectedColor: Colors.blue,
                label: Text(keyword.word),
                selected: appState.chosenKeyWords.contains(keyword.id),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      appState.chosenKeyWords.add(keyword.id);
                    } else {
                      appState.chosenKeyWords.remove(keyword.id);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
