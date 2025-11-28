import 'package:flutter/material.dart';
=======
import '../../services/database/database_helper.dart';
import '../../models/request.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int totalRequests = 0;
  List<RequestModel> recentRequests = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final all = await DatabaseHelper.instance.getAllRequests();
    setState(() {
      totalRequests = all.length;
      recentRequests = all.reversed.take(3).toList(); // last 3 requests
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text(
              "Hello Jamol 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Welcome back! Here's your summary:",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // STAT CARDS
            Row(
              children: [
                Expanded(child: _statCard(Icons.bloodtype, "Total", "$totalRequests")),
                const SizedBox(width: 12),
                Expanded(child: _statCard(Icons.pending_actions, "Pending", "0")),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: _statCard(Icons.check_circle, "Fulfilled", "0")),
                const SizedBox(width: 12),
                Expanded(child: _statCard(Icons.event, "Upcoming", "0")),
              ],
            ),

            const SizedBox(height: 25),

            // QUICK ACTION BUTTONS
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _quickAction(
                  icon: Icons.add_circle,
                  label: "Add Request",
                  onTap: () => Navigator.pushNamed(context, '/addRequest'),
                ),
                _quickAction(
                  icon: Icons.people,
                  label: "Donor List",
                  onTap: () {},
                ),
                _quickAction(
                  icon: Icons.search,
                  label: "Find Donor",
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            // RECENT ACTIVITY
            const Text(
              "Recent Requests",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...recentRequests.map((r) => _recentItem(r)),
          ],
        ),
      ),
    );
  }

  // --- Widgets below ---

  Widget _statCard(IconData icon, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction({required IconData icon, required String label, required Function() onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.redAccent.withOpacity(0.15),
              child: Icon(icon, size: 28, color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _recentItem(RequestModel r) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        title: Text("${r.name} ${r.surname}"),
        subtitle: Text("Need: ${r.neededDate}\nLocation: ${r.address}"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/requestDetails',
            arguments: r.id,
          );
        },
>>>>>>> 632509316a42f15f0abc6a982517b0cd25c8a535
      ),
    );
  }
}
