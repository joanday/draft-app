import 'package:flutter/material.dart';
import 'student_main_nav_screen.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFFB8960C), width: 2),
                          color: const Color(0xFF1A3528),
                        ),
                        child: const Icon(Icons.person_outline,
                            color: Color(0xFFB8960C), size: 38),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'User Agreement – \n',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          TextSpan(
                              text: 'PSAUniFilms',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4CAF50))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Body text
                    const Text(
                      'Welcome to PSAUniFilms. We are proud to present student films and showcase CAS DEVCOM documentaries from Pampanga State Agricultural University. This application is a platform for archiving and viewing these valuable works for educational use only. Users are expected to act responsibly and respect the content.',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 16),

                    // Bullet points
                    _bullet(
                        'The documentaries on this platform are for educational use only.'),
                    _bullet(
                        'Users agree not to redistribute, re-upload, or post to social media without prior permission.'),
                    const SizedBox(height: 16),

                    const Text(
                      'By proceeding, you agree to these terms.',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Agree
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StudentMainNavScreen())),
                      child: const Text('Agree'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Decline
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('• ',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13, height: 1.5)),
            ),
          ],
        ),
      );
}
