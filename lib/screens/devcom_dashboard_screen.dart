import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

enum SubmissionStatus { pending, approved, returned }

class FilmSubmission {
  final String title;
  final String studentName;
  final String theme;
  final int year;
  final SubmissionStatus status;
  final String imagePlaceholder;

  const FilmSubmission({
    required this.title,
    required this.studentName,
    required this.theme,
    required this.year,
    required this.status,
    required this.imagePlaceholder,
  });
}

class AppUser {
  final String name;
  final String email;
  final String role;

  const AppUser({
    required this.name,
    required this.email,
    required this.role,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────

final List<FilmSubmission> _submissions = [
  FilmSubmission(
    title: 'Threads of Life',
    studentName: 'Maria Santos',
    theme: 'Agriculture',
    year: 2024,
    status: SubmissionStatus.pending,
    imagePlaceholder: '4A7C59',
  ),
  FilmSubmission(
    title: 'Harvest of Hope',
    studentName: 'Juan Dela Cruz',
    theme: 'Agriculture',
    year: 2024,
    status: SubmissionStatus.pending,
    imagePlaceholder: '8B4513',
  ),
  FilmSubmission(
    title: 'Harmony in Diversity',
    studentName: 'Ana Reyes',
    theme: 'Culture',
    year: 2024,
    status: SubmissionStatus.approved,
    imagePlaceholder: '6B4E71',
  ),
  FilmSubmission(
    title: 'Path of Sustainable Living',
    studentName: 'Luis Ramirez',
    theme: 'Environment',
    year: 2024,
    status: SubmissionStatus.returned,
    imagePlaceholder: '2D5A27',
  ),
  FilmSubmission(
    title: 'Voices of Resilience',
    studentName: 'Sofia Martinez',
    theme: 'Education',
    year: 2024,
    status: SubmissionStatus.approved,
    imagePlaceholder: '3D5A6B',
  ),
];

final List<AppUser> _users = [
  AppUser(
      name: 'Maria Santos',
      email: 'maria.santos@psauni.edu.ph',
      role: 'Moderator'),
  AppUser(
      name: 'Juan Dela Cruz',
      email: 'juan.delacruz@psauni.edu.ph',
      role: 'Moderator'),
  AppUser(
      name: 'Ana Reyes', email: 'ana.reyes@psauni.edu.ph', role: 'Reviewer'),
  AppUser(
      name: 'Luis Ramirez',
      email: 'luis.ramirez@psauni.edu.ph',
      role: 'Officer'),
  AppUser(
      name: 'Sofia Martinez',
      email: 'sofia.martinez@psauni.edu.ph',
      role: 'Moderator'),
];

// ─── Theme Constants ───────────────────────────────────────────────────────────

const _bgDark = Color(0xFF0F1A0F);
const _bgCard = Color(0xFF1A2B1A);
const _bgCardLight = Color(0xFF1E301E);
const _green = Color(0xFF4CAF50);
const _textPrimary = Color(0xFFE8F5E9);
const _textSecondary = Color(0xFF9E9E9E);
const _pendingColor = Color(0xFFFF8F00);
const _approvedColor = Color(0xFF4CAF50);
const _returnedColor = Color(0xFFE53935);
const _moderatorColor = Color(0xFF1565C0);
const _reviewerColor = Color(0xFF6A1B9A);
const _officerColor = Color(0xFF2E7D32);

// ─── Main Screen ──────────────────────────────────────────────────────────────

class DevcomDashboardScreen extends StatefulWidget {
  const DevcomDashboardScreen({super.key});

  @override
  State<DevcomDashboardScreen> createState() => _DevcomDashboardScreenState();
}

class _DevcomDashboardScreenState extends State<DevcomDashboardScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const _DashboardTab(),
      const _SubmissionsTab(),
      const _UsersTab(),
    ];

    return Scaffold(
      backgroundColor: _bgDark,
      body: IndexedStack(
        index: _selectedTab,
        children: screens,
      ),
      bottomNavigationBar: _BottomNav(
        selectedIndex: _selectedTab,
        onTap: (i) => setState(() => _selectedTab = i),
      ),
    );
  }
}

