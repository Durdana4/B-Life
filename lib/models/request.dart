class RequestModel {
  int? id;
  String name;
  String surname;
  String bloodType;
  String birthDate;
  String neededDate;
  String disease;
  String address;
  String contactNumber;
  String extraInfo;

  RequestModel({
    this.id,
    required this.name,
    required this.surname,
    required this.bloodType,
    required this.birthDate,
    required this.neededDate,
    required this.disease,
    required this.address,
    required this.contactNumber,
    required this.extraInfo,
  });

  // Convert Request to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'bloodType': bloodType,
      'birthDate': birthDate,
      'neededDate': neededDate,
      'disease': disease,
      'address': address,
      'contactNumber': contactNumber,
      'extraInfo': extraInfo,
    };
  }

  // Convert Map to Request
  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      bloodType: map['bloodType'],
      birthDate: map['birthDate'],
      neededDate: map['neededDate'],
      disease: map['disease'],
      address: map['address'],
      contactNumber: map['contactNumber'],
      extraInfo: map['extraInfo'],
    );
  }
}
