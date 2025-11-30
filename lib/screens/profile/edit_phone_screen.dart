import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';

class EditPhoneScreen extends StatefulWidget {
  final UserModel user;

  const EditPhoneScreen({super.key, required this.user});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  final _formKey = GlobalKey<FormState>();

  // Phone Mask
  final phoneMask = MaskTextInputFormatter(
    mask: '+998 ## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  late TextEditingController phoneCtrl;

  @override
  void initState() {
    super.initState();

    // Convert existing phone into masked format
    phoneCtrl = TextEditingController(
      text: phoneMask.maskText(widget.user.phone),
    );
  }

  Future<void> _savePhone() async {
    if (!_formKey.currentState!.validate()) return;

    final newPhone = phoneMask.getUnmaskedText(); // digits only

    widget.user.phone = newPhone;

    await DatabaseHelper.instance.updateUser(widget.user);

    Navigator.pop(context, true); // return success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Phone Number"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: phoneCtrl,
                inputFormatters: [phoneMask],
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (v) {
                  if (phoneMask.getUnmaskedText().length != 9) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _savePhone,
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
                  "Save Changes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
