import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:ai_assistant/helper/global.dart';

class APIs {
  // Get answer from ChatGPT
  static Future<String> getAnswer(String question) async {
    try {
      final res = await post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
        ),

        // Headers
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},

        // Body
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": question},
              ],
            },
          ],
          "generationConfig": {"maxOutputTokens": 2000, "temperature": 0},
        }),
      );

      final data = jsonDecode(res.body);

      log('res: $data');
      return data['candidates']?[0]?['content']?['parts']?[0]?['text'];
    } catch (e) {
      log('getAnswerE: $e');
      return 'Something went wrong, please try again later.';
    }
  }
}
