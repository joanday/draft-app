import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import 'agreement_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;

  // ── Firebase instances ──────────────────────────────────────────────────────
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // ── Save login log to Firestore ─────────────────────────────────────────────
  Future<void> _saveLoginLog(User user) async {
    await _firestore.collection('login_logs').add({
      'userId': user.uid,
      'email': user.email,
      'loginTime': FieldValue.serverTimestamp(), // server time, not device time
      'status': 'success',
    });
  }

  // ── Login handler ───────────────────────────────────────────────────────────
  void _onLogin() async {
    if (_emailCtrl.text.trim().isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Sign in with Firebase Auth
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      // 2. Save login activity to Firestore
      await _saveLoginLog(credential.user!);

      // 3. Navigate to Agreement screen
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AgreementScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Map Firebase error codes to friendly messages
      String msg;
      switch (e.code) {
        case 'user-not-found':
          msg = 'No account found with this email.';
          break;
        case 'wrong-password':
          msg = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          msg = 'Please enter a valid email address.';
          break;
        case 'user-disabled':
          msg = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          msg = 'Too many attempts. Please try again later.';
          break;
        default:
          msg = 'Login failed. Please try again.';
      }

      // Log failed attempt to Firestore (no uid since login failed)
      await _firestore.collection('login_logs').add({
        'email': _emailCtrl.text.trim(),
        'loginTime': FieldValue.serverTimestamp(),
        'status': 'failed',
        'reason': e.code,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // ── UI (unchanged from your original) ──────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),

              // Logo
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFB8960C), width: 2),
                    color: const Color(0xFF1A3528),
                  ),
                  child: const Icon(Icons.person_outline,
                      color: Color(0xFFB8960C), size: 44),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: 'Welcome to\n',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: 'PSAUni',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: 'Films',
                        style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Log in to continue watching inspiring\nstories and student documentaries.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 40),

              // Email
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF1A2E22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Password
              TextField(
                controller: _passwordCtrl,
                obscureText: _obscurePass,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.white38),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscurePass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.white38),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A2E22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Forgot password
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?',
                      style: TextStyle(color: Colors.white54, fontSize: 13)),
                ),
              ),
              const SizedBox(height: 8),

              // Login button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onPressed: _isLoading ? null : _onLogin,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Text('Log In'),
              ),
              const SizedBox(height: 20),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                      style: TextStyle(color: Colors.white54, fontSize: 13)),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('Sign up',
                        style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
