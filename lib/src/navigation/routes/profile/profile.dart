import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/src/navigation/routes/profile/Widgets/Stat_box.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/src/app_state.dart';

import 'dart:math';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  Future<void> _endEditing(String newText) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newText);
    setState(() {
      _isEditing = false;
      _nameController = TextEditingController(text: newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    _nameController = TextEditingController(text: appState.name);

    appState.fetchNonCompletedTasks();
    appState.fetchCompletedTasks();
    appState.totalTasksByCategory();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 0.1,
                right: screenWidth * 0.05,
                left: screenWidth * 0.05,
                top: screenHeight * 0.1),
            child: Container(
                padding: const EdgeInsets.all(48.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0,
                        0.5,
                        1.0
                      ],
                      colors: <Color>[
                        Color(0xFFFFFFFF),
                        Colors.grey,
                        Color(0xFFFFFFFF)
                      ]),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B8BB1),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Viga',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                            height: 1,
                          ),
                          Expanded(
                            child: _isEditing
                                ? Transform.translate(
                                    offset: const Offset(0, 2),
                                    child: SizedBox(
                                      height: 40,
                                      child: Transform.translate(
                                        offset: const Offset(0, 8),
                                        child: TextField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter your name',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        appState.name!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                            "assets/images/icon.svg"),
                                        onPressed: _startEditing,
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                    if (_isEditing)
                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            await _endEditing(_nameController.text);
                            appState.name = _nameController.text;

                            appState.notify();
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    const SizedBox(height: 24),
                    FutureBuilder(
                        future: appState.futureCompletedTasks,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final tasks = snapshot.data!;
                            int length1 = tasks.length;
                            return StatBox(stat: 'Goals Completed: $length1');
                          }
                        }),
                    const SizedBox(height: 24),
                    FutureBuilder(
                        future: appState.futureNonCompletedTasks,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final tasks = snapshot.data!;
                            int length1 = tasks.length;
                            return StatBox(stat: 'Goals Remaining: $length1');
                          }
                        }),
                    const SizedBox(height: 24),
                    FutureBuilder(
                        future: appState.futureTaskNumByCategory,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            final sums = snapshot.data!;
                            int fitness = sums[0];
                            int social = sums[1];
                            int study = sums[2];

                            int top = max(fitness, max(social, study));
                            String out = "";
                            if (top == fitness &&
                                top == social &&
                                top == study) {
                              if (top == 0) {
                                out = 'Top Category: None, complete more tasks';
                              } else {
                                out = "Top Category: All of them";
                              }
                            } else if (top == fitness && top == social) {
                              out = "Top Category: Fitness and Social";
                            } else if (top == fitness && top == study) {
                              out = "Top Category: Fitness and Study";
                            } else if (top == study && top == social) {
                              out = "Top Category: Social and Study";
                            } else if (top == study) {
                              out = "Top Category: Study";
                            } else if (top == fitness) {
                              out = "Top Category: Fitness";
                            } else if (top == social) {
                              out = "Top Category: Social";
                            }

                            return StatBox(stat: out);
                          }
                        }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
