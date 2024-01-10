import 'package:flutter/material.dart';
import '../../../appbar_withx.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: const SnapGoalsAppBar2(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _isEditing
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              _userName,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Image.asset("assets/images/mode_edit_24px.png"),
                            onPressed: _startEditing,
                          ),
                        ],
                      ),
                    ),
              if (_isEditing)
                ElevatedButton(
                  onPressed: _endEditing,
                  child: const Text('Save'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
