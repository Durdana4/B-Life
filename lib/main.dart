import 'package:flutter/material.dart';
import 'screens/requests/requests_list_screen.dart';
import 'screens/requests/add_request_screen.dart';
import 'screens/requests/request_details_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const RequestsListScreen(),
        '/addRequest': (context) => const AddRequestScreen(),
        '/requestDetails': (context) => const RequestDetailsScreen(),
      },
    );
  }
}
