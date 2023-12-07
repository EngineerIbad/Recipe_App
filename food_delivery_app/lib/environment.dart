import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => "lib/keys/api_key.env";


  static String get apiKey => dotenv.get("API_KEY");
}
