import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/forgot_screen.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare AI',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot': (context) => const ForgotScreen(),
        '/main': (context) => const MainScreen(), // Your main app screen after login
      },
    );
  }
}