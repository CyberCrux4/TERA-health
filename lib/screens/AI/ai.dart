import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:tera_health/screens/devices/devices_page.dart';
import 'package:tera_health/screens/health/health_page.dart';
import 'package:tera_health/screens/home/home.dart';

import '../../services/ai_services.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // ============================================================
  // SPEECH TO TEXT
  // ============================================================

  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  bool _isLoading = false;

  String _voiceText = '';

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryBlue = Color(0xFF4B4BD6);
  static const Color darkText = Color(0xFF182033);
  static const Color greyText = Color(0xFF777C88);
  static const Color aiBubble = Color(0xFFD8E2FF);
  static const Color userBubble = Color(0xFFF5F5F7);

  // ============================================================
  // INITIAL MESSAGES
  // ============================================================

  final List<Map<String, String>> messages = [
    {
      'type': 'user',
      'text': 'Hi TERA, can you help me\nunderstand my health?',
    },
    {
      'type': 'ai',
      'text':
          'Of course! 👋 I can help you\n'
          'understand your health\n'
          'information, explain your health\n'
          'reports, and answer general\n'
          'health questions.',
    },
    {
      'type': 'user',
      'text': 'My heart rate is 78 BPM. What does\nit mean?',
    },
    {
      'type': 'ai',
      'text':
          'A heart rate reading can vary\n'
          'depending on activity and other\n'
          'factors. I can help you\n'
          'understand the reading in\n'
          'context.',
    },
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _speech.stop();
    super.dispose();
  }

  // ============================================================
  // VOICE INPUT
  // ============================================================

 Future<void> _toggleVoice() async {
  // ----------------------------------------------------------
  // STOP LISTENING
  // ----------------------------------------------------------

  if (_isListening) {
    try {
      await _speech.stop();
    } catch (e) {
      debugPrint('Speech stop error: $e');
    }

    if (!mounted) return;

    setState(() {
      _isListening = false;
    });

    return;
  }

  // ----------------------------------------------------------
  // INITIALIZE SPEECH
  // ----------------------------------------------------------

  try {
    final available = await _speech.initialize(
      onStatus: (status) {
        debugPrint('Speech status: $status');

        if (!mounted) return;

        if (status == 'done' ||
            status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) {
        debugPrint(
          'Speech error: ${error.errorMsg}',
        );

        if (!mounted) return;

        setState(() {
          _isListening = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Voice error: ${error.errorMsg}',
            ),
          ),
        );
      },
    );

    if (!available) {
      if (!mounted) return;

      setState(() {
        _isListening = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Speech recognition is not available on this device.',
          ),
        ),
      );

      return;
    }

    // ----------------------------------------------------------
    // START LISTENING
    // ----------------------------------------------------------

    if (!mounted) return;

    setState(() {
      _isListening = true;
      _voiceText = '';
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        final recognizedText =
            result.recognizedWords;

        setState(() {
          _voiceText = recognizedText;

          _messageController.text =
              recognizedText;

          _messageController.selection =
              TextSelection.fromPosition(
            TextPosition(
              offset: _messageController.text.length,
            ),
          );
        });
      },
    );
  } catch (e, stackTrace) {
    debugPrint('VOICE ERROR: $e');
    debugPrintStack(stackTrace: stackTrace);

    if (!mounted) return;

    setState(() {
      _isListening = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Could not start voice recognition: $e',
        ),
      ),
    );
  }
}
  // ============================================================
  // SEND MESSAGE
  // ============================================================

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      messages.add({
        'type': 'user',
        'text': text,
      });

      _isLoading = true;
    });

    _messageController.clear();

    _scrollToBottom();

    try {
      final response = await AiService.askAi(text);

      if (!mounted) return;

      setState(() {
        messages.add({
          'type': 'ai',
          'text': response,
        });

        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({
          'type': 'ai',
          'text':
              'Sorry, I could not process your request right now.',
        });

        _isLoading = false;
      });

      _scrollToBottom();
    }
  }

  // ============================================================
  // SCROLL
  // ============================================================

  void _scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (!_scrollController.hasClients) {
          return;
        }

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
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

            if (_isLoading)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 25,
                  bottom: 5,
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryBlue,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'TERA is thinking...',
                      style: TextStyle(
                        color: greyText,
                        fontSize: 13,
                      ),
                    ),
                  ],
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
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: primaryBlue,
            ),
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
          isAI
              ? Alignment.centerLeft
              : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 18,
        ),
        child: Row(
          mainAxisAlignment:
              isAI
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            if (isAI)
              Container(
                width: 34,
                height: 34,
                margin: const EdgeInsets.only(
                  right: 8,
                ),
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
                  color:
                      isAI
                          ? aiBubble
                          : userBubble,
                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        const Radius.circular(16),
                    topRight:
                        const Radius.circular(16),
                    bottomLeft:
                        Radius.circular(
                      isAI ? 5 : 16,
                    ),
                    bottomRight:
                        Radius.circular(
                      isAI ? 16 : 5,
                    ),
                  ),
                  border:
                      isAI
                          ? null
                          : Border.all(
                              color:
                                  const Color(
                                0xFFD0D1D8,
                              ),
                            ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      text.isEmpty
                          ? '...'
                          : text,
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
                        padding:
                            const EdgeInsets.only(
                          top: 12,
                        ),
                        child: _actionButton(
                          'Analyze Heart Data',
                          Icons
                              .monitor_heart_outlined,
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
      onTap: () =>
          _predefinedAction(title),
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize:
              MainAxisSize.min,
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
                fontWeight:
                    FontWeight.w500,
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
      padding:
          const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        12,
      ),
      color: Colors.white,
      child: Container(
        height: 62,
        padding:
            const EdgeInsets.only(
          left: 18,
          right: 7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(32),
          border: Border.all(
            color: const Color(
              0xFFC9CBD4,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller:
                    _messageController,
                textInputAction:
                    TextInputAction.send,
                onSubmitted:
                    (_) => _sendMessage(),
                decoration:
                    const InputDecoration(
                  hintText:
                      'Ask TERA anything...',
                  hintStyle:
                      TextStyle(
                    color:
                        Color(0xFF8A8D98),
                    fontSize: 15,
                  ),
                  border:
                      InputBorder.none,
                ),
              ),
            ),

            const Icon(
              Icons.camera_alt_outlined,
              color:
                  Color(0xFF686B75),
              size: 23,
            ),

            const SizedBox(width: 13),

            // ==================================================
            // MICROPHONE
            // ==================================================

            GestureDetector(
              onTap: _isLoading
                  ? null
                  : _toggleVoice,
              child: Icon(
                _isListening
                    ? Icons.mic_rounded
                    : Icons
                        .mic_none_rounded,
                color:
                    _isListening
                        ? primaryBlue
                        : const Color(
                            0xFF686B75,
                          ),
                size: 24,
              ),
            ),

            const SizedBox(width: 8),

            // ==================================================
            // SEND BUTTON
            // ==================================================

            GestureDetector(
              onTap:
                  _isLoading
                      ? null
                      : _sendMessage,
              child: Container(
                width: 40,
                height: 40,
                decoration:
                    const BoxDecoration(
                  color: primaryBlue,
                  shape:
                      BoxShape.circle,
                ),
                child:
                    _isLoading
                        ? const Padding(
                            padding:
                                EdgeInsets.all(
                              10,
                            ),
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color:
                                  Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons
                                .arrow_forward_rounded,
                            color:
                                Colors.white,
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
      decoration:
          const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E5EA),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            Icons.smart_toy_outlined,
            'AI',
            true,
            onTap: () {},
          ),

          _navItem(
            Icons.favorite_border,
            'Health',
            false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const HealthPage(),
                ),
              );
            },
          ),

          _navItem(
            Icons.home_outlined,
            'Home',
            false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const Home(),
                ),
              );
            },
          ),

          _navItem(
            Icons.watch_outlined,
            'Devices',
            false,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const DevicesPage(),
                ),
              );
            },
          ),

          _navItem(
            Icons.person_outline,
            'Profile',
            false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================

  Widget _navItem(
    IconData icon,
    String label,
    bool selected, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior:
          HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        height: 66,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23,
              color:
                  selected
                      ? primaryBlue
                      : const Color(
                          0xFF4D515A,
                        ),
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                color:
                    selected
                        ? primaryBlue
                        : const Color(
                            0xFF3F424B,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
