import 'package:flutter/material.dart';

import 'package:tera_health/screens/AI/ai.dart';
import 'package:tera_health/screens/devices/devices_page.dart';
import 'package:tera_health/screens/health/health_page.dart';
import 'package:tera_health/screens/home/home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color primary = Color(0xFF4B4BD9);
  static const Color darkText = Color(0xFF252525);
  static const Color greyText = Color(0xFF666666);
  static const Color pageBackground = Color(0xFFF8F9FD);
  static const Color lightBlue = Color(0xFFE5EAFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =====================================================
              // PROFILE CARD
              // =====================================================

              _profileCard(),

              const SizedBox(height: 22),

              // =====================================================
              // AAGIS WATCH
              // =====================================================

              _watchCard(),

              const SizedBox(height: 24),

              // =====================================================
              // PERSONAL DETAILS
              // =====================================================

              sectionTitle('Personal Details'),

              settingsCard(
                context,
                [
                  ['Personal Information', Icons.person_outline],
                  ['Height & Weight', Icons.straighten],
                  ['Contact Information', Icons.contact_mail_outlined],
                  ['Emergency Contacts', Icons.emergency_outlined],
                ],
              ),

              const SizedBox(height: 20),

              // =====================================================
              // HEALTH SETTINGS
              // =====================================================

              sectionTitle('Health Settings'),

              settingsCard(
                context,
                [
                  ['Health Monitoring', Icons.monitor_heart_outlined],
                  ['Health Reminders', Icons.alarm_outlined],
                  ['Water Reminder', Icons.water_drop_outlined],
                  ['Sleep Reminder', Icons.nightlight_outlined],
                  ['Activity Goals', Icons.directions_run],
                ],
              ),

              const SizedBox(height: 20),

              // =====================================================
              // PRIVACY & SECURITY
              // =====================================================

              sectionTitle('Privacy & Security'),

              settingsCard(
                context,
                [
                  ['Privacy Settings', Icons.security_outlined],
                  ['Data & Security', Icons.shield_outlined],
                  ['Location Permission', Icons.location_on_outlined],
                  ['Camera Permission', Icons.camera_alt_outlined],
                  ['Microphone Permission', Icons.mic_none_outlined],
                ],
              ),

              const SizedBox(height: 20),

              // =====================================================
              // TERA AI
              // =====================================================

              sectionTitle('TERA AI'),

              settingsCard(
                context,
                [
                  ['AI Preferences', Icons.psychology_outlined],
                  ['Chat History', Icons.history],
                  ['Personalization', Icons.tune],
                  ['Clear AI History', Icons.delete_outline],
                ],
              ),

              const SizedBox(height: 20),

              // =====================================================
              // APP SETTINGS
              // =====================================================

              sectionTitle('App Settings'),

              settingsCard(
                context,
                [
                  ['Notifications', Icons.notifications_none],
                  ['Language', Icons.language],
                  ['Appearance', Icons.palette_outlined],
                  ['Help & Support', Icons.help_outline],
                  ['About TERA Health', Icons.info_outline],
                ],
              ),

              const SizedBox(height: 28),

              // =====================================================
              // LOGOUT
              // =====================================================

              _logoutButton(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ===========================================================
      // BOTTOM NAVIGATION
      // ===========================================================

      bottomNavigationBar: _bottomNavigation(context),
    );
  }

  // ===============================================================
  // PROFILE CARD
  // ===============================================================

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: primary.withValues(alpha: 0.15),
        ),

        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [
          // Profile image
          Container(
            width: 78,
            height: 78,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8E9EF),

              border: Border.all(
                color: primary.withValues(alpha: 0.12),
                width: 2,
              ),
            ),

            child: const Icon(
              Icons.person_outline,
              size: 47,
              color: primary,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Username',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 3),

          const Text(
            'user@example.com',
            style: TextStyle(
              fontSize: 12,
              color: greyText,
            ),
          ),

          const SizedBox(height: 7),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),

            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Text(
              'TERA Health User',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
            ),
          ),

          const SizedBox(height: 17),

          SizedBox(
            width: double.infinity,
            height: 42,

            child: OutlinedButton(
              onPressed: () {
                // TODO: Edit profile
              },

              style: OutlinedButton.styleFrom(
                backgroundColor: lightBlue,
                foregroundColor: primary,

                side: const BorderSide(
                  color: primary,
                  width: 1,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),

              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // AAGIS WATCH CARD
  // ===============================================================

  Widget _watchCard() {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: primary.withValues(alpha: 0.13),
        ),

        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.watch_outlined,
                color: primary,
                size: 20,
              ),

              SizedBox(width: 7),

              Text(
                'AAGIS Watch',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF25255E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFDDF8E5),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: Colors.green,
                    ),

                    SizedBox(width: 5),

                    Text(
                      'Connected',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              const Icon(
                Icons.battery_5_bar,
                size: 16,
                color: Colors.grey,
              ),

              const SizedBox(width: 4),

              const Text(
                '82%',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            'Your safety watch is ready',
            style: TextStyle(
              fontSize: 13,
              color: greyText,
            ),
          ),

          const SizedBox(height: 13),

          SizedBox(
            width: double.infinity,
            height: 40,

            child: ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Manage AAGIS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: 7),

                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // SECTION TITLE
  // ===============================================================

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        bottom: 8,
      ),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF202020),
        ),
      ),
    );
  }

  // ===============================================================
  // SETTINGS CARD
  // ===============================================================

  Widget settingsCard(
    BuildContext context,
    List<List<dynamic>> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),

        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),

        child: Column(
          children: List.generate(
            items.length,
            (index) {
              final String title = items[index][0];
              final IconData icon = items[index][1];

              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$title selected'),
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },

                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 54,
                  ),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 7,
                  ),

                  decoration: BoxDecoration(
                    border: index == items.length - 1
                        ? null
                        : const Border(
                            bottom: BorderSide(
                              color: Color(0xFFEAEAEA),
                            ),
                          ),
                  ),

                  child: Row(
                    children: [
                      // ICON
                      Container(
                        width: 32,
                        height: 32,

                        decoration: const BoxDecoration(
                          color: Color(0xFFF0F1F7),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          icon,
                          size: 17,
                          color: primary,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // TITLE
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3F3F3F),
                          ),
                        ),
                      ),

                      // ARROW
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 20,
                        color: Color(0xFF858585),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // LOGOUT BUTTON
  // ===============================================================

  Widget _logoutButton(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,

      child: ElevatedButton(
        onPressed: () {
          _showLogoutDialog(context);
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFE2DE),
          foregroundColor: const Color(0xFFB42318),
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),

        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              size: 17,
            ),

            SizedBox(width: 7),

            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // LOGOUT DIALOG
  // ===============================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: const Text(
            'Log Out',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),

          content: const Text(
            'Are you sure you want to log out?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // TODO:
                // Add actual logout logic here.
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
              ),

              child: const Text(
                'Log Out',
              ),
            ),
          ],
        );
      },
    );
  }

  // ===============================================================
  // BOTTOM NAVIGATION
  // ===============================================================

  Widget _bottomNavigation(BuildContext context) {
    return Container(
      height: 68,

      decoration: const BoxDecoration(
        color: Colors.white,

        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA),
          ),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          _bottomItem(
            context,
            Icons.smart_toy_outlined,
            'AI',
            false,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AiPage(),
                ),
              );
            },
          ),

          _bottomItem(
            context,
            Icons.favorite_border,
            'Health',
            false,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HealthPage(),
                ),
              );
            },
          ),

          _bottomItem(
            context,
            Icons.home_outlined,
            'Home',
            false,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const Home(),
                ),
              );
            },
          ),

          _bottomItem(
            context,
            Icons.watch_outlined,
            'Devices',
            false,
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DevicesPage(),
                ),
              );
            },
          ),

          _bottomItem(
            context,
            Icons.person_outline,
            'Profile',
            true,
            () {},
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // BOTTOM NAV ITEM
  // ===============================================================

  Widget _bottomItem(
    BuildContext context,
    IconData icon,
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,

      behavior: HitTestBehavior.opaque,

      child: SizedBox(
        width: 62,
        height: 60,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              size: 23,

              color: selected
                  ? primary
                  : const Color(0xFF666A74),
            ),

            const SizedBox(height: 3),

            Text(
              label,

              style: TextStyle(
                fontSize: 10,

                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,

                color: selected
                    ? primary
                    : const Color(0xFF666A74),
              ),
            ),
          ],
        ),
      ),
    );
  }
}