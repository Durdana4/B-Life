import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final reg = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    return reg.hasMatch(value) ? null : 'Enter a valid email';
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // ...existing code...
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful (placeholder)')),
      );
      // On success, you can navigate to main app screen
    }
  }

  void _resetPassword() {
    // Small placeholder action for reset
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset flow (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                validator: (v) => (v == null || v.isEmpty) ? 'Password is required' : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _resetPassword,
                    child: const Text('Reset'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text('Register instead'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}