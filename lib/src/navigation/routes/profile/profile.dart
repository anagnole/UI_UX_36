import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/navigation/routes/profile/Widgets/Stat_box.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/src/app_state.dart';

import 'dart:math';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  bool _isEditing = false;
  late String _userName = 'John Doe'; // Replace with the initial user name

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
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

  void _endEditing() {
    setState(() {
      _isEditing = false;
      _userName = _nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.fetchNonCompletedTasks(); 
    appState.fetchCompletedTasks();
    appState.totalTasksByCategory();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              Container(
                  padding: const EdgeInsets.all(48.0),
                  decoration: BoxDecoration(
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
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Column(
                    children: [
                      Container(
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              height: 8,
                            ),
                            _isEditing
                                ? TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your name',
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _userName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Image.asset(
                                            "assets/images/mode_edit_24px.png"),
                                        onPressed: _startEditing,
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      if (_isEditing)
                        ElevatedButton(
                          onPressed: _endEditing,
                          child: const Text('Save'),
                        ),
                      const SizedBox(height: 24),
                      FutureBuilder(future: appState.futureCompletedTasks,
                        builder: (context,snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );}
                          else{
                            final tasks = snapshot.data!;
                            int  length1=tasks.length;
                          return  StatBox(stat: 'Goals Completed: $length1');}
                        }
                      ),
                      const SizedBox(height: 24),FutureBuilder(future: appState.futureNonCompletedTasks,
                        builder: (context,snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );}
                          else{
                            final tasks = snapshot.data!;
                            int  length1=tasks.length;
                          return  StatBox(stat: 'Goals Remaining: $length1');}
                        }
                      ),
                      const SizedBox(height: 24),
                      FutureBuilder(future: appState.futureTaskNumByCategory,
                        builder: (context,snapshot) {

                          if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );}
                          else{
                            final sums = snapshot.data!;
                            int  fitness=sums[0];
                            int social=sums[1];
                            int study=sums[2];


                            int top=max(fitness,max(social,study));
                            String out="";
                            if (top==fitness && top==social && top==study){
                              if (top==0){
                                 out='Top Category: None, complete more tasks';
                              }
                              else{
                               out="Top Category: All of them";}
                            }
                            else if (top==fitness && top==social){
                                 out="Top Category: Fitness and Social";
                              }
                            
                            else if (top==fitness && top==study){
                                 out="Top Category: Fitness and Study";
                              }
                            else if (top==study && top==social){
                                 out="Top Category: Social and Study";
                              }
                            else if (top==study){
                               out = "Top Category: Study";
                            }
                            else if (top==fitness){
                               out = "Top Category: Fitness";
                            }
                            else if (top==social){
                               out = "Top Category: Social";
                            }
                            
                            
                          return  StatBox(stat: out);}
                        }
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
