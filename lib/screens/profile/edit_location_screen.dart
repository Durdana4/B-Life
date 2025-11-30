import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';

class EditLocationScreen extends StatefulWidget {
  final UserModel user;

  const EditLocationScreen({super.key, required this.user});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  String? selectedRegion;

  final List<String> uzRegions = [
    "Tashkent",
    "Tashkent Region",
    "Samarkand",
    "Bukhara",
    "Andijan",
    "Fergana",
    "Namangan",
    "Khorezm",
    "Surxondaryo",
    "Qashqadaryo",
    "Sirdaryo",
    "Jizzakh",
    "Navoiy",
    "Karakalpakstan",
  ];

  @override
  void initState() {
    super.initState();
    selectedRegion = widget.user.location;
  }

  Future<void> _saveLocation() async {
    final updatedUser = widget.user.copyWith(
      location: selectedRegion!,
    );

    await DatabaseHelper.instance.updateUser(updatedUser);

    Navigator.pop(context, true); // return success to profile page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Location"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select your region",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedRegion,
              items: uzRegions
                  .map((r) => DropdownMenuItem(
                value: r,
                child: Text(r),
              ))
                  .toList(),
              onChanged: (v) => setState(() {
                selectedRegion = v;
              }),
              decoration: const InputDecoration(
                labelText: "Region",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              v == null ? "Please select your region" : null,
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedRegion != null) _saveLocation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
