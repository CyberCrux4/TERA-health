import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  static String get apiKey {
    return dotenv.env['GEMINI_API_KEY']?.trim() ?? '';
  }

  // Use the model that is actually available for your API key.
  static const String model = 'gemini-3.6-flash';

  static Future<String> askAi(String message) async {
    final key = apiKey;

    if (key.isEmpty) {
      return 'Gemini API key is not configured yet.';
    }

    final Uri url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/'
      '$model:generateContent?key=$key',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': '''
You are TERA AI, a friendly health education assistant.

Help users understand general health information.

Rules:
- Give simple explanations.
- Do not diagnose diseases.
- Do not prescribe medicines.
- Do not replace a doctor.
- For serious/emergency symptoms, recommend immediate medical help.
- Keep responses short and clear.

User question:
$message
''',
                }
              ],
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 300,
          },
        }),
      );

      print('Gemini Status: ${response.statusCode}');
      print('Gemini Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final candidates = data['candidates'];

        if (candidates is List && candidates.isNotEmpty) {
          final parts =
              candidates[0]['content']?['parts'];

          if (parts is List && parts.isNotEmpty) {
            final text = parts[0]['text'];

            if (text != null &&
                text.toString().trim().isNotEmpty) {
              return text.toString().trim();
            }
          }
        }

        return 'I could not generate a response.';
      }

      try {
        final errorData = jsonDecode(response.body);

        final errorMessage =
            errorData['error']?['message'];

        return 'Gemini error: ${errorMessage ?? 'Unknown API error'}';
      } catch (_) {
        return 'Gemini request failed.';
      }
    } catch (e) {
      print('Gemini Exception: $e');

      return 'Unable to connect to TERA AI.';
    }
  }
}