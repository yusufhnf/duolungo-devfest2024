import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get geminiApiKey =>
      dotenv.env['GEMINI_API_KEY'] ?? 'API_KEY not found';
}
