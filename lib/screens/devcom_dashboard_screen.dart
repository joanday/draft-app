import 'package:flutter/material.dart';

class DevcomDashboardScreen extends StatefulWidget {
  const DevcomDashboardScreen({super.key});

  @override
  State<DevcomDashboardScreen> createState() => _DevcomDashboardScreenState();
}

class _DevcomDashboardScreenState extends State<DevcomDashboardScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _queue = [
    {
      'title': 'Threads of Life',
      'student': 'Maria Santos',
      'theme': 'Agriculture'
    },
    {
      'title': 'Harvest of Hope',
      'student': 'Juan Dela Cruz',
      'theme': 'Agriculture'
    },
    {
      'title': 'Harmony in Diversity',
      'student': 'Ana Reyes',
      'theme': 'Culture'
    },
  ];

  final List<Map<String, dynamic>> _submissions = [
    {
      'title': 'Threads of Life',
      'student': 'Maria Santos',
      'theme': 'Agriculture',
      'year': '2024',
      'status': 'Pending'
    },
    {
      'title': 'Harvest of Hope',
      'student': 'Juan Dela Cruz',
      'theme': 'Agriculture',
      'year': '2024',
      'status': 'Pending'
    },
    {
      'title': 'Harmony in Diversity',
      'student': 'Ana Reyes',
      'theme': 'Culture',
      'year': '2024',
      'status': 'Approved'
    },
    {
      'title': 'Path of Sustainable Living',
      'student': 'Luis Ramirez',
      'theme': 'Environment',
      'year': '2024',
      'status': 'Returned'
    },
    {
      'title': 'Voices of Resilience',
      'student': 'Sofia Martinez',
      'theme': 'Education',
      'year': '2024',
      'status': 'Approved'
    },
  ];

  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Maria Santos',
      'email': 'maria.santos@psauni.edu.ph',
      'role': 'Moderator'
    },
    {
      'name': 'Juan Dela Cruz',
      'email': 'juan.delacruz@psauni.edu.ph',
      'role': 'Moderator'
    },
    {
      'name': 'Ana Reyes',
      'email': 'ana.reyes@psauni.edu.ph',
      'role': 'Reviewer'
    },
    {
      'name': 'Luis Ramirez',
      'email': 'luis.ramirez@psauni.edu.ph',
      'role': 'Officer'
    },
    {
      'name': 'Sofia Martinez',
      'email': 'sofia.martinez@psauni.edu.ph',
      'role': 'Moderator'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDashboard(),
          _buildSubmissions(),
          _buildUsers(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF0D1F17),
            border: Border(top: BorderSide(color: Color(0xFF1E3528)))),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          backgroundColor: const Color(0xFF0D1F17),
          selectedItemColor: const Color(0xFF4CAF50),
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined),
                activeIcon: Icon(Icons.description_rounded),
                label: 'Submissions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outlined),
                activeIcon: Icon(Icons.people_rounded),
                label: 'Users'),
          ],
        ),
      ),
    );
  }

  // ── Dashboard Tab ──────────────────────────────────────
  Widget _buildDashboard() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _devcomAppBar(),
          const SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              _statCard('Pending\nReviews', '12',
                  Icons.mark_email_unread_outlined, Colors.amber),
              const SizedBox(width: 10),
              _statCard('Approved\nToday', '3', Icons.check_circle_outline,
                  const Color(0xFF4CAF50)),
              const SizedBox(width: 10),
              _statCard('Returned\nToday', '2', Icons.undo_outlined,
                  Colors.redAccent),
              const SizedBox(width: 10),
              _statCard('Support\nTickets', '5', Icons.chat_outlined,
                  Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 20),

          const Text('Moderation Queue',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          ..._queue.map((item) => _queueCard(item)),
          const SizedBox(height: 8),

          _menuTile(Icons.list_alt_outlined, 'View All Submissions'),
          const SizedBox(height: 8),
          _menuTile(Icons.people_outline, 'User Management'),
          const SizedBox(height: 8),
          _menuTile(Icons.lock_outline, 'Manage Permissions'),
        ],
      ),
    );
  }

  // ── Submissions Tab ───────────────────────────────────
  Widget _buildSubmissions() {
    String _filter = 'All';
    return StatefulBuilder(
      builder: (context, setLocalState) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _devcomAppBar(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Submissions',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),

                  // Filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Pending', 'Approved', 'Returned']
                          .map((f) => GestureDetector(
                                onTap: () => setLocalState(() => _filter = f),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: _filter == f
                                          ? const Color(0xFF4CAF50)
                                          : const Color(0xFF1A2E22),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(f,
                                      style: TextStyle(
                                          color: _filter == f
                                              ? Colors.white
                                              : Colors.white54,
                                          fontSize: 13)),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Search
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A2E22),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(children: const [
                      SizedBox(width: 10),
                      Icon(Icons.search, color: Colors.white38, size: 18),
                      SizedBox(width: 8),
                      Text('Search submissions...',
                          style:
                              TextStyle(color: Colors.white38, fontSize: 12)),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _submissions.length,
                itemBuilder: (_, i) => _submissionTile(_submissions[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Users Tab ─────────────────────────────────────────
  Widget _buildUsers() {
    return SafeArea(
      child: Column(
        children: [
          _devcomAppBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Users',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add User', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFF1A2E22),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: const [
                SizedBox(width: 10),
                Icon(Icons.search, color: Colors.white38, size: 18),
                SizedBox(width: 8),
                Text('Search users...',
                    style: TextStyle(color: Colors.white38, fontSize: 12)),
              ]),
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _users.length,
              itemBuilder: (_, i) => _userTile(_users[i]),
            ),
          ),

          // View all
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('View All Users',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  Icon(Icons.chevron_right, color: Colors.white54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared Widgets ────────────────────────────────────
  Widget _devcomAppBar() => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFB8960C), width: 1.5),
                color: const Color(0xFF1A3528),
              ),
              child: const Icon(Icons.person_outline,
                  color: Color(0xFFB8960C), size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('PSAUniFilms',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  Text('Officer Dashboard',
                      style: TextStyle(fontSize: 11, color: Colors.white54)),
                ],
              ),
            ),
            IconButton(
                icon: const Icon(Icons.menu, color: Colors.white54),
                onPressed: () {}),
          ],
        ),
      );

  Widget _statCard(String label, String value, IconData icon, Color color) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white54, fontSize: 9, height: 1.3)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  Icon(icon, color: color, size: 16),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _queueCard(Map<String, dynamic> item) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFF1A2E22),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                  'https://picsum.photos/seed/${item['title']}/80/60',
                  width: 60,
                  height: 45,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      width: 60, height: 45, color: const Color(0xFF0D1F17))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  Text('Student: ${item['student']}',
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 11)),
                  Text('Theme: ${item['theme']}',
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 11)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _actionBtn(
                          'View Details', Colors.white24, Colors.white70),
                      const SizedBox(width: 6),
                      _actionBtn(
                          'Approve', const Color(0xFF4CAF50), Colors.white),
                      const SizedBox(width: 6),
                      _actionBtn('Decline / Edit', const Color(0xFFE53935),
                          Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _actionBtn(String label, Color bg, Color fg) => GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration:
              BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
          child: Text(label,
              style: TextStyle(
                  color: fg, fontSize: 10, fontWeight: FontWeight.w500)),
        ),
      );

  Widget _menuTile(IconData icon, String label) => Container(
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
            color: const Color(0xFF1A2E22),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: Colors.white54, size: 22),
          title: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          trailing: const Icon(Icons.chevron_right, color: Colors.white38),
          onTap: () {},
        ),
      );

  Widget _submissionTile(Map<String, dynamic> item) {
    Color statusColor;
    switch (item['status']) {
      case 'Approved':
        statusColor = const Color(0xFF4CAF50);
        break;
      case 'Returned':
        statusColor = const Color(0xFFE53935);
        break;
      default:
        statusColor = Colors.amber;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFF1A2E22),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
                'https://picsum.photos/seed/${item['title']}/80/60',
                width: 55,
                height: 42,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 55, height: 42, color: const Color(0xFF0D1F17))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                Text(item['student'],
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 11)),
                Text('${item['theme']} • ${item['year']}',
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: statusColor.withOpacity(0.5))),
                child: Text(item['status'],
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userTile(Map<String, dynamic> user) {
    Color roleColor;
    switch (user['role']) {
      case 'Moderator':
        roleColor = Colors.blueAccent;
        break;
      case 'Reviewer':
        roleColor = Colors.purpleAccent;
        break;
      default:
        roleColor = const Color(0xFF4CAF50);
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFF1A2E22),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF0D1F17),
            child: Text(user['name'].toString().substring(0, 1),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
                Text(user['email'],
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: roleColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6)),
            child: Text(user['role'],
                style: TextStyle(
                    color: roleColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
        ],
      ),
    );
  }
}
