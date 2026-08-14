import 'package:flutter/material.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  static const Color primaryBlue = Color(0xFF4B4BD6);
  static const Color darkText = Color(0xFF182033);
  static const Color greyText = Color(0xFF777C88);
  static const Color aiBubble = Color(0xFFD8E2FF);
  static const Color userBubble = Color(0xFFF5F5F7);

  final List<Map<String, String>> messages = [
    {
      'type': 'user',
      'text': 'Hi TERA, can you help me\nunderstand my health?',
    },
    {
      'type': 'ai',
      'text':
          'Of course! 👋 I can help you\nunderstand your health\ninformation, explain your health\nreports, and answer general\nhealth questions.',
    },
    {
      'type': 'user',
      'text':
          'My heart rate is 78 BPM. What does\nit mean?',
    },
    {
      'type': 'ai',
      'text':
          'A heart rate reading can vary\ndepending on activity and other\nfactors. I can help you\nunderstand the reading in\ncontext.',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'type': 'user',
        'text': text,
      });
    });

    _messageController.clear();

    // Temporary MVP response
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      setState(() {
        messages.add({
          'type': 'ai',
          'text':
              'I understand. I can help you understand this health information in a simple way.',
        });
      });

      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ============================================================
  // PREDEFINED ACTION
  // ============================================================

  void _predefinedAction(String action) {
    setState(() {
      messages.add({
        'type': 'user',
        'text': action,
      });

      messages.add({
        'type': 'ai',
        'text': _getPredefinedResponse(action),
      });
    });

    _scrollToBottom();
  }

  String _getPredefinedResponse(String action) {
    switch (action) {
      case 'Analyze Heart Data':
        return 'Your heart rate data can be understood by looking at your resting heart rate, activity level, and recent trends.';

      case 'Analyze SpO₂':
        return 'SpO₂ represents the percentage of oxygen saturation in your blood. I can help you understand your recorded values and trends.';

      case 'Analyze Temperature':
        return 'Body temperature can change throughout the day. I can help you understand your recorded temperature readings.';

      case 'Explain Health Report':
        return 'Upload or scan your health report and I can explain the information in simpler terms.';

      default:
        return 'I can help you understand this health information.';
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      body: SafeArea(
        child: Column(
          children: [
            _header(),

            _educationBanner(),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  15,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return _messageBubble(
                    message['type']!,
                    message['text']!,
                  );
                },
              ),
            ),

            _inputArea(),

            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _header() {
    return Container(
      height: 57,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE7E8EF),
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: primaryBlue,
          ),

          const Spacer(),

          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TERA AI',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: primaryBlue,
                ),
              ),
              Text(
                'Your Health Assistant',
                style: TextStyle(
                  fontSize: 13,
                  color: darkText,
                ),
              ),
            ],
          ),

          const Spacer(),

          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEDEFF7),
                ),
                child: const Icon(
                  Icons.face_rounded,
                  color: Color(0xFFB9BCC8),
                  size: 27,
                ),
              ),

              Positioned(
                right: 1,
                bottom: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF20C997),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EDUCATION BANNER
  // ============================================================

  Widget _educationBanner() {
    return Container(
      width: double.infinity,
      height: 34,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFDCE5FF),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFC7D3F5),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 15,
            color: Color(0xFF183C76),
          ),
          SizedBox(width: 5),
          Text(
            'Educational guidance only. Not medical advice.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF294B78),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MESSAGE BUBBLE
  // ============================================================

  Widget _messageBubble(
    String type,
    String text,
  ) {
    final bool isAI = type == 'ai';

    return Align(
      alignment:
          isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          mainAxisAlignment:
              isAI ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (isAI) ...[
              Container(
                width: 34,
                height: 34,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],

            Flexible(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 290,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isAI ? aiBubble : userBubble,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft:
                        Radius.circular(isAI ? 5 : 16),
                    bottomRight:
                        Radius.circular(isAI ? 16 : 5),
                  ),
                  border: isAI
                      ? null
                      : Border.all(
                          color: const Color(0xFFD0D1D8),
                        ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.45,
                        color: darkText,
                      ),
                    ),

                    if (isAI &&
                        text.contains(
                          'understand the reading',
                        ))
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _actionButton(
                          'Analyze Heart Data',
                          Icons.monitor_heart_outlined,
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

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _actionButton(
    String title,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () => _predefinedAction(title),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: primaryBlue,
            ),
            const SizedBox(width: 7),
            Text(
              title,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INPUT AREA
  // ============================================================

  Widget _inputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        12,
      ),
      color: Colors.white,
      child: Container(
        height: 62,
        padding: const EdgeInsets.only(
          left: 18,
          right: 7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: const Color(0xFFC9CBD4),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: const InputDecoration(
                  hintText: 'Ask TERA anything...',
                  hintStyle: TextStyle(
                    color: Color(0xFF8A8D98),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            const Icon(
              Icons.camera_alt_outlined,
              color: Color(0xFF686B75),
              size: 23,
            ),

            const SizedBox(width: 13),

            const Icon(
              Icons.mic_none_rounded,
              color: Color(0xFF686B75),
              size: 24,
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _bottomNavigation() {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            Icons.smart_toy_outlined,
            'AI',
            true,
          ),
          _navItem(
            Icons.favorite_border,
            'Health',
            false,
          ),
          _navItem(
            Icons.home_outlined,
            'Home',
            false,
          ),
          _navItem(
            Icons.watch_outlined,
            'Devices',
            false,
          ),
          _navItem(
            Icons.person_outline,
            'Profile',
            false,
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    bool selected,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 23,
          color: selected
              ? const Color(0xFF41414A)
              : const Color(0xFF4D515A),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                selected ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF3F424B),
          ),
        ),
      ],
    );
  }
}