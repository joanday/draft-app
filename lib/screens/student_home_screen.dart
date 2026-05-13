import 'package:flutter/material.dart';

class StudentHomeScreen extends StatefulWidget {
  final VoidCallback? onSearchTap;
  const StudentHomeScreen({super.key, this.onSearchTap});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final List<Map<String, String>> themes = [
    {'icon': '🌾', 'label': 'Agriculture'},
    {'icon': '🏛️', 'label': 'Culture'},
    {'icon': '🌿', 'label': 'Environment'},
    {'icon': '📚', 'label': 'Education'},
    {'icon': '🤝', 'label': 'Community'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: const Color(0xFF0D1F17),
            floating: true,
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFB8960C), width: 1.5),
                    color: const Color(0xFF1A3528),
                  ),
                  child: const Icon(Icons.person_outline,
                      color: Color(0xFFB8960C), size: 20),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('PSAUniFilms',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Text('Student Films Showcase App',
                        style: TextStyle(fontSize: 10, color: Colors.white54)),
                  ],
                ),
              ],
            ),
            actions: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF1A3528),
                child: ClipOval(
                  child: Image.network(
                    'https://picsum.photos/seed/avatar/100/100',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person, color: Colors.white54),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search bar ─────────────────────────────────────────
                  GestureDetector(
                    onTap: widget.onSearchTap,
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2E22),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Icon(Icons.search, color: Colors.white38, size: 20),
                          SizedBox(width: 8),
                          Text('Search documentaries...',
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Featured
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Featured',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: () {},
                          child: const Text('View All',
                              style: TextStyle(
                                  color: Color(0xFF4CAF50), fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _featuredBanner(),
                  const SizedBox(height: 20),

                  // Continue Watching
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Continue Watching',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: () {},
                          child: const Text('View All',
                              style: TextStyle(
                                  color: Color(0xFF4CAF50), fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _horizontalFilmList(),
                  const SizedBox(height: 20),

                  // Browse by Theme
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Browse by Theme',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: () {},
                          child: const Text('View All',
                              style: TextStyle(
                                  color: Color(0xFF4CAF50), fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _themeChips(),
                  const SizedBox(height: 20),

                  // Newly Uploaded
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Newly Uploaded',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                          onPressed: () {},
                          child: const Text('View All',
                              style: TextStyle(
                                  color: Color(0xFF4CAF50), fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _newlyUploadedList(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuredBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            'https://picsum.photos/seed/featured/400/200',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: const Color(0xFF1A3528),
                child:
                    const Icon(Icons.movie, color: Colors.white24, size: 60)),
          ),
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4)),
              child: const Text('Agriculture',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          const Positioned(
            bottom: 36,
            left: 12,
            child:
                Icon(Icons.play_circle_filled, color: Colors.white, size: 40),
          ),
          const Positioned(
            bottom: 16,
            left: 12,
            child: Text('Voices of Resilience',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
          const Positioned(
            bottom: 2,
            left: 12,
            child: Text('2023 • 18:24',
                style: TextStyle(color: Colors.white60, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _horizontalFilmList() {
    final films = [
      {'title': 'Harvest of Hope', 'year': '2023', 'duration': '15:10'},
      {'title': 'Harmony in Diversity', 'year': '2024', 'duration': '20:31'},
      {
        'title': 'Path of Sustainable Living',
        'year': '2024',
        'duration': '16:45'
      },
    ];
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: films.length,
        itemBuilder: (_, i) {
          final film = films[i];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                      'https://picsum.photos/seed/film${i + 10}/300/200',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFF1A3528))),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xCC000000)],
                      ),
                    ),
                  ),
                  const Center(
                      child: Icon(Icons.play_circle_outline,
                          color: Colors.white70, size: 28)),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    right: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(film['title']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                        Text('${film['year']} • ${film['duration']}',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: 0.4 + (i * 0.2),
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
                      minHeight: 3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _themeChips() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: themes.length,
        itemBuilder: (_, i) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF2A4535), width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(themes[i]['icon']!, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 4),
                Text(themes[i]['label']!,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _newlyUploadedList() {
    final films = [
      {'title': 'Threads of Life', 'year': '2024', 'duration': '17:09'},
      {'title': 'Echoes of Tradition', 'year': '2024', 'duration': '14:22'},
      {'title': 'Fields of Tomorrow', 'year': '2023', 'duration': '13:48'},
    ];
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: films.length,
        itemBuilder: (_, i) {
          final film = films[i];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                      'https://picsum.photos/seed/new${i + 5}/300/200',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFF1A3528))),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xCC000000)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('New',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const Center(
                      child: Icon(Icons.play_circle_outline,
                          color: Colors.white70, size: 28)),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    right: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(film['title']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                        Text('${film['year']} • ${film['duration']}',
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
