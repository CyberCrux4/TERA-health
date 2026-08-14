import 'package:flutter/material.dart';

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  static const Color primary = Color(0xFF4B4BD9);
  static const Color bgColor = Color(0xFFF8F9FC);

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: bgColor,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE8E8EC),
                  ),
                ),
              ),

              child: Row(
                children: [
                  // BACK
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'Temperature',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // SHARE
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F1F5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 21,
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // SCROLL CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                padding: const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  110,
                ),

                child: Column(
                  children: [
                    // =================================================
                    // TEMPERATURE VALUE
                    // =================================================

                    const Icon(
                      Icons.thermostat,
                      color: primary,
                      size: 42,
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '36.7',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF171B26),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 7,
                          ),
                          child: Text(
                            '°C',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF555861),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // NORMAL STATUS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00966D),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 15,
                                color: Colors.black,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Normal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        const Text(
                          'Stable today',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF555861),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 55),

                    // =================================================
                    // DAILY TREND CARD
                    // =================================================

                    _trendCard(),

                    const SizedBox(height: 44),

                    // =================================================
                    // RECENT READINGS
                    // =================================================

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Readings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171B26),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    _readingCard(
                      temperature: '36.7°C',
                      time: '8:00 AM, Today',
                      active: true,
                    ),

                    _readingCard(
                      temperature: '36.5°C',
                      time: '9:00 PM, Yesterday',
                    ),

                    _readingCard(
                      temperature: '36.8°C',
                      time: '8:15 AM, Yesterday',
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // ABOUT TEMPERATURE
                    // =================================================

                    _aboutTemperature(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ===========================================================
      // BOTTOM NAVIGATION
      // ===========================================================

      
    );
  }

  // ===============================================================
  // TREND CARD
  // ===============================================================

  Widget _trendCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Daily Trend',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const Spacer(),

              Container(
                height: 38,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F2F5),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  children: [
                    _trendTab('Day', 0),
                    _trendTab('Week', 1),
                    _trendTab('Month', 2),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 190,
            width: double.infinity,
            child: CustomPaint(
              painter: TemperatureGraphPainter(),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // TREND TAB
  // ===============================================================

  Widget _trendTab(
    String title,
    int index,
  ) {
    final bool selected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : Colors.transparent,

          borderRadius: BorderRadius.circular(8),
        ),

        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w400,
            color: const Color(0xFF353840),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // READING CARD
  // ===============================================================

  Widget _readingCard({
    required String temperature,
    required String time,
    bool active = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: const Color(0xFFE6E6EA),
        ),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 7,
        ),

        leading: Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: active
                ? const Color(0xFFE3E2FF)
                : const Color(0xFFEDEDEF),
            shape: BoxShape.circle,
          ),

          child: Icon(
            Icons.thermostat,
            color: active
                ? primary
                : const Color(0xFF555861),
            size: 21,
          ),
        ),

        title: Text(
          temperature,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          time,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF555861),
          ),
        ),

        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF777A82),
        ),
      ),
    );
  }

  // ===============================================================
  // ABOUT TEMPERATURE
  // ===============================================================

  Widget _aboutTemperature() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE8E8EC),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: primary,
                size: 21,
              ),

              const SizedBox(width: 10),

              const Text(
                'About Body Temperature',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            'Normal human body temperature varies '
            'slightly from person to person and by the '
            'time of day. Consequently, each type of '
            'measurement has a range of normal '
            'temperatures. The range for oral '
            'temperature measurements is 35.5°C to '
            '37.5°C.',

            style: TextStyle(
              fontSize: 15,
              height: 1.55,
              color: Color(0xFF555861),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Read more',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // BOTTOM NAVIGATION
  // ===============================================================



  Widget _navItem(
    IconData icon,
    String label, {
    bool selected = false,
  }) {
    final color = selected
        ? primary
        : const Color(0xFF777A82);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(
          icon,
          color: color,
          size: 23,
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
    );
  }
}

// ===============================================================
// TEMPERATURE GRAPH
// ===============================================================

class TemperatureGraphPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFFE9E9ED)
      ..strokeWidth = 1;

    // GRID LINES
    for (int i = 0; i < 4; i++) {
      final y = 25.0 + (i * 38);

      canvas.drawLine(
        Offset(28, y),
        Offset(size.width - 8, y),
        paint,
      );
    }

    // GRAPH LINE
    final graphPaint = Paint()
      ..color = const Color(0xFF4B4BD9)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    final points = [
      Offset(45, 125),
      Offset(95, 116),
      Offset(145, 88),
      Offset(195, 99),
      Offset(245, 70),
      Offset(295, 80),
    ];

    path.moveTo(
      points[0].dx,
      points[0].dy,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    canvas.drawPath(
      path,
      graphPaint,
    );

    // POINTS
    final pointPaint = Paint()
      ..color = const Color(0xFF4B4BD9)
      ..style = PaintingStyle.fill;

    for (int i = 1; i < points.length; i++) {
      canvas.drawCircle(
        points[i],
        5,
        pointPaint,
      );

      final whitePaint = Paint()
        ..color = Colors.white;

      canvas.drawCircle(
        points[i],
        2,
        whitePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}