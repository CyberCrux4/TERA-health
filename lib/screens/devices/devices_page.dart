import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF5554D9);
const Color darkText = Color(0xFF202124);
const Color lightBackground = Color(0xFFF7F8FC);

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          children: [
            Text(
              'AAGIS Device',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: primaryBlue,
              ),
            ),
            Text(
              'Your connected safety watch',
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: primaryBlue,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 25),
          child: Column(
            children: [
              // --------------------------------------------------
              // AAGIS WATCH CARD
              // --------------------------------------------------
              _watchCard(),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // HEART RATE MONITORING
              // --------------------------------------------------
              _heartRateCard(),

              const SizedBox(height: 16),

              // --------------------------------------------------
              // DEVICE STATUS
              // --------------------------------------------------
              _deviceStatusCard(),

              const SizedBox(height: 16),

              // --------------------------------------------------
              // EMERGENCY CONTACTS
              // --------------------------------------------------
              _emergencyContactsCard(),

              const SizedBox(height: 16),

              // --------------------------------------------------
              // EMERGENCY LOCATION
              // --------------------------------------------------
              _emergencyLocationCard(),

              const SizedBox(height: 22),

              // --------------------------------------------------
              // DEVICE SETTINGS
              // --------------------------------------------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DEVICE SETTINGS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _settingsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // WATCH CARD
  // ==============================================================

  Widget _watchCard() {
    return _card(
      child: Column(
        children: [
          Container(
            width: 105,
            height: 105,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.watch,
              size: 65,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'AAGIS Watch',
            style: TextStyle(
              fontSize: 16,
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
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.battery_5_bar,
                  size: 14,
                  color: Colors.green,
                ),
                SizedBox(width: 4),
                Text(
                  '82% Battery',
                  style: TextStyle(
                    fontSize: 10,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Manage Device',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // HEART RATE CARD
  // ==============================================================

  Widget _heartRateCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 16,
              ),
              Text(
                ' Heart Rate Monitoring',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: darkText,
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
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
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

          const SizedBox(height: 2),

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
                  fontSize: 9,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          SizedBox(
            height: 45,
            width: double.infinity,
            child: CustomPaint(
              painter: _HeartLinePainter(),
            ),
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Last updated: Just now',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                ),
              ),
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

  // ==============================================================
  // DEVICE STATUS
  // ==============================================================

  Widget _deviceStatusCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Device Status',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 12),

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

  Widget _statusRow(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F3F6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 13,
              color: color,
            ),
          ),

          const SizedBox(width: 9),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // EMERGENCY CONTACTS
  // ==============================================================

  Widget _emergencyContactsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Contacts',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 10),

          _contactTile(
            'JD',
            'John Doe',
            'Spouse',
            const Color(0xFF5D62D8),
          ),

          _contactTile(
            'JS',
            'Jane Smith',
            'Sister',
            const Color(0xFF5590E8),
          ),

          _contactTile(
            'DM',
            'Dr. Miller',
            'Doctor',
            const Color(0xFF11805F),
          ),

          const SizedBox(height: 8),

          _greyButton(
            'Manage Contacts →',
            () {},
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
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        border: Border.all(
          color: const Color(0xFFE0E1E5),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: color,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 9,
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

  // ==============================================================
  // EMERGENCY LOCATION
  // ==============================================================

  Widget _emergencyLocationCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Location',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1F4),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.blue,
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location sharing: Enabled',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your location will be shared with emergency contacts when SOS is activated.',
                        style: TextStyle(
                          fontSize: 7,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE1E8F2),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Center(
              child: Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),

          const SizedBox(height: 8),

          _greyButton(
            'Location Settings →',
            () {},
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // SETTINGS
  // ==============================================================

  Widget _settingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD9DAE0),
        ),
      ),
      child: Column(
        children: [
          _settingItem(
            Icons.notifications_none,
            'Notifications',
          ),
          _settingItem(
            Icons.location_on_outlined,
            'Location Services',
          ),
          _settingItem(
            Icons.tune,
            'Health Monitoring',
          ),
          _settingItem(
            Icons.battery_saver_outlined,
            'Battery Optimization',
          ),
          _settingItem(
            Icons.sync,
            'Sync Device',
          ),
          _settingItem(
            Icons.help_outline,
            'Help & Support',
            last: true,
          ),
        ],
      ),
    );
  }

  Widget _settingItem(
    IconData icon,
    String title, {
    bool last = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(
                bottom: BorderSide(
                  color: Color(0xFFE8E8EB),
                ),
              ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F5),
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
                fontSize: 10,
                color: darkText,
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

  // ==============================================================
  // COMMON CARD
  // ==============================================================

  Widget _card({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD9DAE0),
        ),
      ),
      child: child,
    );
  }

  Widget _greyButton(
    String text,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF3F4F6),
          foregroundColor: darkText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ================================================================
// HEART RATE LINE
// ================================================================

class _HeartLinePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * 0.55);
    path.lineTo(size.width * 0.15, size.height * 0.55);
    path.lineTo(size.width * 0.22, size.height * 0.10);
    path.lineTo(size.width * 0.28, size.height * 0.85);
    path.lineTo(size.width * 0.35, size.height * 0.55);
    path.lineTo(size.width * 0.48, size.height * 0.55);
    path.lineTo(size.width * 0.55, size.height * 0.15);
    path.lineTo(size.width * 0.61, size.height * 0.85);
    path.lineTo(size.width * 0.68, size.height * 0.55);
    path.lineTo(size.width * 0.82, size.height * 0.55);
    path.lineTo(size.width * 0.88, size.height * 0.15);
    path.lineTo(size.width * 0.94, size.height * 0.85);
    path.lineTo(size.width, size.height * 0.55);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}