import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';

class EmailPreferencesScreen extends StatefulWidget {
  const EmailPreferencesScreen({super.key});

  @override
  State<EmailPreferencesScreen> createState() => _EmailPreferencesScreenState();
}

class _EmailPreferencesScreenState extends State<EmailPreferencesScreen> {
  bool _newReleases = true;
  bool _weeklyDigest = false;
  bool _announcements = true;
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    setState(() => _isLoading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists && doc.data()?['emailPrefs'] != null) {
        final prefs = doc.data()!['emailPrefs'];
        setState(() {
          _newReleases = prefs['newReleases'] ?? true;
          _weeklyDigest = prefs['weeklyDigest'] ?? false;
          _announcements = prefs['announcements'] ?? true;
        });
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _savePreferences() async {
    setState(() => _isSaving = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'emailPrefs': {
          'newReleases': _newReleases,
          'weeklyDigest': _weeklyDigest,
          'announcements': _announcements,
        }
      }, SetOptions(merge: true));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email preferences saved!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: AppBar(
        backgroundColor: AppTheme.bgDark,
        foregroundColor: Colors.white,
        title: const Text('Email Preferences'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF4CAF50)))
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Choose which emails you want to receive.',
                      style: TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 13,
                          height: 1.5)),
                  const SizedBox(height: 24),
                  _buildToggle(
                    'New Releases',
                    'Get notified when new films are uploaded',
                    Icons.movie_outlined,
                    _newReleases,
                    (v) => setState(() => _newReleases = v),
                  ),
                  const Divider(color: AppTheme.borderColor),
                  _buildToggle(
                    'Weekly Digest',
                    'A summary of top films every week',
                    Icons.newspaper_outlined,
                    _weeklyDigest,
                    (v) => setState(() => _weeklyDigest = v),
                  ),
                  const Divider(color: AppTheme.borderColor),
                  _buildToggle(
                    'Announcements',
                    'Important updates from PSAUniFilms',
                    Icons.campaign_outlined,
                    _announcements,
                    (v) => setState(() => _announcements = v),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D8B40),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5))
                        : const Text('Save Preferences',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildToggle(String title, String subtitle, IconData icon, bool value,
      ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppTheme.textMuted, size: 22),
      title: Text(title,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF4CAF50),
      ),
    );
  }
}
