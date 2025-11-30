import 'package:flutter/material.dart';
import '../../../services/database/database_helper.dart';
import '../../../models/request.dart';

class RequestsListScreen extends StatefulWidget {
  const RequestsListScreen({super.key});

  @override
  State<RequestsListScreen> createState() => _RequestsListScreenState();
}

class _RequestsListScreenState extends State<RequestsListScreen> {
  List<RequestModel> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    final data = await DatabaseHelper.instance.getAllRequests();
    setState(() {
      _requests = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Blood Requests",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _requests.isEmpty
          ? const Center(
        child: Text(
          "No requests available",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        itemBuilder: (_, index) {
          final r = _requests[index];
          return _requestCard(r);
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/addRequest');
          _loadRequests();
        },
      ),
    );
  }

  Widget _requestCard(RequestModel r) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/requestDetails',
          arguments: r.id,
        ).then((_) => _loadRequests());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),

          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.red.shade100,
            child: Text(
              r.bloodType,
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          title: Text(
            "${r.name} ${r.surname}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                "Needed: ${r.neededDate}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Text(
                "Location: ${r.address}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),

          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        ),
      ),
    );
  }
}
