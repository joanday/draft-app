import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/student_main_nav_screen.dart';
import 'screens/devcom_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Still loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF0D1F17),
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
              ),
            );
          }

          // User is logged in — check role
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, roleSnapshot) {
                // Still fetching role
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    backgroundColor: Color(0xFF0D1F17),
                    body: Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF4CAF50)),
                    ),
                  );
                }

                // Check role field
                final role = roleSnapshot.data?.data() != null
                    ? (roleSnapshot.data!.data()
                        as Map<String, dynamic>)['role'] as String?
                    : null;

                if (role == 'officer' ||
                    role == 'moderator' ||
                    role == 'reviewer') {
                  return const DevcomDashboardScreen();
                }

                // Default: student
                return const StudentMainNavScreen();
              },
            );
          }

          // No user logged in
          return const LoginScreen();
        },
      ),
    );
  }
}
