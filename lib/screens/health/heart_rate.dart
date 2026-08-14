import 'package:flutter/material.dart';

class HeartRatePage extends StatelessWidget {
  const HeartRatePage({super.key});

  static const Color primary = Color(0xFF4B4BD8);
  static const Color bg = Color(0xFFF7F8FC);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737782);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: primary,
                      size: 25,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'Heart Rate',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.ios_share_outlined,
                    color: primary,
                    size: 23,
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
                  20,
                  12,
                  20,
                  100,
                ),
                child: Column(
                  children: [
                    // =================================================
                    // HEART ICON
                    // =================================================

                    Container(
                      width: 104,
                      height: 104,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE3E2FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: primary,
                        size: 48,
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =================================================
                    // CURRENT BPM
                    // =================================================

                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: [
                        Text(
                          '78',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),
                        SizedBox(width: 5),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Text(
                            'BPM',
                            style: TextStyle(
                              fontSize: 17,
                              color: greyText,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // NORMAL
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F5E9),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 13,
                            color: Color(0xFF16845F),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Normal',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF16845F),
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =================================================
                    // DAY / WEEK / MONTH
                    // =================================================

                    Container(
                      width: 220,
                      height: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F3),
                        borderRadius:
                            BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE1E1E6),
                        ),
                      ),
                      child: Row(
                        children: [
                          _periodButton(
                            'Day',
                            selected: true,
                          ),
                          _periodButton('Week'),
                          _periodButton('Month'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 34),

                    // =================================================
                    // CHART
                    // =================================================

                    _chartCard(),

                    const SizedBox(height: 28),

                    // =================================================
                    // MIN MAX
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            '↓  MIN',
                            '62',
                            'BPM',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statCard(
                            '↑  MAX',
                            '91',
                            'BPM',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // AVG REST
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            '▣  AVG',
                            '74',
                            'BPM',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statCard(
                            '☾  REST',
                            '65',
                            'BPM',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // =================================================
                    // HISTORICAL DATA
                    // =================================================

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Historical Data',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    _historyCard(),

                    const SizedBox(height: 20),

                    const Text(
                      'View All Data',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =================================================
                    // ABOUT HEART RATE
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3FF),
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFDDE2F8),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: primary,
                            size: 23,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Heart Rate',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: darkText,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'A normal resting heart rate for adults ranges from 60 to 100 beats per minute (BPM). Generally, a lower heart rate at rest can indicate more efficient heart function and better cardiovascular fitness.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: Color(0xFF5D6069),
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

            
            
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // PERIOD BUTTON
  // ===============================================================

  Widget _periodButton(
    String text, {
    bool selected = false,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? primary
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight:
                selected
                    ? FontWeight.w600
                    : FontWeight.w500,
            color: selected
                ? Colors.white
                : const Color(0xFF4D5059),
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // CHART
  // ===============================================================

  Widget _chartCard() {
    return Container(
      width: double.infinity,
      height: 248,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD8D9DF),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: _HeartRatePainter(),
              child: Stack(
                children: [
                  Positioned(
                    right: 24,
                    top: 20,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25272C),
                        borderRadius:
                            BorderRadius.circular(6),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '91',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          Text(
                            'BPM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '2:30 PM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
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

          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12 AM',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
              Text(
                '6 AM',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
              Text(
                '12 PM',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
              Text(
                '6 PM',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
              Text(
                '11 PM',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // STAT CARD
  // ===============================================================

  Widget _statCard(
    String title,
    String value,
    String unit,
  ) {
    return Container(
      height: 86,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFD9DAE0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: greyText,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 12,
                  color: greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // HISTORY
  // ===============================================================

  Widget _historyCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD9DAE0),
        ),
      ),
      child: Column(
        children: [
          _historyRow(
            Icons.monitor_heart_outlined,
            '78 BPM',
            '2:30 PM, Today',
            'Normal',
            const Color(0xFFE0F5E8),
            const Color(0xFF26845C),
          ),
          const Divider(height: 1),
          _historyRow(
            Icons.monitor_heart_outlined,
            '91 BPM',
            '8:15 AM, Today (Post-Walk)',
            'Elevated',
            const Color(0xFFFFF0D9),
            const Color(0xFFC78A25),
          ),
          const Divider(height: 1),
          _historyRow(
            Icons.nightlight_round,
            '62 BPM',
            '6:00 AM, Today (Resting)',
            'Normal',
            const Color(0xFFE0F5E8),
            const Color(0xFF26845C),
          ),
        ],
      ),
    );
  }

  Widget _historyRow(
    IconData icon,
    String value,
    String time,
    String status,
    Color statusBg,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFE4E4FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 


// ===============================================================
// CHART PAINTER
// ===============================================================

class _HeartRatePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final chartWidth = size.width;
    final chartHeight = size.height;

    final fillPath = Path();

    final points = [
      Offset(0, chartHeight * 0.70),
      Offset(
        chartWidth * 0.16,
        chartHeight * 0.66,
      ),
      Offset(
        chartWidth * 0.30,
        chartHeight * 0.48,
      ),
      Offset(
        chartWidth * 0.43,
        chartHeight * 0.62,
      ),
      Offset(
        chartWidth * 0.55,
        chartHeight * 0.72,
      ),
      Offset(
        chartWidth * 0.66,
        chartHeight * 0.38,
      ),
      Offset(
        chartWidth * 0.78,
        chartHeight * 0.66,
      ),
      Offset(
        chartWidth * 0.87,
        chartHeight * 0.27,
      ),
      Offset(
        chartWidth * 0.96,
        chartHeight * 0.48,
      ),
    ];

    fillPath.moveTo(
      points.first.dx,
      chartHeight,
    );

    for (final point in points) {
      fillPath.lineTo(
        point.dx,
        point.dy,
      );
    }

    fillPath.lineTo(
      points.last.dx,
      chartHeight,
    );

    fillPath.close();

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFF2F2F2),
          Color(0xFFE8E8E8),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          chartWidth,
          chartHeight,
        ),
      );

    canvas.drawPath(
      fillPath,
      fillPaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFFE8E8E8)
      ..strokeWidth = 1;

    for (int i = 1; i < 4; i++) {
      final y = chartHeight * i / 4;

      canvas.drawLine(
        Offset(0, y),
        Offset(chartWidth, y),
        linePaint,
      );
    }

    final pointPaint = Paint()
      ..color = const Color(0xFF4B4BD8)
      ..style = PaintingStyle.fill;

    final lastPoint = points[points.length - 2];

    canvas.drawCircle(
      lastPoint,
      4,
      pointPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ===============================================================
// BOTTOM ITEM
// ===============================================================

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
        ? const Color(0xFF4B4BD8)
        : const Color(0xFF737782);

    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
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