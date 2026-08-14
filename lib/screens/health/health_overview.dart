import 'package:flutter/material.dart';
import '../home/home.dart';

class HealthOverview extends StatelessWidget {
  const HealthOverview({super.key});

  // ============================================================
  // COLORS
  // ============================================================

  static const Color bgColor = Color(0xFFF7F7FC);
  static const Color primaryBlue = Color(0xFF174A91);
  static const Color darkText = Color(0xFF292929);
  static const Color teal = Color(0xFF16B58A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 48,
                  bottom: 30,
                ),
                child: Column(
                  children: [
                    _personalDetailsCard(),

                    const SizedBox(height: 36),

                    _stepsCard(),

                    const SizedBox(height: 38),

                    _sleepCard(),

                    const SizedBox(height: 34),

                    _intakeCard(),

                    const SizedBox(height: 34),

                    _weightCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

 Widget _header(BuildContext context) {
  return Container(
    height: 64,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // LOGO
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/tera_logo.jpeg',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.health_and_safety_outlined,
                  color: teal,
                  size: 25,
                );
              },
            ),
          ),
        ),

        const SizedBox(width: 10),

        const Text(
          'TERA Health',
          style: TextStyle(
            color: primaryBlue,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        // HOME
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
              (route) => false,
            );
          },
          child: const Text(
            'Home',
            style: TextStyle(
              color: Color(0xFF4D4F57),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(width: 25),

        // NOTIFICATION
        const Icon(
          Icons.notifications_none_rounded,
          color: Color(0xFF30323A),
          size: 27,
        ),
      ],
    ),
  );
}

// ============================================================
// PERSONAL DETAILS CARD
// ============================================================

Widget _personalDetailsCard() {
  return _cardWithIcon(
    height: 158,
    icon: Icons.medical_information_outlined,
    iconBackground: const Color(0xFFECE9FF),
    iconColor: const Color(0xFF19B6C7),
    iconBorder: null,
    iconTop: 48,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        58,
        12,
        18,
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Details',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),

          const SizedBox(height: 5),

          Container(
            height: 1,
            color: const Color(0xFFE1E1E1),
          ),

          const SizedBox(height: 7),

          _personalRow(
            'Name',
            'Kavinesh',
          ),

          _personalRow(
            'Age',
            '20',
          ),

          _personalRow(
            'Gender',
            'Male',
          ),

          _personalRow(
            'Blood Group',
            'B+',
          ),
        ],
      ),
    ),
  );
}

