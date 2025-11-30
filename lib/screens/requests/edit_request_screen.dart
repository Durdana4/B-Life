import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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

  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _neededCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _extraCtrl = TextEditingController();

  String? selectedBlood;

  final phoneMask = MaskTextInputFormatter(
    mask: '+998 ## ###-##-##',
    filter: { "#": RegExp(r'[0-9]') },
  );

  final bloodTypes = ["I+", "I-", "II+", "II-", "III+", "III-", "IV+", "IV-"];

  bool loading = true;
  late RequestModel request;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    request = (await DatabaseHelper.instance.getRequest(widget.requestId))!;

    _nameCtrl.text = request.name;
    _surnameCtrl.text = request.surname;
    selectedBlood = request.bloodType;
    _birthCtrl.text = request.birthDate;
    _neededCtrl.text = request.neededDate;
    _diseaseCtrl.text = request.disease;
    _addressCtrl.text = request.address;
    _phoneCtrl.text = request.contactNumber;
    _extraCtrl.text = request.extraInfo;

    setState(() => loading = false);
  }

  Future<void> pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_birthCtrl.text) ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _birthCtrl.text = picked.toIso8601String().split("T").first;
    }
  }

  Future<void> pickNeededDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_neededCtrl.text) ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _neededCtrl.text = picked.toIso8601String().split("T").first;
    }
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    final updated = RequestModel(
      id: request.id,
      name: _nameCtrl.text.trim(),
      surname: _surnameCtrl.text.trim(),
      bloodType: selectedBlood!,
      birthDate: _birthCtrl.text,
      neededDate: _neededCtrl.text,
      disease: _diseaseCtrl.text,
      address: _addressCtrl.text,
      contactNumber: _phoneCtrl.text,
      extraInfo: _extraCtrl.text,
    );

    await DatabaseHelper.instance.updateRequest(updated);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request updated"))
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Request")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (v)=> v==null || v.isEmpty ? "Required" : null,
            ),
            TextFormField(
              controller: _surnameCtrl,
              decoration: const InputDecoration(labelText: "Surname"),
              validator: (v)=> v==null || v.isEmpty ? "Required" : null,
            ),

            DropdownButtonFormField<String>(
              value: selectedBlood,
              decoration: const InputDecoration(labelText: "Blood Type"),
              items: bloodTypes.map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),
              onChanged: (v)=> setState(()=> selectedBlood = v),
              validator: (v)=> v == null ? "Required" : null,
            ),

            TextFormField(
              controller: _birthCtrl,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Birth Date"),
              onTap: pickBirthDate,
              validator: (v)=> v==null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _neededCtrl,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Needed Date"),
              onTap: pickNeededDate,
              validator: (v)=> v==null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              inputFormatters: [phoneMask],
              decoration: const InputDecoration(labelText: "Contact Number"),
              validator: (v)=> v==null || v.length < 17 ? "Invalid phone" : null,
            ),

            TextFormField(
              controller: _addressCtrl,
              decoration: const InputDecoration(labelText: "Address"),
              validator: (v)=> v==null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _diseaseCtrl,
              decoration: const InputDecoration(labelText: "Disease"),
            ),

            TextFormField(
              controller: _extraCtrl,
              maxLines: 2,
              decoration: const InputDecoration(labelText: "Extra Info"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text("Save Changes")),
          ]),
        ),
      ),
    );
  }
}
