import 'package:flutter/material.dart';

class Donor {
  final String name;
  final String bloodGroup;
  final String location;
  final String lastDonation;
  final String phoneNumber;
  final String email;

  Donor({
    required this.name,
    required this.bloodGroup,
    required this.location,
    required this.lastDonation,
    required this.phoneNumber,
    required this.email,
  });
}

class DonorsListScreen extends StatelessWidget {
  const DonorsListScreen({super.key});

  static List<Donor> donors = [
    Donor(
      name: "Sarah Johnson",
      bloodGroup: "A+",
      location: "Downtown Center",
      lastDonation: "2 months ago",
      phoneNumber: "+1 (555) 123-4567",
      email: "sarah.j@example.com",
    ),
    Donor(
      name: "Michael Chen",
      bloodGroup: "O-",
      location: "Westside Clinic",
      lastDonation: "1 week ago",
      phoneNumber: "+1 (555) 987-6543",
      email: "m.chen@example.com",
    ),
    Donor(
      name: "Emily Davis",
      bloodGroup: "B+",
      location: "City Hospital",
      lastDonation: "3 months ago",
      phoneNumber: "+1 (555) 234-5678",
      email: "emily.d@example.com",
    ),
    Donor(
      name: "James Wilson",
      bloodGroup: "AB+",
      location: "Community Health",
      lastDonation: "5 months ago",
      phoneNumber: "+1 (555) 876-5432",
      email: "j.wilson@example.com",
    ),
    Donor(
      name: "Jessica Martinez",
      bloodGroup: "O+",
      location: "North Hills",
      lastDonation: "Just now",
      phoneNumber: "+1 (555) 345-6789",
      email: "jess.m@example.com",
    ),
    Donor(
      name: "David Anderson",
      bloodGroup: "A-",
      location: "Valley Medical",
      lastDonation: "4 months ago",
      phoneNumber: "+1 (555) 765-4321",
      email: "d.anderson@example.com",
    ),
    Donor(
      name: "Robert Taylor",
      bloodGroup: "B-",
      location: "Central Blood Bank",
      lastDonation: "6 months ago",
      phoneNumber: "+1 (555) 456-7890",
      email: "r.taylor@example.com",
    ),
    Donor(
      name: "Lisa Thomas",
      bloodGroup: "AB-",
      location: "University Hospital",
      lastDonation: "1 year ago",
      phoneNumber: "+1 (555) 654-3210",
      email: "l.thomas@example.com",
    ),
    Donor(
      name: "William Jackson",
      bloodGroup: "O+",
      location: "Red Cross Center",
      lastDonation: "2 weeks ago",
      phoneNumber: "+1 (555) 567-8901",
      email: "w.jackson@example.com",
    ),
    Donor(
      name: "Jennifer White",
      bloodGroup: "A+",
      location: "St. Mary's Hospital",
      lastDonation: "3 weeks ago",
      phoneNumber: "+1 (555) 098-7654",
      email: "j.white@example.com",
    ),
  ];

  void _showDonorDetails(BuildContext context, Donor donor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red.shade100,
                      child: Text(
                        donor.bloodGroup,
                        style: TextStyle(
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donor.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            donor.location,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                _buildDetailRow(Icons.phone, "Phone", donor.phoneNumber),
                const SizedBox(height: 16),
                _buildDetailRow(Icons.email, "Email", donor.email),
                const SizedBox(height: 16),
                _buildDetailRow(
                  Icons.history,
                  "Last Donation",
                  donor.lastDonation,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement contact action
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.call),
                    label: const Text("Contact Donor"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 24),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Donors"), elevation: 0),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: donors.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final donor = donors[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => _showDonorDetails(context, donor),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          donor.bloodGroup,
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donor.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                donor.location,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Last: ${donor.lastDonation}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
