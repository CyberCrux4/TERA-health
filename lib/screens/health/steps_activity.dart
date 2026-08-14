import 'package:flutter/material.dart';

class StepsActivityPage extends StatelessWidget {
  const StepsActivityPage({super.key});

  static const Color primary = Color(0xFF4B4BD8);
  static const Color bg = Color(0xFFF7F8FC);
  static const Color textDark = Color(0xFF202124);
  static const Color grey = Color(0xFF737782);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
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
                      size: 25,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'Steps & Activity',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.share_outlined,
                    color: primary,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  15,
                  20,
                  100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODAY
                    const Center(
                      child: Text(
                        'TODAY',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: grey,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        '8,800',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          color: primary,
                        ),
                      ),
                    ),

                    const Center(
                      child: Text(
                        'steps',
                        style: TextStyle(
                          fontSize: 17,
                          color: grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F8EF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '88% of 10,000 goal',
                          style: TextStyle(
                            color: Color(0xFF16845F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // PROGRESS CARD
                    _card(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Daily Goal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 18),

                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              value: 0.88,
                              minHeight: 13,
                              backgroundColor:
                                  Color(0xFFE4E5F5),
                              valueColor:
                                  AlwaysStoppedAnimation(
                                primary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '8,800 steps',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '10,000',
                                style: TextStyle(
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ACTIVITY SUMMARY
                    const Text(
                      'Activity Summary',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            Icons.local_fire_department,
                            'Calories',
                            '384',
                            'kcal',
                            const Color(0xFFFFE1E5),
                            Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statCard(
                            Icons.route,
                            'Distance',
                            '6.2',
                            'km',
                            const Color(0xFFDDE7FF),
                            primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            Icons.timer_outlined,
                            'Active Time',
                            '54',
                            'min',
                            const Color(0xFFE4F8F1),
                            const Color(0xFF159A70),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statCard(
                            Icons.speed,
                            'Avg Pace',
                            '8.4',
                            'min/km',
                            const Color(0xFFFFEBD7),
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    // WEEKLY ACTIVITY
                    const Text(
                      'Weekly Activity',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _card(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Average',
                                style: TextStyle(
                                  color: grey,
                                ),
                              ),
                              Text(
                                '7,420 steps/day',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          SizedBox(
                            height: 150,
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                _bar('M', 0.65),
                                _bar('T', 0.82),
                                _bar('W', 0.58),
                                _bar('T', 0.88),
                                _bar('F', 0.72),
                                _bar('S', 0.48),
                                _bar('S', 0.88),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ACTIVITY INSIGHT
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF0FF),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: primary,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'You are doing great! You are close to your daily step goal. A short evening walk can help you reach 10,000 steps.',
                              style: TextStyle(
                                height: 1.45,
                                color: Color(0xFF40436A),
                              ),
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

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE1E2E8),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _statCard(
    IconData icon,
    String title,
    String value,
    String unit,
    Color background,
    Color iconColor,
  ) {
    return Container(
      height: 135,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE1E2E8),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: grey,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 11,
                  color: grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(String day, double value) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.end,
      children: [
        Container(
          width: 27,
          height: 105 * value,
          decoration: BoxDecoration(
            color: primary,
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          day,
          style: const TextStyle(
            fontSize: 12,
            color: grey,
          ),
        ),
      ],
    );
  }

 
    

  }
