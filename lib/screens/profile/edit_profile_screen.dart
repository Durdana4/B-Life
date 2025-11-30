import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';
import 'edit_phone_screen.dart';
import 'edit_location_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController surnameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController passportCtrl;

  String? selectedGender;
  String? selectedBloodType;

  @override
  void initState() {
    super.initState();

    nameCtrl = TextEditingController(text: widget.user.name);
    surnameCtrl = TextEditingController(text: widget.user.surname);
    emailCtrl = TextEditingController(text: widget.user.email);
    passportCtrl = TextEditingController(text: widget.user.passportId);

    selectedGender = widget.user.gender;
    selectedBloodType = widget.user.bloodType;
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedUser = widget.user.copyWith(
      name: nameCtrl.text.trim(),
      surname: surnameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      gender: selectedGender!,
      bloodType: selectedBloodType!,
      passportId: passportCtrl.text.trim(),
    );

    await DatabaseHelper.instance.updateUser(updatedUser);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _section("Personal Information"),

              _input(nameCtrl, "Name"),
              _input(surnameCtrl, "Surname"),
              _input(emailCtrl, "Email", type: TextInputType.emailAddress),

              // PASSPORT ID FIELD
              _passportField(),

              const SizedBox(height: 20),
              _section("Gender"),

              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ["Male", "Female"]
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => selectedGender = v),
                validator: (v) => v == null ? "Please select gender" : null,
              ),

              const SizedBox(height: 20),
              _section("Blood Type"),

              DropdownButtonFormField<String>(
                value: selectedBloodType,
                items: ["I+", "I-", "II+", "II-", "III+", "III-", "IV+", "IV-"]
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (v) => setState(() => selectedBloodType = v),
                validator: (v) =>
                v == null ? "Please select blood type" : null,
              ),

              const SizedBox(height: 30),
              _section("Additional Settings"),

              _settingTile(
                "Phone Number",
                widget.user.phoneFormatted(),
                    () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditPhoneScreen(user: widget.user),
                    ),
                  );
                  if (updated == true) setState(() {});
                },
              ),

              _settingTile(
                "Location",
                widget.user.location,
                    () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditLocationScreen(user: widget.user),
                    ),
                  );
                  if (updated == true) setState(() {});
                },
              ),

              const SizedBox(height: 35),

              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Save Changes",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PASSPORT FIELD
  Widget _passportField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: passportCtrl,
        decoration: const InputDecoration(labelText: "Passport ID"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter passport ID";
          }

          final regex = RegExp(r"^[A-Z]{2}[0-9]{7}$");
          if (!regex.hasMatch(value)) {
            return "Format must be: AA1234567";
          }

          return null;
        },
      ),
    );
  }

  Widget _input(TextEditingController c, String label,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(labelText: label),
        validator: (v) =>
        v == null || v.trim().isEmpty ? "Please enter $label" : null,
      ),
    );
  }

  Widget _section(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _settingTile(String title, String value, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
