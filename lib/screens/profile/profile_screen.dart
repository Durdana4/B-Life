import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';
import 'edit_profile_screen.dart';
import 'edit_email_screen.dart';
import 'edit_phone_screen.dart';
import 'edit_location_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // For now, always load user with ID = 1
    final data = await DatabaseHelper.instance.getUserById(1);
    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.redAccent.withOpacity(0.2),
              child: const Icon(Icons.person, size: 60, color: Colors.redAccent),
            ),

            const SizedBox(height: 12),

            Text(
              "${user!.name} ${user!.surname}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(user!.email, style: TextStyle(color: Colors.grey[700])),

            const SizedBox(height: 20),
            _section("Account Information"),

            _tile("Name", "${user!.name} ${user!.surname}", Icons.person, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditProfileScreen(user: user!))
              ).then((_) => _loadUser());
            }),

            _tile("Email", user!.email, Icons.email, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditEmailScreen(user: user!))
              ).then((_) => _loadUser());
            }),

            _tile("Phone", user!.phone, Icons.phone, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditPhoneScreen(user: user!))
              ).then((_) => _loadUser());
            }),

            _tile("Location", user!.location, Icons.location_on, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditLocationScreen(user: user!))
              ).then((_) => _loadUser());
            }),

            const SizedBox(height: 20),
            _section("Security"),

            _tile("Change Password", "******", Icons.lock, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChangePasswordScreen(userId: user!.id!)),
              );
            }),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child:
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _tile(String label, String value, IconData icon, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(label),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