Widget _personalRow(
  String title,
  String value,
) {
  return SizedBox(
    height: 24,
    child: Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF777B86),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const Text(
          ':',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFB0B0B0),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF292C34),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
  // ============================================================
  // STEPS CARD
  // ============================================================

  Widget _stepsCard() {
    return _cardWithIcon(
      height: 159,
      icon: Icons.directions_walk_rounded,
      iconBackground: Colors.white,
      iconColor: teal,
      iconBorder: teal,
      iconTop: 41,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24,
          10,
          18,
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Steps',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 16,
                          color: darkText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '12 August 2026 11:57',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 8,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  '3047',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 20,
                    color: teal,
                  ),
                ),

                const SizedBox(width: 5),

                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Steps',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 8,
                      color: Color(0xFF444444),
                    ),
                  ),
                ),
              ],
            ),

            const Divider(
              height: 8,
              thickness: 1,
              color: Color(0xFFAAAAAA),
            ),

            const SizedBox(height: 3),

            SizedBox(
              height: 54,
              child: _stepsGraph(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '00:00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 7,
                    color: teal,
                  ),
                ),
                Text(
                  '06:00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 7,
                    color: teal,
                  ),
                ),
                Text(
                  '12:00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 7,
                    color: teal,
                  ),
                ),
                Text(
                  '18:00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 7,
                    color: teal,
                  ),
                ),
                Text(
                  '00:00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 7,
                    color: teal,
                  ),
                ),
              ],
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: teal,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '2.52 km',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 12,
                        color: Color(0xFF444444),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      size: 20,
                      color: teal,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '24.3 min',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 12,
                        color: Color(0xFF444444),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STEPS GRAPH
  // ============================================================

  Widget _stepsGraph() {
    final bars = [
      0.10,
      0.13,
      0.11,
      0.15,
      0.17,
      0.14,
      0.23,
      0.31,
      0.43,
      0.60,
      0.82,
      0.50,
      0.18,
      0.14,
      0.12,
      0.13,
      0.15,
      0.13,
      0.16,
      0.12,
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: bars.map((value) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 1.5,
            ),
            child: FractionallySizedBox(
              heightFactor: value,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: teal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ============================================================
  // SLEEP CARD
  // ============================================================

  Widget _sleepCard() {
    return _cardWithIcon(
      height: 119,
      icon: Icons.bed_rounded,
      iconBackground: Colors.white,
      iconColor: const Color(0xFF222222),
      iconBorder: const Color(0xFF5946B8),
      iconTop: 35,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24,
          10,
          18,
          15,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sleep',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 16,
                          color: darkText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '12 August 2026 11:57',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 8,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  '04',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 20,
                    color: teal,
                  ),
                ),

                const Text(
                  'h',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 11,
                    color: teal,
                  ),
                ),

                const SizedBox(width: 2),

                const Text(
                  '00',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 20,
                    color: teal,
                  ),
                ),

                const Text(
                  'min',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 10,
                    color: teal,
                  ),
                ),
              ],
            ),

            const Divider(
              height: 8,
              thickness: 1,
              color: Color(0xFFAAAAAA),
            ),

            const SizedBox(height: 7),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                      height: 28,
                      color: const Color(0xFFFF3C43),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Container(
                      height: 28,
                      color: const Color(0xFFE9F01D),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(
                      height: 28,
                      color: const Color(0xFF16B88C),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: Container(
                      height: 28,
                      color: const Color(0xFF0FB6D2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INTAKE REMINDER
  // ============================================================

  Widget _intakeCard() {
    return _cardWithIcon(
      height: 76,
      icon: Icons.local_drink_rounded,
      iconBackground: const Color(0xFFF1EEE9),
      iconColor: const Color(0xFF1E9BB7),
      iconBorder: const Color(0xFF22A9C1),
      iconTop: 8,
      iconSize: 40,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          11,
          18,
          10,
        ),
        child: Row(
          children: [
            const SizedBox(width: 42),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Intake Remainder',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 16,
                      color: darkText,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'view drinking records',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 14,
                      color: Color(0xFF888B93),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              size: 25,
              color: Color(0xFFD2C7BD),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WEIGHT CARD
  // ============================================================

  Widget _weightCard() {
    return _cardWithIcon(
      height: 97,
      icon: Icons.monitor_weight_outlined,
      iconBackground: const Color(0xFFE4F2EF),
      iconColor: const Color(0xFF5A9E91),
      iconBorder: const Color(0xFF29A68C),
      iconTop: 17,
      iconSize: 39,
      iconWidth: 59,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          24,
          10,
          18,
          8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 16,
                          color: darkText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '12 August 2026 11:57',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 8,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  '50.0',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 20,
                    color: teal,
                  ),
                ),

                const SizedBox(width: 4),

                const Text(
                  'Kg',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 13,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            SizedBox(
              height: 35,
              child: Stack(
                children: [
                  Positioned(
                    left: 22,
                    right: 22,
                    bottom: 8,
                    child: Container(
                      height: 1,
                      color: const Color(0xFFB8C7C5),
                    ),
                  ),

                  const Positioned(
                    left: 145,
                    top: 4,
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: Color(0xFF9DCFC3),
                    ),
                  ),

                  const Positioned(
                    left: 140,
                    bottom: -3,
                    child: Text(
                      '50.0',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 7,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMMON CARD WITH LEFT ICON
  // ============================================================

  Widget _cardWithIcon({
    required double height,
    required Widget child,
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required Color? iconBorder,
    required double iconTop,
    double iconSize = 31,
    double iconWidth = 59,
  }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // MAIN CARD
          Positioned(
            left: 60,
            right: 14,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: const Color(0xFFE8E8ED),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 9,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: child,
            ),
          ),

          // LEFT ICON
          Positioned(
            left: 14,
            top: iconTop,
            child: Container(
              width: iconWidth,
              height: 59,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(10),
                border: iconBorder != null
                    ? Border.all(
                        color: iconBorder,
                        width: 1.2,
                      )
                    : null,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}