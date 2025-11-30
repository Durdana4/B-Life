import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/database/database_helper.dart';

class EditRequestScreen extends StatefulWidget {
  final int requestId;

  const EditRequestScreen({super.key, required this.requestId});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = true;

  // Controllers
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _neededCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _extraCtrl = TextEditingController();

  String? _bloodType;

  final List<String> _bloodTypes = [
    "I+",
    "I-",
    "II+",
    "II-",
    "III+",
    "III-",
    "IV+",
    "IV-"
  ];

  late RequestModel _request;

  @override
  void initState() {
    super.initState();
    _loadRequest();
  }

  // Load existing request from DB
  Future<void> _loadRequest() async {
    final req = await DatabaseHelper.instance.getRequest(widget.requestId);

    if (req == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request not found")),
      );
      Navigator.pop(context);
      return;
    }

    _request = req;
    _nameCtrl.text = req.name;
    _surnameCtrl.text = req.surname;
    _bloodType = req.bloodType;
    _birthCtrl.text = req.birthDate;
    _neededCtrl.text = req.neededDate;
    _diseaseCtrl.text = req.disease;
    _addressCtrl.text = req.address;
    _phoneCtrl.text = req.contactNumber;
    _extraCtrl.text = req.extraInfo;

    setState(() => _loading = false);
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final updated = RequestModel(
      id: _request.id,
      name: _nameCtrl.text.trim(),
      surname: _surnameCtrl.text.trim(),
      bloodType: _bloodType!,
      birthDate: _birthCtrl.text.trim(),
      neededDate: _neededCtrl.text.trim(),
      disease: _diseaseCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      contactNumber: _phoneCtrl.text.trim(),
      extraInfo: _extraCtrl.text.trim(),
    );

    await DatabaseHelper.instance.updateRequest(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request updated successfully!")),
    );

    Navigator.pop(context, true); // return true to refresh previous screen
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _birthCtrl.dispose();
    _neededCtrl.dispose();
    _diseaseCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _extraCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Request"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? "Name required" : null,
              ),

              TextFormField(
                controller: _surnameCtrl,
                decoration: const InputDecoration(labelText: "Surname"),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? "Surname required" : null,
              ),

              DropdownButtonFormField<String>(
                value: _bloodType,
                decoration: const InputDecoration(labelText: "Blood Type"),
                items: _bloodTypes
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (v) => setState(() => _bloodType = v),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Blood type required" : null,
              ),

              TextFormField(
                controller: _birthCtrl,
                decoration: const InputDecoration(
                    labelText: "Birth Date (YYYY-MM-DD)"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Birth date required" : null,
              ),

              TextFormField(
                controller: _neededCtrl,
                decoration: const InputDecoration(
                    labelText: "Needed Date (YYYY-MM-DD)"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Needed date required" : null,
              ),

              TextFormField(
                controller: _diseaseCtrl,
                decoration: const InputDecoration(labelText: "Disease"),
              ),

              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Address required" : null,
              ),

              TextFormField(
                controller: _phoneCtrl,
                decoration:
                const InputDecoration(labelText: "Contact Number"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Phone required" : null,
              ),

              TextFormField(
                controller: _extraCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: "Extra Info"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
