import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/service/database/database_service.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/onboarding/onboarding.dart';
import 'navigation/navigator.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> checkOnboardingCompleted() async {
      final prefs = await SharedPreferences.getInstance();
      //final database = await DatabaseService().database;
      return prefs.getBool('hasCompletedOnBoarding') ?? false;
    }

    return FutureBuilder<bool>(
      future: checkOnboardingCompleted(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/images/splashScreen.png'),
              fit: BoxFit.cover,
            )));
          case ConnectionState.waiting:
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/images/splashScreen.png'),
              fit: BoxFit.cover,
            )));
          case ConnectionState.active:
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/images/splashScreen.png'),
              fit: BoxFit.cover,
            )));
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                image: AssetImage('assets/images/splashScreen.png'),
                fit: BoxFit.cover,
              )));
              ;
            } else {
              final hasCompletedOnBoarding = snapshot.data!;
              return ChangeNotifierProvider(
                create: (context) => AppState(),
                child: MaterialApp(
                  theme: ThemeData(useMaterial3: true),
                  initialRoute: hasCompletedOnBoarding ? '/' : '/onboarding',
                  routes: {
                    '/': (context) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const MyNavigator(index: 1),
                        ),
                    '/goals': (context) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const MyNavigator(index: 2),
                        ),
                    '/onboarding': (context) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const OnBoarding(),
                        ),
                  },
                ),
              );
            }
        }
      },
    );
  }
}
