import 'package:bright_weddings/View/Dashboard/dashboard_mob.dart';
import 'package:bright_weddings/View/Matches/matches_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bright_weddings/View/Discover/discover_page.dart';
import 'package:bright_weddings/View/Profile/ProfileDetails/profile_details.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messages',
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 2; // Messages selected by default

  late final AnimationController _bgController;

  final List<Map<String, dynamic>> groups = [
    {
      "title": "Tamil Wedding Community",
      "time": "23 min ago",
      "members": 320,
      "highlight": true,
    },
    {
      "title": "IT Professionals Group",
      "time": "12 min ago",
      "members": 180,
      "highlight": false,
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
                const Icon(Icons.message_outlined, size: 22),
                const SizedBox(width: 8),
                Text(
                  "Messages",
                  style: GoogleFonts.kodchasan(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
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
                // Glowing circles for background
                Positioned(
                  top: -60,
                  right: -30,
                  child:
                      _buildGlowCircle(110, Colors.white.withOpacity(0.25)),
                ),
                Positioned(
                  bottom: -80,
                  left: -20,
                  child:
                      _buildGlowCircle(150, Colors.white.withOpacity(0.2)),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  child: _buildGlowCircle(70, Colors.white.withOpacity(0.15)),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Conversation Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Conversations",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
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
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.shield_rounded,
                                      size: 16, color: Colors.redAccent),
                                  SizedBox(width: 6),
                                  Text(
                                    "Safe & Secure",
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
                        const SizedBox(height: 10),

                        _wrapInCard(
                          child: Column(
                            children: [
                              _buildConversationTile(context),
                              const SizedBox(height: 8),
                              _buildConversationTile(context),
                              const SizedBox(height: 8),
                              _buildConversationTile(context),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Groups Section
                        Text(
                          "Community Groups",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Expanded(
                          child: _wrapInCard(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 8),
                            child: ListView.builder(
                              itemCount: groups.length,
                              itemBuilder: (context, index) {
                                var group = groups[index];
                                return _buildGroupTile(group);
                              },
                            ),
                          ),
                        ),
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
                    // Already here
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

  Widget _buildConversationTile(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      leading: const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage("assets/avatar.png"),
      ),
      title: Text(
        "Seb",
        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text(
        "That’s wonderful. I feel the same way as well. 😊",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "09:45",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.redAccent,
            child: const Text(
              "2",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatDetailScreen()),
        );
      },
    );
  }

  Widget _buildGroupTile(Map<String, dynamic> group) {
    final highlight = group["highlight"] as bool;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: highlight
          ? const Color(0xFFE3F2FD)
          : Colors.white.withOpacity(0.98),
      child: ListTile(
        title: Text(
          group["title"],
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
            fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: Text(
          group["time"],
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.group, size: 22),
            const SizedBox(width: 6),
            Text("${group["members"]}+"),
            if (highlight)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(Icons.star, color: Colors.amber, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}

/// --------------------
/// Chat Detail Page
/// --------------------
class ChatDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages = [
    {
      "isMe": false,
      "text": "Hi, I saw your profile on the matrimony app. How are you?",
      "time": "09:30",
    },
    {
      "isMe": true,
      "text": "Hello! I'm doing good, thank you. How about you?",
      "time": "09:32",
    },
    {
      "isMe": false,
      "text":
          "I’m good too. I noticed we share similar interests in travel and cooking.",
      "time": "09:35",
    },
    {
      "isMe": true,
      "text":
          "Yes, I enjoy exploring new places and trying new recipes. That’s great!",
      "time": "09:37",
    },
    {
      "isMe": false,
      "text": "What are you looking for in a life partner?",
      "time": "09:40",
    },
    {
      "isMe": true,
      "text":
          "I value honesty, mutual respect, and someone who shares family values.",
      "time": "09:42",
    },
    {
      "isMe": false,
      "text": "That’s wonderful. I feel the same way as well. 😊",
      "time": "09:45",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          children: const [
            CircleAvatar(backgroundImage: AssetImage("assets/avatar.png")),
            SizedBox(width: 10),
            Text("Seb"),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE5EC),
              Color(0xFFE3F2FD),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var msg = messages[index];
                  final isMe = msg["isMe"] as bool;
                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 280),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.redAccent
                            : Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isMe ? 16 : 4),
                          topRight: Radius.circular(isMe ? 4 : 16),
                          bottomLeft: const Radius.circular(16),
                          bottomRight: const Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        msg["text"],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.white.withOpacity(0.95),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.redAccent),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: const TextStyle(fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.redAccent),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
