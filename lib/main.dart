import 'package:flutter/material.dart';
import 'screens/requests/requests_list_screen.dart';
import 'screens/requests/add_request_screen.dart';
import 'screens/requests/request_details_screen.dart';
import 'screens/requests/edit_request_screen.dart';

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
      // FIRST SCREEN USER SEES
      initialRoute: '/login',

      routes: {
        // Authentication
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        // Home / Dashboard Container
        '/': (context) => const HomeContainer(),   // fallback root
        '/dashboard': (context) => const HomeContainer(),
        // Requests
        '/addRequest': (context) => const AddRequestScreen(),
        '/requestDetails': (context) => const RequestDetailsScreen(),
        // Edit Request Route
        '/editRequest': (context) {
          final requestId = ModalRoute.of(context)!.settings.arguments as int;
          return EditRequestScreen(requestId: requestId);
        },
        // Donors
        '/donors': (context) => const DonorsListScreen(),
      },
    );
  }
}
