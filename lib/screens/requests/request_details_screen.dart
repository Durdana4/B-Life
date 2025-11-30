import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/database/database_helper.dart';

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

  Future<void> _confirmDelete(int id) async {
    final bool? result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Request"),
        content: const Text("Are you sure you want to delete this request?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (result == true) {
      await DatabaseHelper.instance.deleteRequest(id);
      Navigator.pop(context, true); // return true for refresh
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No request ID provided!")),
      );
      Navigator.pop(context);
      return;
    }

    final int id = args as int;
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
                _confirmDelete(request!.id!);
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

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/editRequest',
                  arguments: request!.id,
                ).then((updated) {
                  if (updated == true) {
                    _loadRequest(request!.id!);
                  }
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
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? "Not provided" : value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
