import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';

class CreateGoal extends StatefulWidget {
  final Task? task;
  final ValueChanged<String> onSubmit;

  const CreateGoal({
    Key? key,
    this.task,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CreateGoal> createState() => _CreateGoal();
}

class _CreateGoal extends State<CreateGoal> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller.text = widget.task?.title ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    textFocusNode.dispose(); // Don't forget to dispose it
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return AlertDialog(
        title: Text(isEditing ? 'Edit Goal' : 'Add Goal'),
        content: Form(
          key: formKey,
          child: TextFormField(
            autofocus: true,
            focusNode: textFocusNode,
            controller: controller,
            decoration: const InputDecoration(hintText: 'Title'),
            validator: (value) =>
                value != null && value.isEmpty ? 'Title is required' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.onSubmit(controller.text);
              }
            },
            child: const Text('OK'),
          )
        ]);
  }
}
