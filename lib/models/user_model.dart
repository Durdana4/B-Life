class UserModel {
  final int? id;
  String name;
  String surname;
  String email;
  String phone;
  String location;
  String password;

  // Donor-specific fields
  String bloodType;
  String gender;
  String passportId;
  bool isEligible;
  String nextDonationDate;
  int totalDonations;

  UserModel({
    this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.location,
    required this.password,
    required this.bloodType,
    required this.gender,
    required this.passportId,
    required this.isEligible,
    required this.nextDonationDate,
    required this.totalDonations,
  });

  // --------------------------------------------------
  // COPYWITH — required for all edit screens
  // --------------------------------------------------
  UserModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? email,
    String? phone,
    String? location,
    String? password,
    String? bloodType,
    String? gender,
    String? passportId,
    bool? isEligible,
    String? nextDonationDate,
    int? totalDonations,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      password: password ?? this.password,
      bloodType: bloodType ?? this.bloodType,
      gender: gender ?? this.gender,
      passportId: passportId ?? this.passportId,
      isEligible: isEligible ?? this.isEligible,
      nextDonationDate: nextDonationDate ?? this.nextDonationDate,
      totalDonations: totalDonations ?? this.totalDonations,
    );
  }

  // --------------------------------------------------
  // DB MAP HANDLING
  // --------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'phone': phone,
      'location': location,
      'password': password,
      'bloodType': bloodType,
      'gender': gender,
      'passportId': passportId,
      'isEligible': isEligible ? 1 : 0,
      'nextDonationDate': nextDonationDate,
      'totalDonations': totalDonations,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
      phone: map['phone'],
      location: map['location'],
      password: map['password'],
      bloodType: map['bloodType'],
      gender: map['gender'],
      passportId: map['passportId'],
      isEligible: map['isEligible'] == 1,
      nextDonationDate: map['nextDonationDate'],
      totalDonations: map['totalDonations'],
    );
  }

  // --------------------------------------------------
  // FORMATTED PHONE (for UI)
  // --------------------------------------------------
  String phoneFormatted() {
    if (phone.length == 9) {
      return "+998 ${phone.substring(0, 2)} ${phone.substring(2, 5)}-${phone.substring(5, 7)}-${phone.substring(7, 9)}";
    }
    return phone;
  }
}
