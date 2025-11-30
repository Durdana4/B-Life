import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/database/database_helper.dart';

class EditLocationScreen extends StatefulWidget {
  final UserModel user;

  const EditLocationScreen({super.key, required this.user});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  String? selectedRegion;
  String? selectedCity;

  final Map<String, List<String>> regionCities = {
    "Tashkent": [
      "Yakkasaroy", "Yunusabad", "Mirzo Ulugbek", "Chilonzor",
      "Shayxontohur", "Olmazor", "Sergeli", "Uchtepa",
      "Bektemir", "Yashnobod",
    ],
    "Tashkent Region": [
      "Nurafshon", "Chirchiq", "Olmaliq", "Angren", "Bekabad",
      "Ohangaron", "Parkent", "Piskent", "Quyichirchiq",
      "Oqqo‘rg‘on", "Bo‘stonliq", "Yangiyo‘l",
    ],
    "Samarkand": [
      "Samarkand City", "Kattakurgan", "Urgut", "Narpay", "Payariq",
      "Ishtixon", "Bulungur", "Jomboy", "Qushrabot", "Pastdargom",
    ],
    "Bukhara": [
      "Bukhara City", "Kogon", "Gijduvon", "Shofirkon", "Olot",
      "Romitan", "Qorako‘l", "Vobkent",
    ],
    "Andijan": [
      "Andijan City", "Asaka", "Khanabad", "Buloqboshi", "Shahrixon",
      "Marhamat", "Jalaquduq", "Bo‘z",
    ],
    "Fergana": [
      "Fergana City", "Margilan", "Kokand", "Quvasoy",
      "Beshariq", "Uchkuprik", "Dangara",
    ],
    "Namangan": [
      "Namangan City", "Chortoq", "Kosonsoy", "Uychi",
      "Pop", "Yangiqo‘rg‘on", "Norin",
    ],
    "Khorezm": [
      "Urgench", "Khiva", "Shovot", "Gurlan",
      "Xonqa", "Qo‘shko‘pir", "Bog‘ot",
    ],
    "Surxondaryo": [
      "Termez", "Denov", "Sherobod", "Qumqo‘rg‘on",
      "Oltinsoy", "Sariosiyo", "Boysun",
    ],
    "Qashqadaryo": [
      "Karshi", "Shahrisabz", "Kitob", "Koson",
      "Kasbi", "Guzor", "Nishon",
    ],
    "Sirdaryo": [
      "Guliston", "Yangiyer", "Shirin",
      "Sardoba", "Mirzachul", "Boyovut",
    ],
    "Jizzakh": [
      "Jizzakh City", "Zomin", "Gallaorol",
      "Paxtakor", "Forish", "Mirzacho‘l",
    ],
    "Navoiy": [
      "Navoiy City", "Zarafshan", "Qiziltepa",
      "Konimex", "Uchkuduk", "Karmana",
    ],
    "Karakalpakstan": [
      "Nukus", "Taxiatosh", "Kungrad",
      "Muynoq", "Chimboy", "Kegeyli", "Qo‘ng‘irot",
    ],
  };

  @override
  void initState() {
    super.initState();

    final parts = widget.user.location.split(", ");

    if (parts.isNotEmpty) selectedRegion = parts[0];
    if (parts.length > 1) selectedCity = parts[1];
  }

  Future<void> _saveLocation() async {
    if (selectedRegion == null || selectedCity == null) return;

    final updated = widget.user.copyWith(
      location: "$selectedRegion, $selectedCity",
    );

    await DatabaseHelper.instance.updateUser(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> cities =
    selectedRegion != null ? regionCities[selectedRegion]! : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Location"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Region",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedRegion,
              items: regionCities.keys
                  .map(
                    (r) => DropdownMenuItem<String>(
                  value: r,
                  child: Text(r),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  selectedCity = null;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Region",
              ),
            ),

            const SizedBox(height: 30),
            const Text("Select City",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedCity,
              items: cities
                  .map(
                    (c) => DropdownMenuItem<String>(
                  value: c,
                  child: Text(c),
                ),
              )
                  .toList(),
              onChanged: selectedRegion == null
                  ? null
                  : (value) => setState(() => selectedCity = value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "City",
              ),
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: selectedRegion != null && selectedCity != null
                    ? _saveLocation
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Save", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
