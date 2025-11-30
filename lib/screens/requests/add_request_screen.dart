import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../models/request.dart';
import '../../services/database/database_helper.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _neededCtrl = TextEditingController();
  final _diseaseCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _extraCtrl = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '+998 ## ###-##-##',
    filter: { "#": RegExp(r'[0-9]') },
    initialText: "+998 ",
    type: MaskAutoCompletionType.lazy,
  );

  String? selectedBlood;

  final List<String> bloodTypes = [
    "I+","I-","II+","II-","III+","III-","IV+","IV-"
  ];

  Future<void> pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _neededCtrl.text = picked.toIso8601String().split("T").first;
    }
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    final model = RequestModel(
      name: _nameCtrl.text.trim(),
      surname: _surnameCtrl.text.trim(),
      bloodType: selectedBlood!,
      birthDate: _birthCtrl.text.trim(),
      neededDate: _neededCtrl.text.trim(),
      disease: _diseaseCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      contactNumber: _phoneCtrl.text.trim(),
      extraInfo: _extraCtrl.text.trim(),
    );

    await DatabaseHelper.instance.insertRequest(model);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request added successfully"))
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Request")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
              validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
            ),
            TextFormField(
              controller: _surnameCtrl,
              decoration: const InputDecoration(labelText: "Surname"),
              validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
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
              decoration: const InputDecoration(labelText: "Birth Date"),
              readOnly: true,
              onTap: pickBirthDate,
              validator: (v)=> v == null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _neededCtrl,
              decoration: const InputDecoration(labelText: "Needed Date"),
              readOnly: true,
              onTap: pickNeededDate,
              validator: (v)=> v == null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: "Contact Number"),
              keyboardType: TextInputType.phone,
              inputFormatters: [phoneMask],
              validator: (v) => v == null || v.length < 17
                  ? "Enter valid phone"
                  : null,
            ),

            TextFormField(
              controller: _addressCtrl,
              decoration: const InputDecoration(labelText: "Address"),
              validator: (v)=> v == null || v.isEmpty ? "Required" : null,
            ),

            TextFormField(
              controller: _diseaseCtrl,
              decoration: const InputDecoration(labelText: "Disease"),
            ),

            TextFormField(
              controller: _extraCtrl,
              decoration: const InputDecoration(labelText: "Extra Info"),
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("Save"),
            ),
          ]),
        ),
      ),
    );
  }
}
