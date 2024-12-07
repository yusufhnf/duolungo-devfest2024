import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/gemini_service.dart';
import '../env/env_config.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<GenerativeModel>(
    () => GenerativeModel(
        apiKey: EnvConfig.geminiApiKey, model: 'gemini-1.5-flash-latest'),
  );
  locator.registerLazySingleton<GeminiService>(
    () => GeminiService(locator<GenerativeModel>()),
  );
}
