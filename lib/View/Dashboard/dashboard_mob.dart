import 'package:bright_weddings/Component/AppBar/header.dart';
import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';
import 'package:bright_weddings/Component/Dashboard/profile_list/profile_list_tab.dart';
import 'package:bright_weddings/Controller/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Component/Dashboard/New Profile/new_profile_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bright_weddings/View/Discover/discover_page.dart';
import 'package:bright_weddings/View/Matches/matches_page.dart';

class DashboardMob extends StatefulWidget {
  DashboardMob({super.key});

  @override
  _DashboardMobState createState() => _DashboardMobState();
}

class _DashboardMobState extends State<DashboardMob>
    with SingleTickerProviderStateMixin {
  final ScreenController controller = Get.find<ScreenController>();
  int _currentIndex = 0;

  late final AnimationController _bgController;

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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _viewAllButton() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'View all',
        style: TextStyle(fontSize: 13),
      ),
    );
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
                // Subtle animated circles in background
                Positioned(
                  top: -80,
                  right: -40,
                  child: _buildGlowCircle(120, Colors.white.withOpacity(0.25)),
                ),
                Positioned(
                  bottom: -60,
                  left: -20,
                  child: _buildGlowCircle(150, Colors.white.withOpacity(0.2)),
                ),
                Positioned(
                  top: 140,
                  left: 10,
                  child: _buildGlowCircle(70, Colors.white.withOpacity(0.15)),
                ),

                // Main content
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),

                        // Title
                        _buildAnimatedHeading(),

                        const SizedBox(height: 16),

                        // Search bar
                        _buildSearchBar(),

                        const SizedBox(height: 18),

                        // Quick filters row
                        _buildQuickFilters(),

                        const SizedBox(height: 18),

                        // Community card
                        _buildCommunityCard(),

                        const SizedBox(height: 20),

                        // New Profiles section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionTitle('New Profiles'),
                            _viewAllButton(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _wrapInCard(
                          child: NewProfileTab(bodyContext: context),
                        ),

                        const SizedBox(height: 24),

                        // Recommendations section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSectionTitle('Recommendations'),
                            const Icon(
                              Icons.auto_awesome,
                              size: 18,
                              color: Colors.redAccent,
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        _wrapInCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              child: ProfileListTab(),
                            ),
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
            if (index == _currentIndex) return;

            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0: // Home
                // Already here
                break;
              case 1: // Matches
                Get.to(() => const MatchesPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 350));
                break;
              case 2: // Messages
                Get.to(() => Chat(),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 300));
                break;
              case 3: // Profile
                Get.to(() => ProfileDetails(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 300));
                break;
              case 4: // Discover
                Get.to(() => DiscoverPage(),
                    transition: Transition.zoom,
                    duration: const Duration(milliseconds: 320));
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

  Widget _buildAnimatedHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.9),
          ),
          child: const Text('Find your perfect'),
        ),
        const SizedBox(height: 2),
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
            'Match!',
            style: GoogleFonts.kodchasan(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // masked by Shader
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Hero(
      tag: 'dashboard_search',
      child: Material(
        color: Colors.transparent,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.9),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: 'Search for partner',
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

  Widget _buildQuickFilters() {
    final filters = [
      {'icon': Icons.favorite, 'label': 'Top matches'},
      {'icon': Icons.flash_on, 'label': 'New today'},
      {'icon': Icons.place, 'label': 'Nearby'},
      {'icon': Icons.shield_moon, 'label': 'Horoscope'},
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = filters[index];
          return _buildFilterChip(
            icon: item['icon'] as IconData,
            label: item['label'] as String,
          );
        },
      ),
    );
  }

  Widget _buildFilterChip({required IconData icon, required String label}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.redAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard() {
    return _wrapInCard(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFFE5EC),
          Color(0xFFE3F2FD),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Welcome!\nJoin your nearest Community.",
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.group, size: 16),
            label: const Text("Join"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wrapInCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    Gradient? gradient,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
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
}

Widget _buildCategory(IconData icon, String title) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 46, color: Colors.deepPurple.shade300),
          const SizedBox(height: 9),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}