// ─── Bottom Navigation ────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bgCard,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Dashboard',
                  index: 0,
                  selected: selectedIndex == 0,
                  onTap: onTap),
              _NavItem(
                  icon: Icons.description_outlined,
                  label: 'Submissions',
                  index: 1,
                  selected: selectedIndex == 1,
                  onTap: onTap),
              _NavItem(
                  icon: Icons.people_outlined,
                  label: 'Users',
                  index: 2,
                  selected: selectedIndex == 2,
                  onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool selected;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? _green : _textSecondary;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared App Header ────────────────────────────────────────────────────────

class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _bgCardLight,
              borderRadius: BorderRadius.circular(21),
              border: Border.all(color: _green.withOpacity(0.4)),
            ),
            child:
                const Icon(Icons.movie_filter_rounded, color: _green, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'PSAUni',
                      style: TextStyle(
                          color: _green,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: 'Films',
                      style: TextStyle(
                          color: _textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Text('Officer Dashboard',
                  style: TextStyle(color: _textSecondary, fontSize: 12)),
            ],
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded, color: _textPrimary, size: 24),
            color: _bgCard,
            onSelected: (value) async {
              if (value == 'logout') {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded,
                        color: Colors.redAccent, size: 18),
                    SizedBox(width: 10),
                    Text('Log Out', style: TextStyle(color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Dashboard Tab ────────────────────────────────────────────────────────────

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    final pending = _submissions
        .where((s) => s.status == SubmissionStatus.pending)
        .toList();
    final modQueue = pending.take(3).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _AppHeader(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _StatCard(
                            label: 'Pending\nReviews',
                            value: '${pending.length}',
                            icon: Icons.inbox_rounded,
                            color: _pendingColor),
                        const SizedBox(width: 8),
                        _StatCard(
                            label: 'Approved\nToday',
                            value: '3',
                            icon: Icons.check_circle_outline,
                            color: _approvedColor),
                        const SizedBox(width: 8),
                        _StatCard(
                            label: 'Returned\nToday',
                            value: '2',
                            icon: Icons.undo_rounded,
                            color: _returnedColor),
                        const SizedBox(width: 8),
                        _StatCard(
                            label: 'Support\nTickets',
                            value: '5',
                            icon: Icons.chat_bubble_outline,
                            color: _textSecondary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Moderation Queue',
                        style: TextStyle(
                            color: _textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _ModerationCard(submission: modQueue[i]),
              childCount: modQueue.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 4),
                _MenuRow(
                    icon: Icons.description_outlined,
                    label: 'View All Submissions',
                    onTap: () {}),
                _MenuRow(
                    icon: Icons.people_outlined,
                    label: 'User Management',
                    onTap: () {}),
                _MenuRow(
                    icon: Icons.lock_outline_rounded,
                    label: 'Manage Permissions',
                    onTap: () {}),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: _textSecondary, fontSize: 10, height: 1.3)),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(value,
                    style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 4),
                Icon(icon, color: color, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModerationCard extends StatelessWidget {
  final FilmSubmission submission;

  const _ModerationCard({required this.submission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          _FilmThumbnail(colorHex: submission.imagePlaceholder),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(submission.title,
                    style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Text('Student: ${submission.studentName}',
                    style:
                        const TextStyle(color: _textSecondary, fontSize: 12)),
                Text('Theme: ${submission.theme}',
                    style:
                        const TextStyle(color: _textSecondary, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _ActionButton(
                        label: 'View Details',
                        color: _bgCardLight,
                        textColor: _textPrimary,
                        onTap: () {}),
                    const SizedBox(width: 6),
                    _ActionButton(
                        label: 'Approve',
                        color: _green,
                        textColor: Colors.white,
                        onTap: () {}),
                    const SizedBox(width: 6),
                    _ActionButton(
                        label: 'Decline / Edit',
                        color: _returnedColor,
                        textColor: Colors.white,
                        onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionButton(
      {required this.label,
      required this.color,
      required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Text(label,
            style: TextStyle(
                color: textColor, fontSize: 10, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuRow(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Row(
          children: [
            Icon(icon, color: _textSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
                child: Text(label,
                    style: const TextStyle(color: _textPrimary, fontSize: 14))),
            const Icon(Icons.chevron_right_rounded,
                color: _textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─── Submissions Tab ──────────────────────────────────────────────────────────

class _SubmissionsTab extends StatefulWidget {
  const _SubmissionsTab();

  @override
  State<_SubmissionsTab> createState() => _SubmissionsTabState();
}

class _SubmissionsTabState extends State<_SubmissionsTab> {
  int _filterIndex = 0;
  String _search = '';
  final _controller = TextEditingController();

  List<FilmSubmission> get _filtered {
    final statusFilter = [
      null,
      SubmissionStatus.pending,
      SubmissionStatus.approved,
      SubmissionStatus.returned,
    ][_filterIndex];

    return _submissions.where((s) {
      final matchStatus = statusFilter == null || s.status == statusFilter;
      final matchSearch = _search.isEmpty ||
          s.title.toLowerCase().contains(_search.toLowerCase()) ||
          s.studentName.toLowerCase().contains(_search.toLowerCase());
      return matchStatus && matchSearch;
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const _AppHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Text('Submissions',
                style: TextStyle(
                    color: _textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  _FilterChip(
                    label: ['All', 'Pending', 'Approved', 'Returned'][i],
                    selected: _filterIndex == i,
                    onTap: () => setState(() => _filterIndex = i),
                  ),
                  if (i < 3) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: _bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: TextField(
                controller: _controller,
                onChanged: (v) => setState(() => _search = v),
                style: const TextStyle(color: _textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search submissions...',
                  hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: _textSecondary, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filtered.length,
              itemBuilder: (_, i) =>
                  _SubmissionListTile(submission: _filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _green : _bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? _green : Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : _textSecondary,
            fontSize: 13,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _SubmissionListTile extends StatelessWidget {
  final FilmSubmission submission;

  const _SubmissionListTile({required this.submission});

  Color get _statusColor => switch (submission.status) {
        SubmissionStatus.pending => _pendingColor,
        SubmissionStatus.approved => _approvedColor,
        SubmissionStatus.returned => _returnedColor,
      };

  String get _statusLabel => switch (submission.status) {
        SubmissionStatus.pending => 'Pending',
        SubmissionStatus.approved => 'Approved',
        SubmissionStatus.returned => 'Returned',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          _FilmThumbnail(colorHex: submission.imagePlaceholder),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(submission.title,
                    style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(submission.studentName,
                    style:
                        const TextStyle(color: _textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('${submission.theme} • ${submission.year}',
                        style: const TextStyle(
                            color: _textSecondary, fontSize: 11)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(_statusLabel,
                          style: TextStyle(
                              color: _statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: _textSecondary),
        ],
      ),
    );
  }
}

// ─── Users Tab ────────────────────────────────────────────────────────────────

class _UsersTab extends StatefulWidget {
  const _UsersTab();

  @override
  State<_UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<_UsersTab> {
  String _search = '';

  List<AppUser> get _filtered => _users
      .where((u) =>
          _search.isEmpty ||
          u.name.toLowerCase().contains(_search.toLowerCase()) ||
          u.email.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const _AppHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              children: [
                const Text('Users',
                    style: TextStyle(
                        color: _textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: _green, borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('Add User',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: _bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: TextField(
                onChanged: (v) => setState(() => _search = v),
                style: const TextStyle(color: _textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search users...',
                  hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: _textSecondary, size: 20),
                  suffixIcon:
                      Icon(Icons.tune_rounded, color: _textSecondary, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filtered.length + 1,
              itemBuilder: (_, i) {
                if (i == _filtered.length) {
                  return _MenuRow(
                      icon: Icons.people_outline,
                      label: 'View All Users',
                      onTap: () {});
                }
                return _UserListTile(user: _filtered[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserListTile extends StatelessWidget {
  final AppUser user;

  const _UserListTile({required this.user});

  Color get _roleColor => switch (user.role) {
        'Moderator' => _moderatorColor,
        'Reviewer' => _reviewerColor,
        'Officer' => _officerColor,
        _ => _textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: _bgCardLight,
            child: Text(user.name[0],
                style: const TextStyle(
                    color: _green, fontWeight: FontWeight.w700, fontSize: 16)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Text(user.email,
                    style:
                        const TextStyle(color: _textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: _roleColor.withOpacity(0.85),
                borderRadius: BorderRadius.circular(6)),
            child: Text(user.role,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded,
              color: _textSecondary, size: 20),
        ],
      ),
    );
  }
}

// ─── Shared Widget ────────────────────────────────────────────────────────────

class _FilmThumbnail extends StatelessWidget {
  final String colorHex;

  const _FilmThumbnail({required this.colorHex});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse('FF$colorHex', radix: 16));
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.movie_outlined, color: Colors.white38, size: 28),
    );
  }
}
