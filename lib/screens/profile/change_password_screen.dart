import 'package:flutter/material.dart';
import '../../services/database/database_helper.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int userId;

  const ChangePasswordScreen({super.key, required this.userId});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentCtrl = TextEditingController();
  final newCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: currentCtrl,
              decoration: const InputDecoration(labelText: "Current Password"),
              obscureText: true,
            ),
            TextField(
              controller: newCtrl,
              decoration: const InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Change Password"),
              onPressed: () async {
                await DatabaseHelper.instance
                    .updatePassword(widget.userId, newCtrl.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
