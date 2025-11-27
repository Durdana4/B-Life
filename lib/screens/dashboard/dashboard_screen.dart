import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          "B-Life Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME TITLE
            const Text(
              "Welcome Back! 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Choose an action below",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // FIRST ROW BUTTONS (ADD + VIEW REQUESTS)
            Row(
              children: [
                _homeButton(
                  context,
                  icon: Icons.add_circle,
                  label: "Add Request",
                  color: Colors.redAccent,
                  route: '/addRequest',
                ),

                const SizedBox(width: 16),

                _homeButton(
                  context,
                  icon: Icons.list_alt,
                  label: "Requests",
                  color: Colors.blueAccent,
                  route: '/home',
                ),
              ],
            ),

            const SizedBox(height: 20),

            // SECOND ROW (DONORS)
            Row(
              children: [
                _homeButton(
                  context,
                  icon: Icons.people,
                  label: "Donors",
                  color: Colors.green,
                  route: '/donors', // we will build this screen later
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required String route,
      }) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
