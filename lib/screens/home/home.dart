import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../AI/ai.dart';
import '../health/health_overview.dart';
import '../health/health_page.dart';
import '../devices/devices_page.dart';
import '../profile/profile.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _sosPlayer = AudioPlayer();

  late AnimationController _sosController;
  late Animation<double> _sosScale;

  bool _sosPressed = false;
  bool _sosActive = false;

  // ==============================================================
  // COLORS
  // ==============================================================

  static const Color bgColor = Color(0xFFF5F5F5);
  static const Color primaryBlue = Color(0xFF174A91);
  static const Color textDark = Color(0xFF171B26);
  static const Color greyText = Color(0xFF737987);
  static const Color green = Color(0xFF20B486);

  // ==============================================================
  // INIT
  // ==============================================================

  @override
  void initState() {
    super.initState();

    _sosController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sosScale = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _sosController,
        curve: Curves.easeInOut,
      ),
    );
  }

  // ==============================================================
  // DISPOSE
  // ==============================================================

  @override
  void dispose() {
    _sosPlayer.dispose();
    _sosController.dispose();
    super.dispose();
  }

  // ==============================================================
  // GREETING
  // ==============================================================

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning 🌅';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon ☀️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening 🌇';
    } else {
      return 'Good Night 🌙';
    }
  }

  // ==============================================================
  // SOS AUDIO
  // ==============================================================

  Future<void> _startSOSSound() async {
    debugPrint("🔥 AUDIO FUNCTION CALLED");

    try {
      await _sosPlayer.setReleaseMode(ReleaseMode.loop);

      await _sosPlayer.play(
        AssetSource('sounds/sos_alarm.mp3'),
      );

      debugPrint("🔥 AUDIO PLAYING");
    } catch (e) {
      debugPrint("❌ AUDIO ERROR: $e");
    }
  }

  Future<void> _stopSOSSound() async {
    await _sosPlayer.stop();
  }

  // ==============================================================
  // ACTIVATE SOS
  // ==============================================================

  void _activateSOS() {
    if (_sosActive) return;

    setState(() {
      _sosActive = true;
    });

    _startSOSSound();
  }

  // ==============================================================
  // STOP SOS
  // ==============================================================

  void _stopSOS() {
    setState(() {
      _sosActive = false;
    });

    _stopSOSSound();
  }

  // ==============================================================
  // BUILD
  // ==============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: Column(
          children: [

            // ======================================================
            // HEADER
            // ======================================================

            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,

                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE9E9E9),
                    width: 1,
                  ),
                ),
              ),

              child: Row(
                children: [

                  // LOGO
                  ClipOval(
                    child: Image.asset(
                      'assets/images/tera_logo.jpeg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // APP NAME
                  const Text(
                    'TERA Health',

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: primaryBlue,
                    ),
                  ),

                  const Spacer(),

                  // HOME
                  const Text(
                    'Home',

                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3E3E46),
                    ),
                  ),

                  const SizedBox(width: 28),

                  // NOTIFICATION
                  Stack(
                    children: [

                      const Icon(
                        Icons.notifications_none_rounded,
                        size: 27,
                        color: Color(0xFF3E3E46),
                      ),

                      Positioned(
                        right: 2,
                        top: 1,

                        child: Container(
                          width: 6,
                          height: 6,

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ======================================================
            // HOME CONTENT
            // ======================================================

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    22,
                    20,
                    100,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // ==================================================
                      // GREETING
                      // ==================================================

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,

                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  getGreeting(),

                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                const Text(
                                  'How are you feeling today?',

                                  style: TextStyle(
                                    fontSize: 17,
                                    color: greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // HAND + MESSAGE
                          Row(
                            children: [

                              const Text(
                                '👋',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),

                              const SizedBox(width: 5),

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(0xFFFFE7E9),
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),

                                child: const Row(
                                  children: [

                                    Icon(
                                      Icons.favorite,
                                      size: 17,
                                      color:
                                          Color(0xFFC62828),
                                    ),

                                    SizedBox(width: 5),

                                    Text(
                                      'Stay Healthy\nStay Happy',

                                      style: TextStyle(
                                        fontSize: 10,
                                        height: 1.15,
                                        color:
                                            Color(0xFF7A3035),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ==================================================
                      // HEALTH OVERVIEW HEADER
                      // ==================================================

                      Row(
                        children: [

                          const Text(
                            'Health Overview',

                            style: TextStyle(
                              fontSize: 23,
                              fontWeight:
                                  FontWeight.w700,
                              color: textDark,
                            ),
                          ),

                          const Spacer(),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HealthOverview(),
                                ),
                              );
                            },

                            child: const Row(
                              children: [

                               

                                SizedBox(width: 4),

                               
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ==================================================
                      // ROW 1
                      // ==================================================

                      Row(
                        children: [

                          Expanded(
                            child: _healthCard(
                              icon: Icons.favorite,
                              iconColor:
                                  const Color(0xFFE32645),
                              iconBackground:
                                  const Color(0xFFFFDDE2),
                              title: 'Heart Rate',
                              value: '72',
                              unit: 'BPM',
                              status: 'Normal',
                              statusColor: green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: _healthCard(
                              icon: Icons.air,
                              iconColor:
                                  const Color(0xFF00AFC8),
                              iconBackground:
                                  const Color(0xFFD2F7FC),
                              title: 'SpO₂',
                              value: '98',
                              unit: '%',
                              status: 'Normal',
                              statusColor: green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ==================================================
                      // ROW 2
                      // ==================================================

                      Row(
                        children: [

                          Expanded(
                            child: _healthCard(
                              icon: Icons.thermostat,
                              iconColor:
                                  const Color(0xFFF07D1C),
                              iconBackground:
                                  const Color(0xFFFFEBD4),
                              title: 'Temperature',
                              value: '36.7',
                              unit: '°C',
                              status: 'Normal',
                              statusColor: green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: _quickHealthCard(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 34),

                      // ==================================================
                      // EMERGENCY SOS
                      // ==================================================

                      const Center(
                        child: Text(
                          'Emergency SOS',

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w700,
                            color: textDark,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // SOS BUTTON
                      Center(
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            _sosButton(),

                            if (_sosActive) ...[

                              const SizedBox(height: 24),

                              SizedBox(
                                width: 180,
                                height: 52,

                                child: ElevatedButton(
                                  onPressed: _stopSOS,

                                  style:
                                      ElevatedButton.styleFrom(
                                    elevation: 2,

                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                              14),
                                    ),
                                  ),

                                  child: const Text(
                                    'STOP SOS',

                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          'Get emergency help quickly',

                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF4F535C),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // ======================================================
            // BOTTOM NAVIGATION
            // ======================================================

            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // HEALTH CARD
  // ==============================================================

  Widget _healthCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String value,
    required String unit,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      height: 148,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE7E8EB),
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius:
                      BorderRadius.circular(11),
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                  size: 23,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,

                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5E626C),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [

              Text(
                value,

                style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w700,
                  color: textDark,
                ),
              ),

              const SizedBox(width: 4),

              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 4,
                ),

                child: Text(
                  unit,

                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                    color: Color(0xFF484B53),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [

              Container(
                width: 8,
                height: 8,

                decoration:
                    BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 4),

              Text(
                status,

                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // QUICK HEALTH CARD
  // ==============================================================

  Widget _quickHealthCard() {
    return Container(
      height: 148,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE7E8EB),
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // TOP ICONS
          Row(
            children: [

              _quickIcon(
                Icons.medical_services_outlined,
                const Color(0xFF00AFC8),
                const Color(0xFFF0E7FF),
              ),

              const SizedBox(width: 10),

              _quickIcon(
                Icons.directions_walk_outlined,
                const Color(0xFF20B486),
                const Color(0xFFE8FFF7),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [

              _quickIcon(
                Icons.bed_outlined,
                const Color(0xFF222222),
                const Color(0xFFF1F1F1),
              ),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HealthOverview(),
                    ),
                  );
                },

                child: const Row(
                  children: [

                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            Color(0xFF3768B0),
                      ),
                    ),

                    SizedBox(width: 4),

                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color:
                          Color(0xFF3768B0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // QUICK ICON
  // ==============================================================

  Widget _quickIcon(
    IconData icon,
    Color iconColor,
    Color background,
  ) {
    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
        color: background,

        borderRadius:
            BorderRadius.circular(11),

        border: Border.all(
          color: iconColor.withValues(alpha: 0.65),
          width: 1,
        ),
      ),

      child: Icon(
        icon,
        color: iconColor,
        size: 23,
      ),
    );
  }

  // ==============================================================
  // SOS BUTTON
  // ==============================================================

  Widget _sosButton() {
    return GestureDetector(

      onTapDown: (_) {
        setState(() {
          _sosPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _sosPressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          _sosPressed = false;
        });
      },

      onLongPressStart: (_) {
        _activateSOS();
      },

      child: AnimatedScale(
        scale: _sosPressed ? 0.92 : 1.0,

        duration:
            const Duration(milliseconds: 120),

        curve: Curves.easeOut,

        child: ScaleTransition(
          scale: _sosScale,

          child: Container(
            width: 116,
            height: 116,

            padding:
                const EdgeInsets.all(8),

            decoration: const BoxDecoration(
              shape: BoxShape.circle,

              color: Color(0xFFBFC2C5),

              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),

            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: const Color(0xFFE50914),

                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),

              child: const Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Text(
                    'HOLD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 2),

                  Icon(
                    Icons.pan_tool,
                    color: Colors.white,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // BOTTOM NAVIGATION
  // ==============================================================

  Widget _bottomNavigation() {
    return Container(
      height: 78,

      decoration: const BoxDecoration(
        color: Colors.white,

        border: Border(
          top: BorderSide(
            color: Color(0xFFE8E8E8),
          ),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,

        children: [

          // AI
          _NavItem(
            icon: Icons.smart_toy_outlined,
            label: 'AI',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AiPage(),
                ),
              );
            },
          ),

          // HEALTH
          _NavItem(
  icon: Icons.favorite_border,
  label: 'Health',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HealthPage(),
      ),
    );
  },
),

          // HOME
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: true,
          ),

          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                  builder: (context) => DevicesPage(),

                 ),
              );
            },
            child:  _BottomItem(
              Icons.watch_outlined,
              'devices',
            ),
          ),

          // PROFILE
           GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                  builder: (context) => ProfilePage(),

                 ),
              );
            },
            child:  _BottomItem(
              Icons.person_outline,
              'profile',
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// NAV ITEM
// ================================================================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final Color color = selected
        ? const Color(0xFF174A91)
        : const Color(0xFF4D515A);

    return GestureDetector(
      onTap: onTap,

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 24,
            color: color,
          ),

          const SizedBox(height: 4),

          Text(
            label,

            style: TextStyle(
              fontSize: 11,

              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,

              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _BottomItem(
    this.icon,
    this.label, {
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFF174A91)
        : const Color(0xFF737782);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 23,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: selected
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}