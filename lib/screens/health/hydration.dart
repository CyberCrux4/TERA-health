import 'package:flutter/material.dart';

class HydrationPage extends StatefulWidget {
  const HydrationPage({super.key});

  @override
  State<HydrationPage> createState() => _HydrationPageState();
}

class _HydrationPageState extends State<HydrationPage> {
  static const Color primary = Color(0xFF4B4BD9);
  static const Color blue = Color(0xFF0867C7);
  static const Color background = Color(0xFFF8F9FC);

  double waterIntake = 1.6;
  final double goal = 2.5;

  final List<Map<String, dynamic>> logs = [
    {
      'title': 'Glass of Water',
      'time': '2:30 PM',
      'amount': 250,
      'icon': Icons.water_drop_outlined,
    },
    {
      'title': 'Water Bottle',
      'time': '11:15 AM',
      'amount': 750,
      'icon': Icons.local_drink_outlined,
    },
    {
      'title': 'Morning Hydration',
      'time': '8:00 AM',
      'amount': 500,
      'icon': Icons.local_drink_outlined,
    },
  ];

  void _addWater(int amount) {
    setState(() {
      waterIntake += amount / 1000;

      if (waterIntake > goal) {
        waterIntake = goal;
      }

      logs.insert(0, {
        'title': amount == 250
            ? 'Glass of Water'
            : amount == 500
                ? 'Water Bottle'
                : 'Hydration',
        'time': _currentTime(),
        'amount': amount,
        'icon': Icons.water_drop_outlined,
      });
    });
  }

  String _currentTime() {
    final now = TimeOfDay.now();

    final hour = now.hourOfPeriod == 0
        ? 12
        : now.hourOfPeriod;

    final minute =
        now.minute.toString().padLeft(2, '0');

    final period =
        now.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _customAmount() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Water'),

          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount in mL',
              suffixText: 'mL',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final amount =
                    int.tryParse(controller.text);

                if (amount != null && amount > 0) {
                  _addWater(amount);
                }

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining =
        ((goal - waterIntake) * 1000)
            .round()
            .clamp(0, 99999);

    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            SizedBox(
              height: 70,

              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  children: [
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
                          'Water Intake',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        color: primary,
                        size: 23,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),

                padding: const EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  100,
                ),

                child: Column(
                  children: [
                    // =================================================
                    // WATER PROGRESS
                    // =================================================

                    _waterProgress(),

                    const SizedBox(height: 40),

                    // =================================================
                    // QUICK ADD
                    // =================================================

                    _quickAddCard(),

                    const SizedBox(height: 40),

                    // =================================================
                    // WEEKLY HYDRATION
                    // =================================================

                    _weeklyHydration(),

                    const SizedBox(height: 40),

                    // =================================================
                    // TODAY'S LOG
                    // =================================================

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Today's Log",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    ...logs.map(
                      (log) => _logCard(
                        title: log['title'],
                        time: log['time'],
                        amount: log['amount'],
                        icon: log['icon'],
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
  // WATER PROGRESS
  // ===============================================================

  Widget _waterProgress() {
    return Column(
      children: [
        SizedBox(
          width: 270,
          height: 210,

          child: CustomPaint(
            painter: WaterProgressPainter(
              progress:
                  (waterIntake / goal).clamp(0.0, 1.0),
            ),

            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Text(
                    '${waterIntake.toStringAsFixed(1)} L',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    'of ${goal.toStringAsFixed(1)} L goal',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),

        Builder(
          builder: (context) {
            final remaining =
                ((goal - waterIntake) * 1000)
                    .round();

            return Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 7,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFDCE5FF),
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Text(
                '$remaining mL remaining',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF30384D),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ===============================================================
  // QUICK ADD CARD
  // ===============================================================

  Widget _quickAddCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE3E4E8),
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Quick Add',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: _amountButton(
                  Icons.water_drop_outlined,
                  '250 mL',
                  250,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _amountButton(
                  Icons.local_drink_outlined,
                  '500 mL',
                  500,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _amountButton(
                  Icons.local_drink_outlined,
                  '750 mL',
                  750,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 55,

            child: ElevatedButton.icon(
              onPressed: _customAmount,

              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),

              label: const Text(
                'Custom Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 2,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // AMOUNT BUTTON
  // ===============================================================

  Widget _amountButton(
    IconData icon,
    String text,
    int amount,
  ) {
    return GestureDetector(
      onTap: () {
        _addWater(amount);
      },

      child: Container(
        height: 84,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(13),

          border: Border.all(
            color: const Color(0xFFD0D1D7),
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Icon(
              icon,
              color: blue,
              size: 24,
            ),

            const SizedBox(height: 8),

            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // WEEKLY HYDRATION
  // ===============================================================

  Widget _weeklyHydration() {
    final values = [
      0.75,
      0.55,
      0.88,
      0.95,
      0.72,
      0.38,
      0.60,
    ];

    final days = [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE5E5E9),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Weekly\nHydration',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ),

              const Text(
                'Avg 2.1 L /\nday',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF555861),
                  height: 1.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          SizedBox(
            height: 130,

            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,

              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: List.generate(
                values.length,
                (index) {
                  return Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end,

                    children: [
                      Container(
                        width: 35,
                        height: 100,

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFDDE6FF),
                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        alignment:
                            Alignment.bottomCenter,

                        child: FractionallySizedBox(
                          heightFactor:
                              values[index],
                          widthFactor: 1,

                          child: Container(
                            decoration:
                                const BoxDecoration(
                              color: blue,
                              borderRadius:
                                  BorderRadius.vertical(
                                top: Radius.circular(18),
                                bottom:
                                    Radius.circular(18),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        days[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: index == 6
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: index == 6
                              ? primary
                              : Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // LOG CARD
  // ===============================================================

  Widget _logCard({
    required String title,
    required String time,
    required int amount,
    required IconData icon,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: const Color(0xFFD4D5DA),
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: const BoxDecoration(
              color: Color(0xFFDCE6FF),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: blue,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF555861),
                  ),
                ),
              ],
            ),
          ),

          Text(
            '+$amount mL',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: primary,
            ),
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
        : const Color(0xFF777A82);

    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,

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
// WATER PROGRESS PAINTER
// ===============================================================

class WaterProgressPainter extends CustomPainter {
  final double progress;

  WaterProgressPainter({
    required this.progress,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF0867C7)
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center =
        Offset(size.width / 2, size.height / 2);

    const double radius = 95;

    // TOP
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -2.0,
      0.55,
      false,
      paint,
    );

    // LEFT
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      2.8,
      0.55,
      false,
      paint,
    );

    // RIGHT
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      0.1,
      0.55,
      false,
      paint,
    );

    // BOTTOM
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      1.15,
      0.55,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant WaterProgressPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress;
  }
}