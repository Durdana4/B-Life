import 'package:flutter/material.dart';

// AUTH SCREENS
import 'screens/auth/login_screen.dart';
import 'screens/auth/registration_screen.dart';

// REQUEST SCREENS
import 'screens/requests/requests_list_screen.dart';
import 'screens/requests/add_request_screen.dart';
import 'screens/requests/request_details_screen.dart';

// DASHBOARD
import 'screens/dashboard/dashboard_screen.dart';

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

      // First screen shown
      initialRoute: '/login',

      routes: {
        // AUTH
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),

        // DASHBOARD
        '/dashboard': (context) => const DashboardScreen(),

        // REQUESTS
        '/home': (context) => const RequestsListScreen(),
        '/addRequest': (context) => const AddRequestScreen(),
        '/requestDetails': (context) => const RequestDetailsScreen(),
      },
    );
  }
}
