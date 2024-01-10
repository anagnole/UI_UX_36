import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'navigation/navigator.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
            // return MaterialApp(
            //   theme: ThemeData(useMaterial3: true),
            //   home: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage('assets/images/background.png'),
            //         fit: BoxFit.fill,
          ),
          child: const MyNavigator(),
        ),
      ),
    );
  }
}
