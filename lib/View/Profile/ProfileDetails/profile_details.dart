import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:bright_weddings/View/Discover/discover_page.dart';
import 'package:bright_weddings/View/Login/home.dart';
import 'package:bright_weddings/View/Matches/matches_page.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 3; // Profile selected by default
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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

        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFE5EC),
                    Color(0xFFFFC1E3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Row(
              children: [
                const Icon(Icons.person, size: 22),
                const SizedBox(width: 8),
                Text(
                  "Profile",
                  style: GoogleFonts.kodchasan(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Background glow circles
                Positioned(
                  top: -60,
                  right: -30,
                  child:
                      _buildGlowCircle(120, Colors.white.withOpacity(0.25)),
                ),
                Positioned(
                  bottom: -80,
                  left: -20,
                  child:
                      _buildGlowCircle(150, Colors.white.withOpacity(0.2)),
                ),
                Positioned(
                  top: 160,
                  left: 0,
                  child: _buildGlowCircle(70, Colors.white.withOpacity(0.15)),
                ),

                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile avatar with edit button in soft card
                        _wrapInCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: AssetImage(
                                      'assets/images/loginCouple.png',
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 4,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.redAccent,
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "Kisuke",
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "kisuke@gmail.com",
                                style: GoogleFonts.lato(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Contact Info
                        _wrapInCard(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.phone,
                                    color: Colors.redAccent),
                                title: Text(
                                  "9876543210",
                                  style: GoogleFonts.lato(fontSize: 15),
                                ),
                              ),
                              const Divider(height: 1),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.location_on,
                                    color: Colors.redAccent),
                                title: Text(
                                  "Bangalore, India",
                                  style: GoogleFonts.lato(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _buildStatCard("Connected", "07"),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard("Likes", "18"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Settings + Logout
                        _wrapInCard(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.settings,
                                    color: Colors.redAccent),
                                title: Text(
                                  "Settings",
                                  style: GoogleFonts.lato(fontSize: 15),
                                ),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.logout,
                                    color: Colors.red),
                                title: Text(
                                  "Logout",
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginHome(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    Get.to(
                      () => DashboardMob(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 350),
                    );
                    break;
                  case 1: // Matches
                    Get.to(
                      () => const MatchesPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 350),
                    );
                    break;
                  case 2: // Messages
                    Get.to(
                      () => Chat(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 300),
                    );
                    break;
                  case 3: // Profile (already here)
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined),
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Discover'),
              ],
            ),
          ),
        );
      },
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

  Widget _wrapInCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: padding ?? const EdgeInsets.all(16),
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

  Widget _buildStatCard(String title, String value) {
    return _wrapInCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
