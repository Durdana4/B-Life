import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/database/database_helper.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  String? _selectedBloodType;

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _neededDateController = TextEditingController();

  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _extraInfoController = TextEditingController();

  // Blood types for dropdown
  final List<String> _bloodTypes = [
    "I+", "I-", "II+", "II-", "III+", "III-", "IV+", "IV-"
  ];

  Future<void> _saveRequest() async {
    if (_formKey.currentState!.validate()) {
      final newRequest = RequestModel(
        name: _nameController.text,
        surname: _surnameController.text,
        bloodType: _selectedBloodType ?? '',
        birthDate: _birthDateController.text,
        neededDate: _neededDateController.text,
        disease: _diseaseController.text,
        address: _addressController.text,
        contactNumber: _contactController.text,
        extraInfo: _extraInfoController.text,
      );

      await DatabaseHelper.instance.insertRequest(newRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request added successfully!")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a Request")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value!.isEmpty ? "Name is required" : null,
              ),

              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: "Surname"),
                validator: (value) =>
                value!.isEmpty ? "Surname is required" : null,
              ),

              // Blood Type Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Blood Type"),
                items: _bloodTypes
                    .map((bt) => DropdownMenuItem(
                  value: bt,
                  child: Text(bt),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodType = value;
                  });
                },
                validator: (value) =>
                value == null ? "Blood type is required" : null,
              ),

              TextFormField(
                controller: _birthDateController,
                decoration:
                const InputDecoration(labelText: "Birth Date"),
                validator: (value) =>
                value!.isEmpty ? "Birth date is required" : null,
              ),

              TextFormField(
                controller: _neededDateController,
                decoration: const InputDecoration(
                    labelText: "Date When Blood Needed"),
                validator: (value) =>
                value!.isEmpty ? "Required date is needed" : null,
              ),

              TextFormField(
                controller: _diseaseController,
                decoration: const InputDecoration(labelText: "Disease"),
              ),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (value) =>
                value!.isEmpty ? "Address is required" : null,
              ),

              TextFormField(
                controller: _contactController,
                decoration:
                const InputDecoration(labelText: "Contact Number"),
                validator: (value) =>
                value!.isEmpty ? "Contact number is required" : null,
              ),

              TextFormField(
                controller: _extraInfoController,
                decoration: const InputDecoration(labelText: "Extra Info"),
                maxLines: 2,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveRequest,
                child: const Text("Save Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
