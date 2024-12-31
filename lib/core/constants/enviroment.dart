import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String tokenTMDB = dotenv.env['tokenTMDB'] ?? "Not found tokenTMDB";

  static String apiKeyTMDB = dotenv.env['apiKeyTMDB'] ?? "Not found apiKeyTMDB";

  static String themoviedbBaseUrl =
      dotenv.env['themoviedbBaseUrl'] ?? "Not found themoviedbBaseUrl";
}
