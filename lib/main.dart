import 'package:flutter/material.dart';
import 'screens/requests/requests_list_screen.dart';
import 'screens/requests/add_request_screen.dart';
import 'screens/requests/request_details_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/registration_screen.dart';
import 'screens/home/home_container.dart';
import 'screens/donors/donors_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLife',
      initialRoute: '/register',
      routes: {
        '/': (context) => const HomeContainer(),
        '/addRequest': (context) => const AddRequestScreen(),
        '/requestDetails': (context) => const RequestDetailsScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const HomeContainer(),
        '/donors': (context) => const DonorsListScreen(),
      },
    );
  }
}
