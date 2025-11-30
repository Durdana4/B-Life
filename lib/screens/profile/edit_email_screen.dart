import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';

class EditEmailScreen extends StatefulWidget {
  final UserModel user;
  const EditEmailScreen({super.key, required this.user});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  late TextEditingController emailCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController(text: widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Email"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "New Email"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                widget.user.email = emailCtrl.text;
                await DatabaseHelper.instance.updateUser(widget.user);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
