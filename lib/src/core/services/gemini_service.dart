import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeminiService {
  final GenerativeModel _client;

  GeminiService({required GenerativeModel client}) : _client = client;

  Future<String?> generateText(String prompt) async {
    final response = await _client.generateContent([Content.text(prompt)]);
    return response.text;
  }
}
