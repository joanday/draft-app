import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(children: [
              const SizedBox(height: 12),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: AppTheme.greenMuted,
                    child: Text('JD',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          color: AppTheme.greenPrime,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.bgDark, width: 2)),
                      child: const Icon(Icons.camera_alt_outlined,
                          size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Juan Dela Cruz',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary)),
              const SizedBox(height: 4),
              const Text('juan.delacruz@psa.edu.ph',
                  style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
              const SizedBox(height: 16),
            ]),
          ),
          _sectionLabel('Account'),
          _settingsCard([
            _tile(Icons.person_outline, 'Account Settings', onTap: () {}),
            _tile(Icons.lock_outline, 'Change Password', onTap: () {}),
            _tile(Icons.mail_outline, 'Email Preferences', onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _sectionLabel('Preferences'),
          _settingsCard([
            _tile(Icons.notifications_outlined, 'Notifications',
                onTap: () {},
                trailing: Switch(
                    value: true,
                    onChanged: (_) {},
                    activeThumbColor: AppTheme.greenPrime)),
            _tile(Icons.download_outlined, 'Download Quality',
                subtitle: 'HD (720p)', onTap: () {}),
            _tile(Icons.subtitles_outlined, 'Subtitles',
                subtitle: 'Filipino', onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _sectionLabel('Support'),
          _settingsCard([
            _tile(Icons.help_outline, 'Help & Support', onTap: () {}),
            _tile(Icons.privacy_tip_outlined, 'Privacy Policy', onTap: () {}),
            _tile(Icons.info_outline, 'About PSAUniFilms',
                subtitle: 'v1.0.0', onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _settingsCard([
            ListTile(
              leading: const Icon(Icons.logout, color: AppTheme.redDecline),
              title: const Text('Log Out',
                  style: TextStyle(
                      color: AppTheme.redDecline, fontWeight: FontWeight.w500)),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppTheme.bgCard,
                  title: const Text('Log Out?',
                      style: TextStyle(color: AppTheme.textPrimary)),
                  content: const Text('Are you sure?',
                      style: TextStyle(color: AppTheme.textMuted)),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel',
                            style: TextStyle(color: AppTheme.textMuted))),
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (_) => false),
                        child: const Text('Log Out',
                            style: TextStyle(color: AppTheme.redDecline))),
                  ],
                ),
              ),
            ),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  static Widget _sectionLabel(String label) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(label.toUpperCase(),
            style: const TextStyle(
                fontSize: 11,
                letterSpacing: 1.2,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500)),
      );

  static Widget _settingsCard(List<Widget> tiles) => Container(
        decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.borderColor)),
        child: Column(
          children: tiles.asMap().entries.map((e) {
            final isLast = e.key == tiles.length - 1;
            return Column(children: [
              e.value,
              if (!isLast)
                const Divider(
                    height: 0, color: AppTheme.borderColor, indent: 52),
            ]);
          }).toList(),
        ),
      );

  static Widget _tile(
    IconData icon,
    String title, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) =>
      ListTile(
        leading: Icon(icon, color: AppTheme.textMuted, size: 22),
        title: Text(title,
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
        subtitle: subtitle != null
            ? Text(subtitle,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 12))
            : null,
        trailing: trailing ??
            const Icon(Icons.chevron_right,
                color: AppTheme.textMuted, size: 20),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      );
}
