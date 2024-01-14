import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/home/widgets/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _name;

  @override
  void initState() {
    super.initState();
    _name = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    bool isNameInitialized = appState.name != null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
           Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [const Align(
              alignment: Alignment.centerLeft,
              child: Text('Your Progress',
                      style: TextStyle(
                              fontSize: 24.0, 
                              fontWeight: FontWeight.bold, 
                              fontFamily: 'Viga'
                            ),
                        textAlign: TextAlign.left
                    ),
            ),
          const SizedBox(height: 8),
          Material(
            elevation: 4.0,
            child: Container(
              color: const Color.fromARGB(255, 137, 136, 136),
              height: 2.0,
              
            ),
          ),]
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          const Center(child: PieChartWidget()),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          isNameInitialized
              ? Text('Hello ${appState.name}!',
                style: const TextStyle(
                            fontSize: 24.0, 
                            fontWeight: FontWeight.bold, 
                            fontFamily: 'Viga'
                          ),
              )
              : FutureBuilder<String>(
                  future: _name,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          appState.name = snapshot.data!;

                          return Text('Hello ${appState.name}!',
                          style: const TextStyle(
                            fontSize: 24.0, 
                            fontWeight: FontWeight.bold, 
                            fontFamily: 'Viga'
                          )
                          );
                        }
                    }
                  },
                ),
        ],
      ),
    );
  }
}
