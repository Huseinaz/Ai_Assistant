import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ai_assistant/helper/global.dart';

class APIs {
  static Future<dynamic> getAnswer(
    String question, {
    bool generateImage = false,
  }) async {
    try {
      String url;
      Map<String, dynamic> bodyData;

      if (generateImage) {
        url =
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-preview-image-generation:generateContent?key=$apiKey';

        bodyData = {
          "contents": [
            {
              "parts": [
                {"text": "Generate a high-quality image of: $question"},
              ],
            },
          ],
          "generationConfig": {
            "responseModalities": ["TEXT", "IMAGE"],
          },
        };
      } else {
        url =
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

        // Request body for text generation
        bodyData = {
          "contents": [
            {
              "parts": [
                {"text": question},
              ],
            },
          ],
          "generationConfig": {"maxOutputTokens": 2000, "temperature": 0},
        };
      }

      final res = await post(
        Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode(bodyData),
      );

      final data = jsonDecode(res.body);

      if (data['error'] != null) {
        final errorMessage = data['error']['message'] ?? 'Unknown API error';
        return 'API Error: $errorMessage';
      }

      if (generateImage) {
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final content = data['candidates'][0]['content'];
          if (content != null &&
              content['parts'] != null &&
              content['parts'].isNotEmpty) {
            for (var part in content['parts']) {
              if (part['inlineData'] != null &&
                  part['inlineData']['mimeType'] != null &&
                  part['inlineData']['data'] != null) {
                return part['inlineData']['data'];
              }
            }
          }
        }
        return null;
      } else {
        return data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      }
    } on SocketException {
      return 'Something went wrong: Please check your internet connection.';
    } on ClientException {
      return 'Something went wrong: Failed to connect to the server.';
    } catch (e) {
      return 'Something went wrong: An unexpected error occurred.';
    }
  }
}
