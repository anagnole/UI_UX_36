import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/service/models/key_word.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/appbar_withx.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/filter_chip.dart';

typedef OnSubmitCallback = void Function(
    String title, String category, Uint8List picture, List<int> keyIds);

class CreateGoal extends StatefulWidget {
  final Task? task;
  final OnSubmitCallback onSubmit;

  const CreateGoal({
    super.key,
    this.task,
    required this.onSubmit,
  });

  @override
  State<CreateGoal> createState() => _CreateGoal();
}

class _CreateGoal extends State<CreateGoal> {
  final controllerTitle = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FocusNode textFocusNode = FocusNode();
  bool titleEmpty = false;

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.task?.title ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    super.dispose();
  }

  String _selectedCategory = 'fitness';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.fetchKeyWordsByCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const SnapGoalsAppBar2(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              const Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Form(
                key: formKey,
                child: TextFormField(
                  maxLength: 30,
                  autofocus: true,
                  focusNode: textFocusNode,
                  controller: controllerTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter task title',
                    filled: true,
                    fillColor: Color.fromARGB(102, 255, 255, 255),
                  ),
                  validator: (value) {
                    final isTitleEmpty = value == null || value.isEmpty;
                    if (isTitleEmpty != titleEmpty) {
                      setState(() {
                        titleEmpty = isTitleEmpty;
                      });
                    }
                    return isTitleEmpty ? 'Title is required' : null;
                  },
                ),
              ),
              SizedBox(height: titleEmpty ? 0 : 24),
              const Text(
                'Category Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                title: const Text('fitness'),
                value: 'fitness',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? 'fitness';
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('study'),
                value: 'study',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? 'study';
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('social'),
                value: 'social',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? 'social';
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Select Keywords',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<KeyWord>>(
                future: appState.futureKeyWordsByCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final keyWords = snapshot.data!;

                    return FilterChipExample(keyWords: keyWords);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 27),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    appState.notify();
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit(controllerTitle.text, _selectedCategory,
                          Uint8List(0), appState.chosenKeyWords);
                      Navigator.of(context).pop();
                    }
                    appState.chosenKeyWords = [];
                    appState.notify();
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B8BB1),
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
