import 'package:flutter/material.dart';

class Spo2Page extends StatefulWidget {
  const Spo2Page({super.key});

  @override
  State<Spo2Page> createState() => _Spo2PageState();
}
class _Spo2PageState extends State<Spo2Page>{
  static const Color primary = Color(0xFF4B4BD9);
  static const Color bgColor = Color(0xFFF8F9FC);

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
              height: 64,
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 21,
                      color: Color(0xFF292C35),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    'SpO₂',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF171A22),
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.ios_share_rounded,
                    size: 22,
                    color: Color(0xFF292C35),
                  ),
                ],
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                padding: const EdgeInsets.fromLTRB(
                  24,
                  42,
                  24,
                  40,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // BLOOD OXYGEN
                    // =================================================

                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.air,
                                size: 27,
                                color: primary,
                              ),

                              const SizedBox(width: 8),

                              Text(
                                'BLOOD OXYGEN',
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            children: [
                              Text(
                                '98',
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w700,
                                  color: primary,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 7,
                                  left: 3,
                                ),
                                child: Text(
                                  '%',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // NORMAL BADGE
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFFDDF7EE),
                              borderRadius:
                                  BorderRadius.circular(25),
                              border: Border.all(
                                color: const Color(0xFFB9EBD8),
                              ),
                            ),

                            child: const Text(
                              'Normal',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF176B50),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          const Text(
                            "Today's range: 96–99%",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xFF4F535C),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =================================================
                    // GRAPH CARD
                    // =================================================

                    Container(
                      height: 312,
                      width: double.infinity,

                      padding: const EdgeInsets.fromLTRB(
                        24,
                        26,
                        24,
                        20,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),

                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          // TABS
                          Container(
                            height: 44,

                            padding:
                                const EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F1F5),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),

                            child: Row(
                              children: [
                                _tab(
                                  'Day',
                                  true,
                                ),

                                _tab(
                                  'Week',
                                  false,
                                ),

                                _tab(
                                  'Month',
                                  false,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // GRAPH
                          Expanded(
                            child: CustomPaint(
                              painter: _Spo2GraphPainter(),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // =================================================
                    // RECENT READINGS
                    // =================================================

                    const Text(
                      'Recent Readings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF171A22),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _readingCard(
                      value: '98%',
                      time: '2:30 PM, Today',
                    ),

                    const SizedBox(height: 16),

                    _readingCard(
                      value: '97%',
                      time: '10:15 AM, Today',
                    ),

                    const SizedBox(height: 16),

                    _readingCard(
                      value: '99%',
                      time: '8:00 AM, Yesterday',
                      faded: true,
                    ),

                    const SizedBox(height: 40),

                    // =================================================
                    // ABOUT SPO2
                    // =================================================

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F5F8),
                        borderRadius:
                            BorderRadius.circular(22),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                size: 22,
                                color: primary,
                              ),

                              const SizedBox(width: 10),

                              const Text(
                                'About SpO₂',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: primary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Text(
                            'Blood oxygen level (SpO₂) '
                            'represents the percentage of '
                            'oxygen your blood is carrying '
                            'compared to its maximum '
                            'capacity. A normal healthy range '
                            'is typically between 95% and '
                            '100%. Consistent readings below '
                            '90% may require medical '
                            'attention.',

                            style: TextStyle(
                              fontSize: 16,
                              height: 1.55,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // TAB
  // ===============================================================

  Widget _tab(
    String title,
    bool selected,
  ) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: selected
              ? Colors.white
              : Colors.transparent,

          borderRadius: BorderRadius.circular(9),

          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 5,
                  ),
                ]
              : null,
        ),

        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w400,
            color: const Color(0xFF41444D),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // READING CARD
  // ===============================================================

  Widget _readingCard({
    required String value,
    required String time,
    bool faded = false,
  }) {
    return Container(
      height: 84,

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE1E2E7),
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: faded
                        ? const Color(0xFF777A82)
                        : const Color(0xFF171A22),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: faded
                        ? const Color(0xFF777A82)
                        : const Color(0xFF555962),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 42,
            height: 42,

            decoration: const BoxDecoration(
              color: Color(0xFFF2F3F6),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.history_rounded,
              size: 21,
              color: Color(0xFF737780),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// SPO2 GRAPH
// ===================================================================

class _Spo2GraphPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF4B4BD9)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    final points = [
      Offset(0, size.height * 0.82),
      Offset(size.width * 0.20, size.height * 0.35),
      Offset(size.width * 0.40, size.height * 0.58),
      Offset(size.width * 0.60, size.height * 0.18),
      Offset(size.width * 0.78, size.height * 0.32),
      Offset(size.width * 0.95, size.height * 0.08),
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

    canvas.drawPath(path, paint);

    // ---------------------------------------------------------------
    // GRID LINES
    // ---------------------------------------------------------------

    final gridPaint = Paint()
      ..color = const Color(0xFFE6E7EA)
      ..strokeWidth = 1;

    for (double y = 0; y <= size.height; y += size.height / 3) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // ---------------------------------------------------------------
    // POINTS
    // ---------------------------------------------------------------

    final pointPaint = Paint()
      ..color = const Color(0xFF4B4BD9)
      ..style = PaintingStyle.fill;

    for (int i = 1; i < points.length; i++) {
      canvas.drawCircle(
        points[i],
        4.5,
        pointPaint,
      );

      final innerPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        points[i],
        2,
        innerPaint,
      );
    }

    // ---------------------------------------------------------------
    // AXIS LABELS
    // ---------------------------------------------------------------

    _drawText(
      canvas,
      '100%',
      const Offset(0, -5),
    );

    _drawText(
      canvas,
      '95%',
      Offset(0, size.height * 0.45),
    );

    _drawText(
      canvas,
      '90%',
      Offset(0, size.height * 0.80),
    );

    _drawText(
      canvas,
      '12 AM',
      Offset(15, size.height + 12),
    );

    _drawText(
      canvas,
      '6 AM',
      Offset(size.width * 0.30, size.height + 12),
    );

    _drawText(
      canvas,
      '12 PM',
      Offset(size.width * 0.58, size.height + 12),
    );

    _drawText(
      canvas,
      '6 PM',
      Offset(size.width * 0.88, size.height + 12),
    );

    // Current value
    _drawText(
      canvas,
      '98',
      Offset(
        size.width * 0.96,
        size.height * 0.03,
      ),
      bold: true,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position, {
    bool bold = false,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 12,
          fontWeight:
              bold ? FontWeight.w600 : FontWeight.w400,
          color: const Color(0xFF62656D),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      position,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}