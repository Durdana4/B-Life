import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passportController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  Future<void> _pickDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = "${picked.year.toString().padLeft(4,'0')}-"
          "${picked.month.toString().padLeft(2,'0')}-"
          "${picked.day.toString().padLeft(2,'0')}";
    }
  }

  String? _validatePassport(String? value) {
    if (value == null || value.isEmpty) return 'Passport number is required';
    final reg = RegExp(r'^[A-Z]{2}\d{7}$');
    return reg.hasMatch(value) ? null : 'Format: 2 uppercase letters then 7 digits';
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final reg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    return reg.hasMatch(value) ? null : 'Enter a valid email';
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered successfully (placeholder)')),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),

              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Surname is required' : null,
              ),

              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                onTap: _pickDob,
                validator: (v) => (v == null || v.isEmpty) ? 'Date of birth is required' : null,
              ),

              TextFormField(
                controller: _passportController,
                decoration: const InputDecoration(labelText: 'Passport Number'),
                textCapitalization: TextCapitalization.characters,
                validator: _validatePassport,
              ),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (v) => (v == null || v.length < 6) ? 'Password of min 6 chars required' : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Already have an account? Log in instead'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}