import 'package:flutter/material.dart';

class WeightTrackingPage extends StatelessWidget {
  const WeightTrackingPage({super.key});

  static const Color primary = Color(0xFF4B4BD8);
  static const Color background = Color(0xFFF7F8FA);
  static const Color darkText = Color(0xFF20222A);
  static const Color greyText = Color(0xFF6D7078);
  static const Color green = Color(0xFF14855F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // =================================================
                    // HEADER
                    // =================================================

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Color(0xFF444750),
                          ),
                        ),

                        const Expanded(
                          child: Center(
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.ios_share_outlined,
                          size: 24,
                          color: primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    // =================================================
                    // CURRENT WEIGHT
                    // =================================================

                    const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '68.4',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                          SizedBox(width: 7),
                          Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'kg',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF555861),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =================================================
                    // PREVIOUS WEIGHT
                    // =================================================

                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F1F4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Previous: 69.1 kg',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF555861),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_downward,
                              size: 16,
                              color: green,
                            ),
                            Text(
                              '0.7 kg',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Center(
                      child: Text(
                        'Latest measurement: Today, 8:30 AM',
                        style: TextStyle(
                          fontSize: 17,
                          color: greyText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =================================================
                    // GRAPH CARD
                    // =================================================

                    _weightGraph(),

                    const SizedBox(height: 40),

                    // =================================================
                    // HISTORY
                    // =================================================

                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 15),

                    _historyItem(
                      weight: '68.4 kg',
                      date: 'Today, 8:30 AM',
                      selected: true,
                    ),

                    const SizedBox(height: 12),

                    _historyItem(
                      weight: '69.1 kg',
                      date: 'Oct 22, 7:45 AM',
                    ),

                    const SizedBox(height: 12),

                    _historyItem(
                      weight: '68.8 kg',
                      date: 'Oct 15, 8:00 AM',
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

  // ================================================================
  // WEIGHT GRAPH
  // ================================================================

  Widget _weightGraph() {
    return Container(
      height: 405,
      padding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5E6EA),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [

          // =========================================================
          // PERIOD SELECTOR
          // =========================================================

          Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEF1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _periodItem('Week'),
                ),
                Expanded(
                  child: _periodItem(
                    'Month',
                    selected: true,
                  ),
                ),
                Expanded(
                  child: _periodItem('3 Months'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // =========================================================
          // GRAPH
          // =========================================================

          Expanded(
            child: CustomPaint(
              painter: _WeightGraphPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PERIOD BUTTON
  // ================================================================

  Widget _periodItem(
    String text, {
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: selected
              ? FontWeight.w600
              : FontWeight.w500,
          color: selected
              ? primary
              : const Color(0xFF454851),
        ),
      ),
    );
  }

  // ================================================================
  // HISTORY ITEM
  // ================================================================

  Widget _historyItem({
    required String weight,
    required String date,
    bool selected = false,
  }) {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E4E8),
        ),
      ),
      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F2F6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.monitor_weight_outlined,
              size: 21,
              color: selected
                  ? primary
                  : const Color(0xFF4F535C),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  weight,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.more_vert,
            size: 23,
            color: Color(0xFF73767E),
          ),
        ],
      ),
    );
  }


  Widget _navItem(
    IconData icon,
    String label, {
    bool selected = false,
  }) {
    final color = selected
        ? primary
        : const Color(0xFF6B6E76);

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

// ==================================================================
// WEIGHT GRAPH PAINTER
// ==================================================================

class _WeightGraphPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..strokeWidth = 1
      ..color = const Color(0xFFE8E9ED);

    // --------------------------------------------------------------
    // GRID LINES
    // --------------------------------------------------------------

    final gridY = [
      25.0,
      90.0,
      155.0,
      220.0,
      285.0,
    ];

    for (final y in gridY) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // --------------------------------------------------------------
    // WEIGHT CURVE
    // --------------------------------------------------------------

    final points = [
      Offset(5, 113),
      Offset(size.width * 0.25, 118),
      Offset(size.width * 0.52, 132),
      Offset(size.width * 0.72, 130),
      Offset(size.width - 5, 166),
    ];

    final linePaint = Paint()
      ..color = const Color(0xFF5C5BD8)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

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

    canvas.drawPath(path, linePaint);

    // --------------------------------------------------------------
    // AREA
    // --------------------------------------------------------------

    final areaPath = Path();

    areaPath.moveTo(
      points[0].dx,
      points[0].dy,
    );

    for (int i = 1; i < points.length; i++) {
      areaPath.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    areaPath.lineTo(
      points.last.dx,
      size.height - 30,
    );

    areaPath.lineTo(
      points.first.dx,
      size.height - 30,
    );

    areaPath.close();

    final areaPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x554B4BD8),
          Color(0x084B4BD8),
        ],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    canvas.drawPath(
      areaPath,
      areaPaint,
    );

    // --------------------------------------------------------------
    // DATA POINTS
    // --------------------------------------------------------------

    for (int i = 0; i < points.length; i++) {
      final pointPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        points[i],
        12,
        pointPaint,
      );

      final borderPaint = Paint()
        ..color = const Color(0xFF4B4BD8)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
        points[i],
        11,
        borderPaint,
      );
    }

    // --------------------------------------------------------------
    // Y AXIS LABELS
    // --------------------------------------------------------------

    const labels = [
      '70',
      '69',
      '68',
      '67',
    ];

    final textStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF666A72),
    );

    for (int i = 0; i < labels.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          -8,
          12 + (i * 65),
        ),
      );
    }

    // --------------------------------------------------------------
    // X AXIS LABELS
    // --------------------------------------------------------------

    const xLabels = [
      'Oct 1',
      'Oct 8',
      'Oct 15',
      'Oct 22',
      'Today',
    ];

    for (int i = 0; i < xLabels.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: xLabels[i],
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      final x = i *
          ((size.width - 40) / 4);

      textPainter.paint(
        canvas,
        Offset(
          x,
          size.height - 10,
        ),
      );
    }

    // --------------------------------------------------------------
    // CURRENT VALUE LABEL
    // --------------------------------------------------------------

    final labelRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width - 78,
        82,
        68,
        43,
      ),
      const Radius.circular(9),
    );

    final labelPaint = Paint()
      ..color = Colors.white;

    canvas.drawRRect(
      labelRect,
      labelPaint,
    );

    final shadowPaint = Paint()
      ..color = const Color(0x18000000);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width - 79,
          83,
          70,
          44,
        ),
        const Radius.circular(9),
      ),
      shadowPaint,
    );

    canvas.drawRRect(
      labelRect,
      labelPaint,
    );

    final valuePainter = TextPainter(
      text: const TextSpan(
        text: '68.4 kg',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF363941),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    valuePainter.layout();

    valuePainter.paint(
      canvas,
      Offset(
        size.width - 71,
        95,
      ),
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}