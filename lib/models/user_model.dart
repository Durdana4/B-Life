class UserModel {
  final String name;
  final String surname;
  final String phone;
  final String passportId;
  final String gender;
  final String location;
  final String bloodType;
  final bool isEligible;
  final String lastDonationDate;
  final String nextDonationDate;
  final int totalDonations;

  UserModel({
    required this.name,
    required this.surname,
    required this.phone,
    required this.passportId,
    required this.gender,
    required this.location,
    required this.bloodType,
    required this.isEligible,
    required this.lastDonationDate,
    required this.nextDonationDate,
    required this.totalDonations,
  });

  // Mock data factory
  factory UserModel.mock() {
    return UserModel(
      name: "Jamol",
      surname: "Kamolov",
      phone: "+998 90 123 45 67",
      passportId: "AB 1234567",
      gender: "Male",
      location: "Tashkent, Uzbekistan",
      bloodType: "A+",
      isEligible: true,
      lastDonationDate: "2023-10-15",
      nextDonationDate: "2024-01-15",
      totalDonations: 5,
    );
  }
}
