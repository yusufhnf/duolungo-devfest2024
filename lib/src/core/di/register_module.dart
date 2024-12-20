import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import '../env/env.dart';

@module
abstract class RegisterModule {
  GenerativeModel get client => GenerativeModel(
        apiKey: EnvConfig.geminiApiKey,
        model: 'gemini-1.5-flash-latest',
      );
}
