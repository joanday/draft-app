import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // required before Firebase.initializeApp
  await Firebase.initializeApp(); // initialize Firebase
  runApp(const PSAUniFilmsApp());
}

class PSAUniFilmsApp extends StatelessWidget {
  const PSAUniFilmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PSAUniFilms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1F17),
        primaryColor: const Color(0xFF4CAF50),
      ),
      home: const LoginScreen(),
    );
  }
}
