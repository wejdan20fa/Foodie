/// Configuration for local demonstrations only.
///
/// Do not commit real credentials. `--dart-define` values may be extracted from
/// released client applications, so use a trusted backend for production keys.
class ApiConfig {
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const String spoonacularApiKey = String.fromEnvironment('SPOONACULAR_API_KEY');
}
