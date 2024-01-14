import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/appbar_withx.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/filter_chip.dart';

typedef OnSubmitCallback = void Function(
    String title, String category, Uint8List picture, String description);

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
  final controllerDesctipion = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  final FocusNode textFocusNode = FocusNode();
  bool titleEmpty = false;
  

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.task?.title ?? '';
    controllerDesctipion.text = widget.task?.title ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    textFocusNode.dispose(); // Don't forget to dispose it
    super.dispose();
  }

  String _selectedCategory = 'fitness';

  @override
  Widget build(BuildContext context) {
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
            // Changed to ListView to accommodate the keyboard.
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
              /*const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Form(
                key: formKey2,
                child: TextField(
                  controller: controllerDesctipion,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter task description',
                    filled: true,
                    fillColor: Color.fromARGB(102, 255, 255, 255),
                  ),
                ),
              ),*/
              const Text(
                'Select Keywords',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const FilterChipExample(),
            

              const SizedBox(height: 27),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit(controllerTitle.text, _selectedCategory,
                          Uint8List(0), controllerDesctipion.text);
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
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

// class AlertCreateGoal extends StatelessWidget {
//   const AlertCreateGoal({
//     super.key,
//     required this.isEditing,
//     required this.formKey,
//     required this.textFocusNode,
//     required this.controller,
//     required this.widget,
//   });

//   final bool isEditing;
//   final GlobalKey<FormState> formKey;
//   final FocusNode textFocusNode;
//   final TextEditingController controller;
//   final CreateGoal widget;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         title: Text(isEditing ? 'Edit Goal' : 'Add Goal'),
//         content: Form(
//           key: formKey,
//           child: TextFormField(
//             autofocus: true,
//             focusNode: textFocusNode,
//             controller: controller,
//             decoration: const InputDecoration(hintText: 'Title'),
//             validator: (value) =>
//                 value != null && value.isEmpty ? 'Title is required' : null,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (formKey.currentState!.validate()) {
//                 widget.onSubmit(controller.text);
//               }
//             },
//             child: const Text('OK'),
//           )
//         ]);
//   }
// }
