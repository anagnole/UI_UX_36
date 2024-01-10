import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Text(
        'Goals page',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
