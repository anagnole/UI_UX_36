import 'package:flutter/material.dart';

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

enum Keywords {paper, test}

class _FilterChipExampleState extends State<FilterChipExample> {
  Set<Keywords> filters = <Keywords>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 5.0,
            children: Keywords.values.map((Keywords keyword) {
              return FilterChip(
                label: Text(keyword.name),
                selected: filters.contains(keyword),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(keyword);
                    } else {
                      filters.remove(keyword);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${filters.map((Keywords e) => e.name).join(', ')}',
            style: textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}