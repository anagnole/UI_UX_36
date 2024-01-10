import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

 @override
  _HomePageState createState() => _HomePageState();
}

//hello

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
    );
  }
}
