import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const String baseUrl = "https://v6.exchangerate-api.com/v6";
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}