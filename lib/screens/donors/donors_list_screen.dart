import 'package:flutter/material.dart';

class DonorsListScreen extends StatelessWidget {
  const DonorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donors List")),
      body: ListView.builder(
        itemCount: 10, // TODO: replace with real data later
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text("Donor ${index + 1}"),
            subtitle: const Text("Blood Group: A+"),
            onTap: () {
              // TODO: navigate to donor details
            },
          );
        },
      ),
    );
  }
}
