import 'package:flutter/material.dart';

class TeraInsightsPage extends StatelessWidget {
  const TeraInsightsPage({super.key});

  static const Color primary = Color(0xFF4B4BD8);
  static const Color textDark = Color(0xFF202124);
  static const Color grey = Color(0xFF737782);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
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
                      color: primary,
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'TERA Insights',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: primary,
                        ),
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.notifications_none,
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
                  10,
                  20,
                  100,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // AI SUMMARY
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5B5BE2),
                            Color(0xFF2867D8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 21,
                                backgroundColor:
                                    Color(0x55FFFFFF),
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'AI SUMMARY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Text(
                            'Overall Status: Optimal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 14),

                          Text(
                            'Your health patterns are remarkably stable today. You have reached 90% of your hydration goal and your sleep quality has improved by 15% compared to last week.',
                            style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      "Today's Observations",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _insightCard(
                      Icons.nightlight_round,
                      const Color(0xFFDDE5FF),
                      const Color(0xFF182A72),
                      'Sleep Improvement',
                      'Your deep sleep was 45 minutes longer than your 7-day average. This correlates with your lower evening heart rate.',
                    ),

                    _insightCard(
                      Icons.directions_walk,
                      const Color(0xFF69E8B5),
                      const Color(0xFF064B35),
                      'Activity Lead',
                      'You are 1,200 steps ahead of your usual Tuesday pace. Keep it up to reach your 10k goal early!',
                    ),

                    _insightCard(
                      Icons.water_drop,
                      const Color(0xFFD8E6FF),
                      const Color(0xFF1454A3),
                      'Hydration Alert',
                      'Your water intake is slightly behind schedule. Drinking 2 glasses now will put you back on track.',
                    ),

                    _insightCard(
                      Icons.favorite,
                      const Color(0xFFFFD9DE),
                      const Color(0xFFB61F35),
                      'Heart Rate Stability',
                      'Your resting heart rate has remained stable at 65 BPM for 3 consecutive days, indicating good cardiovascular recovery.',
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'Recommended Actions',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _recommendationCard(
                      Icons.nightlight_round,
                      'Early Rest',
                      'Based on your high activity today, we recommend going to bed by 10:30 PM for optimal recovery.',
                      'Set Reminder',
                    ),

                    _recommendationCard(
                      Icons.local_drink_outlined,
                      'Hydration Boost',
                      'Drink 500ml of water in the next hour.',
                      'Log Water',
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

  Widget _insightCard(
    IconData icon,
    Color iconBackground,
    Color iconColor,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDADBE2),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
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
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF555861),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationCard(
    IconData icon,
    String title,
    String description,
    String buttonText,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F2F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xFFE1E5FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: primary,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            description,
            style: const TextStyle(
              height: 1.45,
              color: Color(0xFF555861),
            ),
          ),

          const SizedBox(height: 14),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: primary,
              side: const BorderSide(
                color: Color(0xFFD5D7E8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  
}

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
            fontWeight:
                selected
                    ? FontWeight.w700
                    : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}