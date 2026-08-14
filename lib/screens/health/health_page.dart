import 'package:flutter/material.dart';
import 'heart_rate.dart';
import 'spo2.dart';
import 'temperature.dart';
import 'hydration.dart';
import 'sleep_tracking.dart';
import 'weight_tracking.dart';
import 'steps_activity.dart';
import 'tera_insights.dart';
import '../home/home.dart';
import '../AI/ai.dart';
import '../devices/devices_page.dart';
class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  static const Color primaryBlue = Color(0xFF5555D9);
  static const Color darkText = Color(0xFF20222A);
  static const Color greyText = Color(0xFF666A74);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // =================================================
                    // TOP BAR
                    // =================================================

                    Row(
                      children: [
                        const Icon(
                          Icons.menu_rounded,
                          size: 25,
                          color: darkText,
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 24,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // =================================================
                    // TITLE
                    // =================================================

                    const Text(
                      'My Health',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Track your health',
                      style: TextStyle(
                        fontSize: 17,
                        color: greyText,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // =================================================
                    // HEALTH TITLE
                    // =================================================

                    const Text(
                      'Health',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // ROW 1
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.favorite,
                            iconColor: const Color(0xFFB5162C),
                            iconBackground:
                                const Color(0xFFFFD9DD),
                            title: 'Heart Rate',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=> const HeartRatePage(),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.air,
                            iconColor: const Color(0xFF183C76),
                            iconBackground:
                                const Color(0xFFDDE5FF),
                            title: 'Oxygen Level',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Spo2Page(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // ROW 2
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.thermostat,
                            iconColor: const Color(0xFFB51E29),
                            iconBackground:
                                const Color(0xFFFFD9DD),
                            title: 'Temperature',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TemperaturePage(),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.directions_walk,
                            iconColor: const Color(0xFF008B62),
                            iconBackground:
                                const Color(0xFF62EBC0),
                            title: 'Steps &\nActivity',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute (
                                  builder: (context) => const StepsActivityPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // ROW 3
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.nightlight_round,
                            iconColor: const Color(0xFF26266F),
                            iconBackground:
                                const Color(0xFFE1E0FF),
                            title: 'Sleep Tracking',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SleepTrackingPage(),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: _healthCard(
                            context,
                            icon: Icons.water_drop,
                            iconColor: const Color(0xFF163C78),
                            iconBackground:
                                const Color(0xFFDCE5FF),
                            title: 'Hydration',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HydrationPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // WEIGHT
                    // =================================================

                    SizedBox(
                      width: 163,
                      child: _healthCard(
                        context,
                        icon: Icons.monitor_weight_outlined,
                        iconColor: const Color(0xFF22252B),
                        iconBackground:
                            const Color(0xFFE6E7E9),
                        title: 'Weight\nTracking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeightTrackingPage(),

                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // TERA INSIGHTS
                    // =================================================

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeraInsightsPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 130,
                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFD9DAE0),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: 50,
                              height: 50,
                              decoration:
                                  const BoxDecoration(
                                color: primaryBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),

                            const Spacer(),

                            const Text(
                              'TERA Insights',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.w600,
                                color: darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =========================================================
            // BOTTOM NAVIGATION
            // =========================================================

            _bottomNavigation(context),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // HEALTH CARD
  // ===============================================================

  Widget _healthCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 150,
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: const Color(0xFFD5D6DC),
          ),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ICON

            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),

            const Spacer(),

            // TITLE

            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.25,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // BOTTOM NAVIGATION
  // ===============================================================

  Widget _bottomNavigation(BuildContext context) {
    return Container(
      height: 78,

      decoration: const BoxDecoration(
        color: Colors.white,

        border: Border(
          top: BorderSide(
            color: Color(0xFFE6E7EB),
          ),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
          children: [

          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AiPage(),
                ),
              );
            },
              child: _BottomItem(
                Icons.smart_toy_outlined,
                'Ai',
              ),
            ),

          _navItem(
            context,
            Icons.favorite_border,
            'Health',
            true,
          ),

          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                  builder: (context) => Home(),

                 ),
              );
            },
            child:  _BottomItem(
              Icons.home,
              'home',
            ),
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

          _navItem(
            context,
            Icons.person_outline,
            'Profile',
            false,
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // NAV ITEM
  // ===============================================================

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String label,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigation will be connected next.
      },

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            icon,
            size: 24,
            color: selected
                ? primaryBlue
                : const Color(0xFF666A73),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: selected
                  ? primaryBlue
                  : const Color(0xFF666A73),
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