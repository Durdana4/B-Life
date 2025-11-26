import 'package:flutter/material.dart';
import '../../models/request.dart';
import '../../services/sqlite/database_helper.dart';

class RequestsListScreen extends StatefulWidget {
  const RequestsListScreen({Key? key}) : super(key: key);

  @override
  State<RequestsListScreen> createState() => _RequestsListScreenState();
}

class _RequestsListScreenState extends State<RequestsListScreen> {
  List<RequestModel> _requests = [];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    final data = await DatabaseHelper.instance.getAllRequests();
    setState(() {
      _requests = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Requests"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addRequest').then((_) {
            _loadRequests(); // Refresh after returning
          });
        },
        child: const Icon(Icons.add),
      ),
      body: _requests.isEmpty
          ? const Center(
        child: Text(
          "No requests yet",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final req = _requests[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("${req.name} ${req.surname}"),
              subtitle: Text("Blood Type: ${req.bloodType}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/requestDetails',
                  arguments: req.id,
                ).then((_) => _loadRequests());
              },
            ),
          );
        },
      ),
    );
  }
}
