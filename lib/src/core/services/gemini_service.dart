import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _client;

  GeminiService(this._client);

  Future<String?> generateText(String prompt) async {
    final response = await _client.generateContent([Content.text(prompt)]);
    return response.text;
  }
}
