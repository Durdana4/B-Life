import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/sqlite/database_helper.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  RequestModel? request;

  Future<void> _loadRequest(int id) async {
    final data = await DatabaseHelper.instance.getRequest(id);
    setState(() {
      request = data;
    });
  }

  Future<void> _deleteRequest(int id) async {
    await DatabaseHelper.instance.deleteRequest(id);
    Navigator.pop(context); // go back to list
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Receive request ID from navigation arguments
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    _loadRequest(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              if (request != null) {
                _deleteRequest(request!.id!);
              }
            },
          ),
        ],
      ),
      body: request == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _info("Name", request!.name),
            _info("Surname", request!.surname),
            _info("Blood Type", request!.bloodType),
            _info("Birth Date", request!.birthDate),
            _info("Needed Date", request!.neededDate),
            _info("Disease", request!.disease),
            _info("Address", request!.address),
            _info("Contact Number", request!.contactNumber),
            _info("Extra Info", request!.extraInfo),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/editRequest',
                  arguments: request!.id,
                ).then((_) {
                  _loadRequest(request!.id!);
                });
              },
              child: const Text("Edit Request"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
