import 'package:flutter/material.dart';

class SleepTrackingPage extends StatelessWidget {
  const SleepTrackingPage({super.key});

  static const Color primary = Color(0xFF4B4BD8);
  static const Color background = Color(0xFFF7F8FA);
  static const Color darkText = Color(0xFF20222A);
  static const Color greyText = Color(0xFF6D7078);

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
                              'Sleep',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.share_outlined,
                          size: 24,
                          color: Color(0xFF555861),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // SLEEP STATUS
                    // =================================================

                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Good',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Center(
                      child: Text(
                        '7h 32m',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Center(
                      child: Text(
                        'Total Sleep',
                        style: TextStyle(
                          fontSize: 17,
                          color: greyText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 38),

                    // =================================================
                    // TIMELINE CARD
                    // =================================================

                    _timelineCard(),

                    const SizedBox(height: 38),

                    // =================================================
                    // STAGES
                    // =================================================

                    const Text(
                      'Stages',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _stageCard(
                            'Awake',
                            '22m',
                            '5%',
                            const Color(0xFFFFD8D8),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _stageCard(
                            'REM',
                            '1h 30m',
                            '20%',
                            const Color(0xFF08784F),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _stageCard(
                            'Light',
                            '2h 15m',
                            '30%',
                            primary,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: _stageCard(
                            'Deep',
                            '3h 25m',
                            '45%',
                            const Color(0xFF2878DF),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 38),

                    // =================================================
                    // THIS WEEK
                    // =================================================

                    _weeklyCard(),

                    const SizedBox(height: 38),

                    // =================================================
                    // PREVIOUS NIGHTS
                    // =================================================

                    const Text(
                      'Previous Nights',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _previousNight(
                      'Last Night',
                      'Aug 12',
                      '7h 32m',
                      true,
                    ),

                    const SizedBox(height: 12),

                    _previousNight(
                      'Wednesday',
                      'Aug 11',
                      '6h 45m',
                      false,
                    ),

                    const SizedBox(height: 12),

                    _previousNight(
                      'Tuesday',
                      'Aug 10',
                      '5h 10m',
                      false,
                    ),
                  ],
                ),
              ),
            ),

            // =========================================================
            // BOTTOM NAVIGATION
            // =========================================================

            
          ],
        ),
      ),
    );
  }

  // ================================================================
  // TIMELINE CARD
  // ================================================================

  Widget _timelineCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE7E8EC),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [
              Icon(
                Icons.access_time,
                color: primary,
                size: 23,
              ),
              SizedBox(width: 9),
              Text(
                'Timeline',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color(0xFFFFD9D9),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: primary,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: const Color(0xFF2878DF),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: const Color(0xFF08784F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '10:45 PM',
                style: TextStyle(
                  fontSize: 13,
                  color: greyText,
                ),
              ),
              Text(
                '6:17 AM',
                style: TextStyle(
                  fontSize: 13,
                  color: greyText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Wrap(
            spacing: 15,
            runSpacing: 8,
            children: [
              _Legend(
                color: Color(0xFFFFD9D9),
                text: 'Awake',
              ),
              _Legend(
                color: Color(0xFF08784F),
                text: 'REM',
              ),
              _Legend(
                color: primary,
                text: 'Light',
              ),
              _Legend(
                color: Color(0xFF2878DF),
                text: 'Deep',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // STAGE CARD
  // ================================================================

  Widget _stageCard(
    String title,
    String value,
    String percentage,
    Color dotColor,
  ) {
    return Container(
      height: 124,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE7E8EC),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: greyText,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            percentage,
            style: const TextStyle(
              fontSize: 13,
              color: greyText,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // WEEKLY CARD
  // ================================================================

  Widget _weeklyCard() {
    final values = [
      0.55,
      0.72,
      0.43,
      0.86,
      0.12,
      0.08,
      0.08,
    ];

    final labels = [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        24,
        22,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE7E8EC),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'This Week',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: List.generate(
                values.length,
                (index) {
                  final isSelected = index == 3;

                  return Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [

                      Container(
                        width: 32,
                        height: 120 * values[index],
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primary
                              : const Color(0xFFE0E2FF),
                          borderRadius:
                              const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: greyText,
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

  // ================================================================
  // PREVIOUS NIGHTS
  // ================================================================

  Widget _previousNight(
    String title,
    String date,
    String duration,
    bool selected,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E6EA),
        ),
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          Text(
            duration,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: selected
                  ? primary
                  : darkText,
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

// ================================================================
// LEGEND
// ================================================================

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666970),
          ),
        ),
      ],
    );
  }
}