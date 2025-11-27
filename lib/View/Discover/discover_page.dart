import 'package:bright_weddings/View/Matches/matches_page.dart';
import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bright_weddings/View/Dashboard/chat.dart';
import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bright_weddings/View/Login/home.dart'; // (still here if you use later)

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 4; // Discover selected by default

  late final AnimationController _bgController;

  final List<Map<String, String>> profiles = [
    {
      "name": "Nandana",
      "bio":
          "I go crazy for beach vacations 🌊. I love long walks near the shore, sunsets, and peaceful moments by the sea.\n\n"
              "Apart from the beach, I’m a foodie and love trying out new cuisines. Cooking experiments at home are my stress-buster. "
              "Books are another big part of my life, especially novels and travel stories. Music is my daily therapy, and I enjoy "
              "singing whenever I get time.\n\n"
              "I believe in positivity, kindness, and building meaningful connections. Looking for someone who values family, "
              "respects individuality, and shares a love for adventure.\n\n"
              "Fun fact: I have a bucket list with over 50 destinations, and I’ve only completed 7 so far 😅.",
      "image": "assets/images/profile1.png",
    },
    {
      "name": "Arjun",
      "bio":
          "Adventure is my second name. Trekking, hiking, and exploring unexplored places give me a high 🏞️.\n\n"
              "Photography is my passion – nature, people, and candid shots are my favorite subjects. I also enjoy fitness and "
              "try to keep a balanced lifestyle with workouts and healthy food.\n\n"
              "Fun fact: I once did a 15-day Himalayan trek without network and it was the best detox ever 📵.",
      "image": "assets/images/profile2.png",
    },
    {
      "name": "Priya",
      "bio":
          "Bookworm 📚 and coffee lover ☕. You’ll often find me curled up with a novel or writing in my journal.\n\n"
              "I love cooking experimental dishes for my friends and family – food brings people together. "
              "Movies and music are my go-to relaxation, but I also enjoy weekend road trips whenever possible.\n\n"
              "Fun fact: I once read 10 books in a single week during college holidays 🤓.",
      "image": "assets/images/profile3.png",
    },
    {
      "name": "Rahul",
      "bio":
          "Tech geek 💻 and travel addict ✈️. By profession, I’m into software development, but outside work I love exploring "
              "new countries and cultures.\n\n"
              "I also like to spend time volunteering for social causes whenever possible.\n\n"
              "Fun fact: I once backpacked across 5 European countries in just 20 days 🎒.",
      "image": "assets/images/profile4.png",
    },
    {
      "name": "Sneha",
      "bio":
          "Creative soul 🎨 with a passion for painting, photography, and dance. I enjoy expressing myself through art "
              "and love visiting art galleries and cultural festivals.\n\n"
              "Fun fact: I once painted a mural that ended up being featured in a local magazine 🖌️.",
      "image": "assets/images/profile5.png",
    },
  ];

  int currentIndex = 0;

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

  void _nextProfile({required bool liked}) {
    final profile = profiles[currentIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          liked
              ? "You liked ${profile['name']}"
              : "You skipped ${profile['name']}",
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: liked ? Colors.green : Colors.red,
      ),
    );

    setState(() {
      if (currentIndex < profiles.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = profiles[currentIndex];

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
            centerTitle: true,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.explore, size: 22),
                const SizedBox(width: 8),
                Text(
                  "Discover",
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
                // background glow
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
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        // Heading + small info chip
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  "Discover Matches",
                                  style: GoogleFonts.kodchasan(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.swipe, size: 16,
                                        color: Colors.redAccent),
                                    SizedBox(width: 6),
                                    Text(
                                      "Swipe to explore",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Profile image card
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.96, end: 1.0),
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutBack,
                          key: ValueKey(currentIndex),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    profile["image"]!,
                                    height: 400,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          profile["name"]!,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                blurRadius: 6,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.favorite,
                                                size: 16,
                                                color: Colors.redAccent,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Potential match",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Like/Dislike buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton(
                                heroTag: "dislike",
                                backgroundColor: Colors.white,
                                elevation: 4,
                                child: const Icon(Icons.close,
                                    size: 32, color: Colors.redAccent),
                                onPressed: () => _nextProfile(liked: false),
                              ),
                              FloatingActionButton(
                                heroTag: "like",
                                backgroundColor: Colors.redAccent,
                                elevation: 4,
                                child: const Icon(Icons.favorite,
                                    size: 32, color: Colors.white),
                                onPressed: () => _nextProfile(liked: true),
                              ),
                            ],
                          ),
                        ),

                        // Bio card
                        _wrapInCard(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile["name"]!,
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                profile["bio"]!,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
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
                  case 3: // Profile
                    Get.to(
                      () => const ProfileDetails(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300),
                    );
                    break;
                  case 4: // Discover (already here)
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
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin,
      child: AnimatedContainer(
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
      ),
    );
  }
}
