import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:bright_weddings/View/Discover/discover_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with SingleTickerProviderStateMixin {
  int _selectedFilterIndex = 0;

  // ✅ Matches tab should be selected by default
  int _currentIndex = 1;

  late final AnimationController _bgController;

  final List<String> _filters = [
    'All',
    'Top Matches',
    'New',
    'Nearby',
  ];

  // Dummy data for now – later you can replace with API / Firestore / GetX data
  final List<Map<String, dynamic>> _matches = [
    {
      'name': 'Ananya Sharma',
      'age': 25,
      'location': 'Chennai',
      'profession': 'Software Engineer',
      'matchPercent': 92,
      'tags': ['Same Community', 'Non-Smoker', 'Vegetarian'],
    },
    {
      'name': 'Rahul Verma',
      'age': 28,
      'location': 'Bangalore',
      'profession': 'Data Analyst',
      'matchPercent': 88,
      'tags': ['Similar Interests', 'Music Lover'],
    },
    {
      'name': 'Priya Iyer',
      'age': 26,
      'location': 'Coimbatore',
      'profession': 'Doctor',
      'matchPercent': 85,
      'tags': ['Family Oriented', 'Traditional'],
    },
    {
      'name': 'Karthik N',
      'age': 29,
      'location': 'Hyderabad',
      'profession': 'Product Manager',
      'matchPercent': 80,
      'tags': ['Fitness', 'Pet Lover'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          final color1 = Color.lerp(
            const Color(0xFFFFE5EC),
            const Color(0xFFE3F2FD),
            _bgController.value,
          )!;
          final color2 = Color.lerp(
            const Color(0xFFFFC1E3),
            const Color(0xFFBBDEFB),
            1 - _bgController.value,
          )!;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Glowing circles background
                Positioned(
                  top: -60,
                  right: -30,
                  child: _buildGlowCircle(120, Colors.white.withOpacity(0.25)),
                ),
                Positioned(
                  bottom: -80,
                  left: -20,
                  child: _buildGlowCircle(150, Colors.white.withOpacity(0.2)),
                ),
                Positioned(
                  top: 140,
                  left: 10,
                  child: _buildGlowCircle(70, Colors.white.withOpacity(0.15)),
                ),

                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeading(),

                        const SizedBox(height: 16),

                        // Search bar
                        _buildSearchBar(),

                        const SizedBox(height: 16),

                        // Filter chips row
                        _buildFilterRow(),

                        const SizedBox(height: 18),

                        // Matches list wrapped in soft card
                        _wrapInCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 14),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _matches.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final match = _matches[index];
                              return _buildMatchCard(match, context, index);
                            },
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFE5EC),
              Color(0xFFE3F2FD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return; // ✅ avoid re-navigating

            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0: // Home
                Get.to(
                  () => DashboardMob(),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 350),
                );
                break;
              case 1: // Matches – already here
                break;
              case 2: // Messages
                Get.to(
                  () => Chat(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 300),
                );
                break;
              case 3: // Profile
                Get.to(
                  () => ProfileDetails(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 300),
                );
                break;
              case 4: // Discover
                Get.to(
                  () => DiscoverPage(),
                  transition: Transition.zoom,
                  duration: const Duration(milliseconds: 320),
                );
                break;
            }
          },
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Matches',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: 'Messages',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          ],
        ),
      ),
    );
  }

  // === UI Pieces ===

  Widget _buildGlowCircle(double size, Color color) {
    return AnimatedScale(
      scale: 1 + (_bgController.value * 0.06),
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Colors.redAccent,
                Color(0xFFFF758C),
                Color(0xFFFFA07A),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Your Matches',
            style: GoogleFonts.kodchasan(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.auto_awesome, size: 16, color: Colors.redAccent.shade200),
            const SizedBox(width: 6),
            Text(
              'Based on your preferences & activity',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: 'matches_search',
      child: Material(
        color: Colors.transparent,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.96),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: 'Search within your matches',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedFilterIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilterIndex = index;
              });
              // TODO: Apply real filtering logic based on index
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [
                          Colors.redAccent,
                          Color(0xFFFF758C),
                        ],
                      )
                    : null,
                color: isSelected
                    ? null
                    : Colors.white.withOpacity(0.95),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: isSelected
                      ? Colors.redAccent
                      : Colors.grey.shade300,
                  width: 0.7,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _iconForFilter(_filters[index]),
                    size: 16,
                    color: isSelected ? Colors.white : Colors.redAccent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _filters[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
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

  IconData _iconForFilter(String filter) {
    switch (filter) {
      case 'Top Matches':
        return Icons.favorite;
      case 'New':
        return Icons.flash_on;
      case 'Nearby':
        return Icons.place;
      default:
        return Icons.filter_list;
    }
  }

  Widget _wrapInCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.98),
            Colors.white.withOpacity(0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.7),
          width: 0.6,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildMatchCard(
      Map<String, dynamic> match, BuildContext context, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: Duration(milliseconds: 250 + (index * 80)),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.08),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.redAccent.withOpacity(0.12),
              child: Text(
                (match['name'] as String).substring(0, 1),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Match %
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          match['name'],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 14,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${match['matchPercent']}% match',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Age, location, profession
                  Text(
                    '${match['age']} • ${match['location']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    match['profession'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tags
                  if (match['tags'] != null && match['tags'].isNotEmpty)
                    SizedBox(
                      height: 24,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: match['tags'].length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 6),
                        itemBuilder: (context, index) {
                          final tag = match['tags'][index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 10),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => ProfileDetails());
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'View Profile',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: handle send interest / connect
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'Connect',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
