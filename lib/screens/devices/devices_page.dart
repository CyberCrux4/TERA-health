import 'package:flutter/material.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  static const Color primaryBlue = Color(0xFF5756E9);
  static const Color darkText = Color(0xFF202124);
  static const Color lightBg = Color(0xFFF7F8FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,

      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // TOP BAR
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'AAGIS Device',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                        Text(
                          'Your connected safety watch',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.settings_outlined,
                    color: primaryBlue,
                  ),
                ],
              ),
            ),

            // =========================
            // CONTENT
            // =========================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // WATCH CARD
                    _watchCard(),

                    const SizedBox(height: 18),

                    // HEART RATE CARD
                    _heartRateCard(context),

                    const SizedBox(height: 18),

                    // DEVICE STATUS
                    _deviceStatusCard(),

                    const SizedBox(height: 18),

                    // EMERGENCY CONTACTS
                    _emergencyContactsCard(),

                    const SizedBox(height: 18),

                    // LOCATION
                    _locationCard(),

                    const SizedBox(height: 18),

                    // DEVICE SETTINGS
                    _settingsCard(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // =========================
            // BOTTOM NAVIGATION
            // =========================
            _bottomNavigation(context),
          ],
        ),
      ),
    );
  }

 // ============================================================
// WATCH CARD
// ============================================================

Widget _watchCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: _cardDecoration(),
    child: Column(
      children: [
        // Watch Image
       Container(
  width: 170,
  height: 170,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    color: Color(0xFFEAF4FF),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/tera_watch.png',
              width: 140,
              height: 140,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'AAGIS Watch',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),

        const SizedBox(height: 4),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              'Connected to TERA Health',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.battery_full,
                size: 15,
                color: Colors.green,
              ),
              SizedBox(width: 5),
              Text(
                '82% Battery',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          height: 42,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Text(
              'Manage Device',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  // ============================================================
// HEART RATE
// ============================================================

Widget _heartRateCard(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: _cardDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              '❤️',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(width: 3),
            Text(
              'Heart Rate Monitoring',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '78',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 4),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                'BPM',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

        const Row(
          children: [
            Icon(
              Icons.circle,
              size: 7,
              color: Colors.green,
            ),
            SizedBox(width: 4),
            Text(
              'Monitoring',
              style: TextStyle(
                fontSize: 10,
                color: Colors.green,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 55,
          width: double.infinity,
          child: CustomPaint(
            painter: _HeartRatePainter(),
          ),
        ),

        const Divider(),

        Row(
          children: [
            const Text(
              'Last updated: Just now',
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {},
              child: const Text(
                'View Heart Rate →',
                style: TextStyle(
                  fontSize: 9,
                  color: primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
  // ============================================================
  // DEVICE STATUS
  // ============================================================

  Widget _deviceStatusCard() {
    return _sectionCard(
      title: 'Device Status',
      child: Column(
        children: [
          _statusRow(
            Icons.bluetooth,
            'Connection',
            'Connected',
            Colors.green,
          ),

          _statusRow(
            Icons.battery_full,
            'Battery',
            '82%',
            Colors.green,
          ),

          _statusRow(
            Icons.favorite,
            'Heart Rate Sensor',
            'Active',
            Colors.red,
          ),

          _statusRow(
            Icons.location_on,
            'Location',
            'Available',
            Colors.blue,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMERGENCY CONTACTS
  // ============================================================

  Widget _emergencyContactsCard() {
    return _sectionCard(
      title: 'Emergency Contacts',
      child: Column(
        children: [
          _contactTile(
            'JD',
            'John Doe',
            'Spouse',
            const Color(0xFF5D6DEB),
          ),

          const SizedBox(height: 7),

          _contactTile(
            'JS',
            'Jane Smith',
            'Sister',
            const Color(0xFF4E8BEF),
          ),

          const SizedBox(height: 7),

          _contactTile(
            'DM',
            'Dr. Miller',
            'Doctor',
            const Color(0xFF16875F),
          ),

          const SizedBox(height: 10),

          _smallButton(
            'Manage Contacts →',
            () {},
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION
  // ============================================================

  Widget _locationCard() {
    return _sectionCard(
      title: 'Emergency Location',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 17,
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location sharing: Enabled',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your location will be shared with emergency contacts when SOS is activated.',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE4E9F2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 35,
              ),
            ),
          ),

          const SizedBox(height: 10),

          _smallButton(
            'Location Settings →',
            () {},
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SETTINGS
  // ============================================================

  Widget _settingsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 5,
            bottom: 8,
          ),
          child: Text(
            'DEVICE SETTINGS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),

        Container(
          decoration: _cardDecoration(),
          child: Column(
            children: [
              _settingRow(
                Icons.notifications_none,
                'Notifications',
              ),

              _settingRow(
                Icons.location_on_outlined,
                'Location Services',
              ),

              _settingRow(
                Icons.tune,
                'Health Monitoring',
              ),

              _settingRow(
                Icons.battery_saver,
                'Battery Optimization',
              ),

              _settingRow(
                Icons.sync,
                'Sync Device',
              ),

              _settingRow(
                Icons.help_outline,
                'Help & Support',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFD9DAE0),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }

  Widget _statusRow(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 13,
              color: color,
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactTile(
    String initials,
    String name,
    String relation,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFE1E2E5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                relation,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallButton(
    String text,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF4F5F7),
          elevation: 0,
          foregroundColor: darkText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _settingRow(
    IconData icon,
    String title,
  ) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9EC),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 15,
              color: Colors.black54,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),

          const Icon(
            Icons.chevron_right,
            size: 17,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAV
  // ============================================================

  Widget _bottomNavigation(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            Icons.smart_toy_outlined,
            'AI',
            false,
            () {},
          ),

          _bottomItem(
            Icons.favorite_border,
            'Health',
            false,
            () {},
          ),

          _bottomItem(
            Icons.home_outlined,
            'Home',
            false,
            () {},
          ),

          _bottomItem(
            Icons.watch_outlined,
            'Devices',
            true,
            () {},
          ),

          _bottomItem(
            Icons.person_outline,
            'Profile',
            false,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _bottomItem(
    IconData icon,
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 19,
            color: selected
                ? primaryBlue
                : Colors.grey,
          ),

          const SizedBox(height: 3),

          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: selected
                  ? primaryBlue
                  : Colors.grey,
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HEART RATE GRAPH
// ============================================================

class _HeartRatePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFFD43A48)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * 0.65);

    path.lineTo(
      size.width * 0.15,
      size.height * 0.65,
    );

    path.lineTo(
      size.width * 0.23,
      size.height * 0.25,
    );

    path.lineTo(
      size.width * 0.29,
      size.height * 0.82,
    );

    path.lineTo(
      size.width * 0.37,
      size.height * 0.65,
    );

    path.lineTo(
      size.width * 0.52,
      size.height * 0.65,
    );

    path.lineTo(
      size.width * 0.59,
      size.height * 0.25,
    );

    path.lineTo(
      size.width * 0.65,
      size.height * 0.82,
    );

    path.lineTo(
      size.width * 0.73,
      size.height * 0.65,
    );

    path.lineTo(
      size.width * 0.88,
      size.height * 0.65,
    );

    path.lineTo(
      size.width * 0.94,
      size.height * 0.28,
    );

    path.lineTo(
      size.width,
      size.height * 0.70,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}